import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/service_controller.dart';
import 'package:prettyrini/feature/admin/admin_service/model/all_service_model.dart';
import 'package:prettyrini/feature/admin/admin_specialist/model/get_specialist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/global_widegts/app_snackbar.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../../../../core/network_caller/network_config.dart';



class SpecialistController extends GetxController{

  Rx<TextEditingController> nameTEC = TextEditingController().obs;
  Rx<TextEditingController> specialistTEC = TextEditingController().obs;
  Rx<TextEditingController> specialistExperienceTEC = TextEditingController().obs;
  RxList<GetSpecialistModel> specialistModel = <GetSpecialistModel>[].obs;

  RxBool isLoadingSpecialist = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  RxBool isEditing = false.obs;
  RxBool isActive = false.obs;
  RxString errorMessage = "".obs;
  var uploadProgress = 0.0.obs;
  RxString imageSizeText = ''.obs;
  RxString serviceImageUrl = ''.obs;
  RxString editingServiceId = ''.obs;
  final _picker = ImagePicker();
  Rx<File?> serviceImage = Rx<File?>(null);
  final NetworkConfig _networkConfig = NetworkConfig();
  @override
  void onInit() {
    super.onInit();
    getAllSpecialist();
  }
  RxList<ServiceModel> serviceList = <ServiceModel>[].obs;
  Rx<ServiceModel?> selectedService = Rx<ServiceModel?>(null);



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
  Future<bool> createSpecialist({required String businessId})async{
    if (serviceImage.value == null) {
      errorMessage.value = 'Please select a Image';
      return false;
    }
    try{
      isLoadingSpecialist.value = true;
      errorMessage.value = '';
      uploadProgress.value = 0.0;
      final request = http.MultipartRequest("POST", Uri.parse(Urls.createAdminSpecialist),);
      SharedPreferences sh = await SharedPreferences.getInstance();
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });
      // Create the JSON data for the data field
      final serviceId = Get.put(ServiceController()).selectedService.value!.id.toString();
      Map<String, dynamic> data = {
        "fullName":nameTEC.value.text,
        "specialization": specialistTEC.value.text,
        "businessId": businessId,
        "serviceId": serviceId,
        "experience": int.parse(specialistExperienceTEC.value.text)
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
        // await getAllService(id);
        // allClear();
        Get.back();
        AppSnackbar.show(
          message: "Image uploaded successfully!",
          isSuccess: true,
        );
        Get.back();
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
      isLoadingSpecialist.value = false;
    }
  }

  //edit specialist
  Future<bool> editSpecialist(serviceId)async{
    if (serviceImage.value == null) {
      errorMessage.value = 'Please select a Image';
      return false;
    }
    try{
      isLoadingSpecialist.value = true;
      errorMessage.value = '';
      uploadProgress.value = 0.0;
      final request = http.MultipartRequest("PUT", Uri.parse("${Urls.editAdminSpecialist}/$serviceId"),);
      SharedPreferences sh = await SharedPreferences.getInstance();
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });
      // Create the JSON data for the data field
      Map<String, dynamic> data = {
      "fullName":nameTEC.value.text,
      "specialization":specialistTEC.value.text,
      "experience": specialistExperienceTEC.value.text,
        "status": isActive.value ? "ACTIVE" : "INACTIVE",
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
        Get.back();
        AppSnackbar.show(
          message: "Image uploaded successfully!",
          isSuccess: true,
        );
        Get.back();
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
      isLoadingSpecialist.value = false;
    }
  }

  void setEditSpecialistData(GetSpecialistModel specialist) {
    isEditing.value = true;
    editingServiceId.value = specialist.id ?? '';
    nameTEC.value.text =specialist.fullName.toString();
    specialistTEC.value.text= specialist.specialization.toString();
    specialistExperienceTEC.value.text= specialist.experience.toString();
    isActive.value = specialist.status == "ACTIVE";

    if (specialist.profileImage != null) {
      serviceImageUrl.value = specialist.profileImage!;
      serviceImage.value = null;
    }
  }



  Future<bool> getAllSpecialist()async{
    if(isLoadingSpecialist.value || !hasMore.value){
      return false;
    }
    isLoadingSpecialist.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(
          RequestMethod.GET,
          "${Urls.getAdminSpecialist}&page=${page.value}",{},is_auth: true);
      log("service response  $response");
      if(response != null && response["success"] == true){
        allClear();
        List dataList = response["data"]["data"];
        if(dataList.isEmpty){
          hasMore.value = false;
        }else{
          List<GetSpecialistModel> specialistData = dataList.map((e)=>GetSpecialistModel.fromJson(e)).toList();
          specialistModel.addAll(specialistData);
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
      isLoadingSpecialist.value = false;
    }
    return false;
  }


  void allClear() {
    nameTEC.value.clear();
    specialistExperienceTEC.value.clear();
    specialistTEC.value.clear();
    isActive.value = true;
    serviceImage.value = null;
    serviceImageUrl.value = '';
    isEditing.value = false;
  }
}