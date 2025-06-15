import 'dart:developer';
import 'package:get/get.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/admin/admin_review/model/get_review_model.dart';
import '../../../../core/network_caller/endpoints.dart';

class AdminReviewController extends GetxController {
  RxList<ReviewAdminModel> reviewAdminModel = <ReviewAdminModel>[].obs;
  RxBool isLoadingReview = false.obs;
  final NetworkConfig _networkConfig = NetworkConfig();
  
  Future<bool> getAdminReview(id)async{
    isLoadingReview.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.GET, "${Urls.getReviewAdmin}/$id", {},is_auth: true);
      log("response -- $response");
      if(response != null && response["success"]== true){
        reviewAdminModel.value =List<ReviewAdminModel>.from(response['data'].map((e)=>ReviewAdminModel.fromJson(e)));
        log("review get success");
        return true;
      }else{
        log("review get failed");
        return false;
      }
    }catch(e){
      log("Failed response $e");
      return false;
    }finally{
      isLoadingReview.value = false;
    }
    
  }
  
}