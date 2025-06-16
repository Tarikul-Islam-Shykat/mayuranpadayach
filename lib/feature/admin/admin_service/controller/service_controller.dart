import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/core/services_class/local_service/local_data.dart';
import 'package:prettyrini/feature/admin/admin_service/model/all_service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/global_widegts/app_snackbar.dart';
import '../../../../route/route.dart';


class ServiceController extends GetxController{
  Rx<TextEditingController> serviceNameTEC = TextEditingController().obs;
  Rx<TextEditingController> servicePriceTEC = TextEditingController().obs;
  Rx<TextEditingController> offerPercentTEC = TextEditingController().obs;
  RxList<ServiceModel> serviceModel = <ServiceModel>[].obs;
  Rx<ServiceModel?> selectedService = Rx<ServiceModel?>(null);
  final NetworkConfig _networkConfig = NetworkConfig();
  final scrollController = ScrollController();

  RxBool isLoadingService = false.obs;
  RxBool isLoadingCreate = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isEditing = false.obs;
  RxBool isActive = true.obs;
  RxBool isOffered = false.obs;
  RxBool hasMore = true.obs;
  RxString imageSizeText = ''.obs;
  RxString errorMessage = "".obs;
  RxString serviceImageUrl = ''.obs;
  RxString editingServiceId = ''.obs;
  RxString businessId = ''.obs;
  var uploadProgress = 0.0.obs;
  var page = 1.obs;
  final _picker = ImagePicker();
  Rx<File?> serviceImage = Rx<File?>(null);

  @override
  onInit(){
    super.onInit();
    businessId.value = Get.arguments?["id"]??"";
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent && hasMore.value && serviceModel.length >= 10) {
        getAllService(businessId.value);
      }
    });
    getAllService(businessId.value.toString());
  }


  //service create
  Future<void> pickImageProfile()async{
    try{
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        File imageFile = File(pickedFile.path);
        // Compress the image
        File? compressedImage = await _compressImage(imageFile);
        if(compressedImage != null){
          serviceImage.value = compressedImage;
          await _imageSizeText(compressedImage);
          errorMessage.value ='';
          AppSnackbar.show(
            message: "image selected successfully",
            isSuccess: true,
          );
        }else{
          errorMessage.value = 'Failed to compress image';
        }
      }
    }catch(e){
      log("Error picking image: $e");
      errorMessage.value = 'Failed to select image: ${e.toString()}';
    }
  }
  Future<void> pickImageFormCamera()async{
    try{
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if(pickedFile != null){
        File imageFile = File(pickedFile.path);

        // Compress the image
        File? compressedImage = await _compressImage(imageFile);
        if(compressedImage != null){
          serviceImage.value = compressedImage;
          await _imageSizeText(compressedImage);
          errorMessage.value = '';
          AppSnackbar.show(
            message: "Image captured successfully",
            isSuccess: true,
          );
        }else{
          errorMessage.value = 'Failed to compress image';
        }
      }
    }catch(e){
      log("Error capturing profile image: $e");
      errorMessage.value = 'Failed to capture image: ${e.toString()}';
    }
  }
  Future<File?> _compressImage(File imageFile)async{
    try{
      int originalSize = await imageFile.length();
      log("Original image size: ${(originalSize / 1024).toStringAsFixed(2)} KB");

      //if image already under 250KB
      if(originalSize <= 250 * 1024){
        return imageFile;
      }

      //compress image
      String targetPath = imageFile.path.replaceAll('.jpg', '_compressed.jpg').replaceAll(".jpeg", "_compressed.jpeg").replaceAll("PNG", "_compressed.jpg");
      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 800, // Maximum width
        minHeight: 800, // Maximum height
        quality: 85, // Start with 85% quality
        format: CompressFormat.jpeg,
      );
      if(compressedBytes == null){
        log("Failed to compress image");
        return null;
      }
      // If still too large, try with lower quality
      int currentSize = compressedBytes.length;
      int quality = 85;
      while(currentSize > 250 * 1024 && quality >50){
        quality -= 10;
        log("Trying with quality: $quality");
        compressedBytes = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 600,
          minHeight: 600,
          quality: quality,
          format: CompressFormat.jpeg,
        );
        if(compressedBytes != null){
          currentSize = compressedBytes.length;
        }else{
          break;
        }
      }
      if (compressedBytes == null) {
        log("Failed to compress image to required size");
        return null;
      }

      //convert compress image to file
      File compressFile = File(targetPath);
      await compressFile.writeAsBytes(compressedBytes);
      final finalSize = compressedBytes.length;
      log("Compressed image size: ${(finalSize / 1024).toStringAsFixed(2)} KB");
      return compressFile;


    }catch(e){
      log("Error compressing image: $e");
      return null;
    }

  }
  Future<void> _imageSizeText(File imageFile)async{
    try{
      int sizeInBytes = await imageFile.length();
      double sizeInKB = sizeInBytes / 1024;
      if(sizeInKB <1024){
        imageSizeText.value = "${sizeInKB.toStringAsFixed(1)} KB";
      }else{
        double sizeInMB = sizeInKB/1024;
        imageSizeText.value = "${sizeInMB.toStringAsFixed(1)} MB";
      }
    }catch(e){
      imageSizeText.value = "Size unknown";
    }

  }

  Future<bool> createService(id)async{
    if (serviceImage.value == null) {
      errorMessage.value = 'Please select a Image';
      return false;
    }
    try{
      isLoadingCreate.value = true;
      errorMessage.value = '';
      uploadProgress.value = 0.0;
      final request = http.MultipartRequest("POST", Uri.parse(Urls.serviceCreate),);
      SharedPreferences sh = await SharedPreferences.getInstance();
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });

      Map<String, dynamic> data = {
        "name":serviceNameTEC.value.text,
        "price":double.parse(servicePriceTEC.value.text),
        "businessId":id.toString(),
      };
      request.fields['data'] = json.encode(data);
      debugPrint("response body------- $data");

      var imageBytes  = await serviceImage.value!.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'image', // Field name for image as shown in Postman
        imageBytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      request.files.add(multipartFile);

      // Send request with progress tracking
      var streamedResponse = await request.send();

      for(int i = 0 ; i<=100; i += 10){
        uploadProgress.value = i.toDouble();
        await Future.delayed(Duration(milliseconds: 50));
      }
      final response = await http.Response.fromStream(streamedResponse);
      final responseJson = json.decode(response.body);

      log("Image upload response: $responseJson");
      log("Status code: ${response.statusCode}");
      if(response.statusCode == 201 && responseJson['success'] == true){

        page.value = 1;
        hasMore.value = true;
        getAllService(businessId.value.toString());
        update();
        allClear();
        Get.back();
        log("just id============${businessId.value.toString()}");
        AppSnackbar.show(
          message: "Add Service successfully!",
          isSuccess: true,
        );
        return true;

      }else{
        errorMessage.value = responseJson['message'] ?? 'Upload failed';
        log("Upload failed: ${responseJson['message']}");
        return false;
      }

    }catch(e){
      log("add service error: $e");
      errorMessage.value = 'Upload failed: ${e.toString()}';
      return false;
    }finally{
      isLoadingCreate.value = false;
    }
  }


  Future<bool> editService(businessId,serviceId)async{
    if (serviceImage.value == null) {
      errorMessage.value = 'Please select a Image';
      return false;
    }
    try{
      isLoadingCreate.value = true;
      errorMessage.value = '';
      uploadProgress.value = 0.0;
      final request = http.MultipartRequest("PUT", Uri.parse("${Urls.serviceEdit}/$serviceId"),);
      SharedPreferences sh = await SharedPreferences.getInstance();
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });
      // Create the JSON data for the data field
      Map<String, dynamic> data = {
        "name":serviceNameTEC.value.text,
        "price":double.parse(servicePriceTEC.value.text),
        "businessId":businessId.toString(),
        "isActive":isActive.value,
        "isOffered": isOffered.value,
        "offeredPercent": isOffered.value
            ? int.tryParse(offerPercentTEC.value.text) ?? 0
            : 0,
      };
      request.fields['data'] = json.encode(data);
      debugPrint("response body------- $data");
      var imageBytes  = await serviceImage.value!.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'image', // Field name for image as shown in Postman
        imageBytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      request.files.add(multipartFile);

      // Send request with progress tracking
      var streamedResponse = await request.send();

      for(int i = 0 ; i<=100; i += 10){
        uploadProgress.value = i.toDouble();
        await Future.delayed(Duration(milliseconds: 50));
      }
      final response = await http.Response.fromStream(streamedResponse);
      final responseJson = json.decode(response.body);

      log("Image upload response: $responseJson");
      log("Status code: ${response.statusCode}");
      if(response.statusCode == 201 || response.statusCode == 200 && responseJson['success'] == true){
        getAllService(businessId.toString());
        update();
        hasMore.value = true;
        log("id then Editing business ----$businessId");
        log("id then Editing business ----$businessId");
        allClear();
        Get.back();
        AppSnackbar.show(
          message: "Image uploaded successfully!",
          isSuccess: true,
        );
        return true;

      }else{
        errorMessage.value = responseJson['message'] ?? 'Upload failed';
        log("Upload failed: ${responseJson['message']}");
        return false;
      }

    }catch(e){
      log("Profile picture upload error: $e");
      errorMessage.value = 'Upload failed: ${e.toString()}';
      return false;
    }finally{
      isLoadingCreate.value = false;
    }
  }

  void setEditServiceData(ServiceModel service) {
    isEditing.value = true;
    editingServiceId.value = service.id.toString()??"";
    serviceNameTEC.value.text = service.name ?? '';
    servicePriceTEC.value.text = service.price.toString();
    isActive.value = service.isActive ?? true;
    isOffered.value = service.isOffered ?? true;
    offerPercentTEC.value.text = service.offeredPercent?.toString() ?? '';

    if (service.image != null) {
      serviceImageUrl.value = service.image!;
      serviceImage.value = null;
    }
  }


  Future<bool> getAllService(id)async{
    if(isLoadingService.value || !hasMore.value){
      return false;
    }
    isLoadingService.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(
          RequestMethod.GET,
          "${Urls.allServiceGet}/$id?page=${page.value}&limit=10",{},is_auth: true);
      log("service response  $response");
      if(response != null && response["success"] == true){
        log("service get success");
        List dataList = response["data"]["data"];
        if(dataList.isEmpty){
          hasMore.value = false;
        }else{
          List<ServiceModel> serviceData = dataList.map((e)=>ServiceModel.fromJson(e)).toList();
          if (serviceData.isEmpty || serviceData.length < 10) {
            hasMore.value = false;
          }
          serviceModel.addAll(serviceData);
          page.value ++;
        }
        return true;
      }else{
        debugPrint("get service failed message: ${response["message"]}");
        return false;
      }


    }catch(e){
      log("Error in getAllService $e");
    }finally{
      isLoadingService.value = false;
    }
    return false;
  }
  
  //Delete service 
  Future<bool> deleteService(String id)async{
    try{
      isLoadingDelete.value = true;
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.DELETE, "${Urls.serviceDelete}/$id", {},is_auth: true);
      log("response $response");
      log("response Id--- $id");

      if(response != null && response['success']== true){
        getAllService(businessId.value.toString());
        log("business Id ---${businessId.toString()}");
        update();
        AppSnackbar.show(
          message: "Delete successfully!",
          isSuccess: true,
        );
        return true;
      }else{
        log("Delete Response Failed${response["message"]}");
        return false;
      }
    }catch(e){
      log("Delete Response Error :$e");
      return false;
    }finally{
      isLoadingDelete.value= false;
    }

  }


  void allClear() {
    serviceNameTEC.value.clear();
    servicePriceTEC.value.clear();
    offerPercentTEC.value.clear();
    isOffered.value = false;
    isActive.value = true;
    serviceImage.value = null;
    serviceImageUrl.value = '';
    isEditing.value = false;
    editingServiceId.value = '';
  }

}