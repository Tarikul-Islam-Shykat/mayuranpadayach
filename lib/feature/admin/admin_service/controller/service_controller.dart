import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/admin/admin_service/model/all_service_model.dart';

class ServiceController extends GetxController{
  Rx<TextEditingController> serviceNameTEC = TextEditingController().obs;
  Rx<TextEditingController> servicePriceTEC = TextEditingController().obs;
  Rx<TextEditingController> businessNameTEC = TextEditingController().obs;
  RxList<ServiceModel> serviceModel = <ServiceModel>[].obs;
  var page = 1.obs;
  var isLoadingService = false.obs;
  var hasMore = true.obs;
  final NetworkConfig _networkConfig = NetworkConfig();


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
        List dataList = response["data"]["data"];
        if(dataList.isEmpty){
          hasMore.value = false;
        }else{
          List<ServiceModel> serviceData = dataList.map((e)=>ServiceModel.fromJson(e)).toList();
          serviceModel.value.addAll(serviceData);
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

}