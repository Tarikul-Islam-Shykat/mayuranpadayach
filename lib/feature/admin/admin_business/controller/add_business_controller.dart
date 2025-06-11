import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../../core/services_class/network_service/image_adding_controller.dart';

class AddBusinessController extends GetxController{
  final GalleryController imageController = Get.put(GalleryController());

  final TextEditingController businessNameTEC = TextEditingController();
  var long ="";
  var lat = '';
  var locationName ='';

  var selectBusinessCategory= ''.obs;
  var selectBusinessSubCategory= ''.obs;
  RxBool isAddBusinessLoading = false.obs;


  List<String> selectBusinessCategoryList = ["category 1","category 2"];
  List<String> selectBusinessSubCategoryList = ["subCategory 1","subCategory 2"];

  void onSelectCategory(String value) {
    selectBusinessCategory.value = value;
  }
  void onSelectSubCategory(String value) {
    selectBusinessSubCategory.value = value;
  }

  Future<void> addBusiness()async{
    if (imageController.galleryImages == null) {
      Get.snackbar("Image", "Please select an image");
      return;
    }
    isAddBusinessLoading.value = true;

    try{


    }catch(e){
       debugPrint(e.toString());
    }


  }


}