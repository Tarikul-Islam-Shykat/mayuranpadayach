import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBusinessController extends GetxController{

  final TextEditingController businessNameTEC = TextEditingController();
  var long ="";
  var lat = '';
  var locationName ='';

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