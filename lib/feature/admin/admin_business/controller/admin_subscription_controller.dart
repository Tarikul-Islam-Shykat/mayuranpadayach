import 'dart:developer';
import 'package:get/get.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/admin/admin_business/model/admin_subscription_plan.dart';

class AdminSubscriptionController extends GetxController{
  RxList<SubscriptionOffer> adminSubscription = <SubscriptionOffer>[].obs;
  RxBool isLoadingSubscription = false.obs;
  final NetworkConfig _networkConfig = NetworkConfig();

  @override
  onInit(){
    super.onInit();
    log("💡 AdminSubscriptionController onInit called");
    adminGetSubscription();
  }
  
  
  Future<bool> adminGetSubscription()async{
    isLoadingSubscription.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.GET, Urls.getAdminSubscription, {},is_auth: true);
      if(response != null && response["success"] == true){
        adminSubscription.value = List<SubscriptionOffer>.from(response["data"].map((e)=>SubscriptionOffer.fromJson(e)));
        log("Get Subscription Success :${response["message"]}");
        return true;
      }else{
        log("Get Subscription Failed :${response["message"]}");
        return false;
      }
    }catch(e){
      log("Request Failed $e");
      return false;
    }finally{
      isLoadingSubscription.value = false;
    }
  }
}