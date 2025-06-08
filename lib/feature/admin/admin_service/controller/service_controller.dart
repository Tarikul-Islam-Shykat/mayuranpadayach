import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController{
  Rx<TextEditingController> serviceNameTEC = TextEditingController().obs;
  Rx<TextEditingController> servicePriceTEC = TextEditingController().obs;
  Rx<TextEditingController> businessNameTEC = TextEditingController().obs;


  var selectBusinessCategory= ''.obs;
  var selectBusinessSubCategory= ''.obs;


  List<String> selectBusinessCategoryList = ["category 1","category 2"];
  List<String> selectBusinessSubCategoryList = ["subCategory 1","subCategory 2"];

  void onSelectCategory(String value) {
    selectBusinessCategory.value = value;
  }
  void onSelectSubCategory(String value) {
    selectBusinessSubCategory.value = value;
  }

}