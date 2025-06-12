import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/admin/admin_business/model/get_admin_business.dart';

import '../model/admin_business_details.dart';

class AdminBusinessController extends GetxController{

  RxList<GetAdminBusinessModel> adminBusinessModel = <GetAdminBusinessModel>[].obs;
  Rx<AdminBusinessDetails> adminBusinessDetailsModel = AdminBusinessDetails().obs;
  RxBool isBusinessLoading = false.obs;
  RxBool isBusinessDetailsLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxBool isLastPage = false.obs;
  ScrollController scrollController = ScrollController();
  final NetworkConfig _networkConfig = NetworkConfig();
  @override
  void onInit() {
    super.onInit();
    adminBusinessGet();
  }


  Future<bool> adminBusinessGet()async{
    isBusinessLoading.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.GET, "${Urls.userBusiness}&page=1",{},is_auth: true);
      log("response  === ${response.toString()}");
      if(response != null && response['success'] == true){
       adminBusinessModel.value = List<GetAdminBusinessModel>.from(response["data"]["data"].map((x) => GetAdminBusinessModel.fromJson(x)));
       debugPrint("-----=---get admin business success");
      return true;
      }else{
        debugPrint(" get admin business message: ${response["message"]}");
        adminBusinessModel.clear();

        return false;
      }

    }catch(e){
      adminBusinessModel.clear();
      debugPrint("-----=---get admin business failed$e");
      return false;

    }finally{
      isBusinessLoading.value = false;
    }
  }
  
  Future<bool> businessDetails(id)async{
    isBusinessDetailsLoading.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.GET, "${Urls.adminBusinessDetails}/$id",{},is_auth: true,);
      log("details response ------$response");
      if(response != null && response["success"] == true){
        adminBusinessDetailsModel.value = AdminBusinessDetails.fromJson(response['data']);
        log("business details get successful");
        return true;
      }else{
        log("get business failed${response["message"]}");
        return false;
      }
    }catch(e){
      log("get business details error ---$e}");
      return false;
    }finally{
      isBusinessDetailsLoading.value = false;
    }
  }



}