import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/feature/admin/admin_business/model/business_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/global_widegts/app_snackbar.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../../../../core/network_caller/network_config.dart';

class AddBusinessController extends GetxController{

  final TextEditingController businessNameTEC = TextEditingController();
  var long = 0.0;
  var lat = 0.0;
  var locationName = '';
  var imageSizeText = ''.obs;
  var errorMessage = ''.obs;
  var uploadProgress = 0.0.obs;
  final _picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);
  var openingTime = Rx<TimeOfDay?>(null);
  var closingTime = Rx<TimeOfDay?>(null);

  RxBool isAddBusinessLoading = false.obs;
  RxBool isCategoryLoading = false.obs;

  final NetworkConfig _networkConfig = NetworkConfig();

  @override
  void onInit() {
    super.onInit();
    getBusinessCategory();
  }





  Future<void> pickImageProfile()async{
    try{
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        File imageFile = File(pickedFile.path);
        // Compress the image
        File? compressedImage = await _compressImage(imageFile);
        if(compressedImage != null){
          profileImage.value = compressedImage;
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
          profileImage.value = compressedImage;
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
// Update image size text for display
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

  //add business function
  Future<bool> addBusinessProfile()async{
    if (profileImage.value == null) {
      errorMessage.value = 'Please select a Image';
      return false;
    }
    try{
      isAddBusinessLoading.value = true;
      errorMessage.value = '';
      uploadProgress.value = 0.0;
      final request = http.MultipartRequest("POST", Uri.parse(Urls.addBusiness),);
      SharedPreferences sh = await SharedPreferences.getInstance();
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });
      // Create the JSON data for the data field
      Map<String, dynamic> data = {
        "name":businessNameTEC.text,
        "categoryId":selectedCategory.value!.id.toString(),
        "subCategoryId":selectedSubCategory.value!.id.toString(),
        "latitude":lat,
        "longitude":long,
        "address":locationName,
        "openingHours":timeOfDayToIso8601(openingTime.value),
        "closingHours":timeOfDayToIso8601(closingTime.value),
      };
      request.fields['data'] = json.encode(data);
      debugPrint("response body------- ${data}");
      var imageBytes  = await profileImage.value!.readAsBytes();
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
        AppSnackbar.show(
          message: "Image uploaded successfully!",
          isSuccess: true,
        );
        clearForm();
        clearImage();
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
      isAddBusinessLoading.value = false;
    }
  }

  //category list model and get function
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  //get business category
  Future<bool> getBusinessCategory() async {
    isCategoryLoading.value = true;
    try {
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.addBusinessCategory,
        {},
        is_auth: true,
      );

      if (response != null && response['success'] == true) {
        categoryList.value = List<CategoryModel>.from(
          response['data'].map((x) => CategoryModel.fromJson(x)),
        );
        return true;
      } else {
        categoryList.clear(); // Optional: clear on failure
        return false;
      }
    } catch (e) {
      categoryList.clear(); // Optional: clear on error
      return false;
    } finally {
      isCategoryLoading.value = false;
    }
  }

  // For dropdown to select category and sub category
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<SubCategoryModel?> selectedSubCategory = Rx<SubCategoryModel?>(null);


  // Get subcategory list from selectedCategory
  List<SubCategoryModel> get subCategoryList {
    return selectedCategory.value?.subCategories ?? [];
  }
  // On category change
  void onCategorySelected(CategoryModel? category) {
    selectedCategory.value = category;
    selectedSubCategory.value = null;// reset sub category
  }

  void onSubCategorySelected(SubCategoryModel? subCategory) {
    selectedSubCategory.value = subCategory;
  }




  //date time picker for selected opening and closing time
  Future<void> pickTime(BuildContext context, Rx<TimeOfDay?> time) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      time.value = picked;
    }
  }
  DateTime? getDateTimeFromTime(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  DateTime timeOfDayToDateTime(TimeOfDay tod) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }

  //for post api convert time function
  String? timeOfDayToIso8601(TimeOfDay? time) {
    if (time == null) return null;
    final dateTime = DateTime.now();
    final fullDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      time.hour,
      time.minute,
    );
    return fullDateTime.toUtc().toIso8601String();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  // Clear selected image
  void clearImage() {
    profileImage.value = null;
    imageSizeText.value = '';
    errorMessage.value = '';
    uploadProgress.value = 0.0;

  }

  void clearForm() {
    // TextFields clear
    businessNameTEC.clear();

    // Dropdowns clear
    selectedCategory.value = null;
    selectedSubCategory.value = null;

    // Location data clear
    lat = 0.0;
    long = 0.0;
    locationName = "";

    // Time clear
    openingTime.value = null;
    closingTime.value = null;
  }



}