import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import '../model/admin_booking_model.dart';

class BookingAdminController extends GetxController {
  RxList<BookingAdminModel> adminBookingModel = <BookingAdminModel>[].obs;
  Rx<TextEditingController> dateTimeController = TextEditingController().obs;
  RxBool isLoadingBooking = false.obs;
  var hasMore = true.obs;
  RxInt page = 1.obs;
  final NetworkConfig _networkConfig = NetworkConfig();

  var isPending = true.obs;
  var selectedTime = (-1).obs;

  void showPending() {
    isPending.value = true;
  }

  void showComplete() {
    isPending.value = false;
  }

  @override
  onInit() {
    super.onInit();
    getBookingStatus();
  }

  Future<bool> getBookingStatus() async {
    if (isLoadingBooking.value && !hasMore.value) {
      return false;
    }
    isLoadingBooking.value = true;
    try {
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.GET,
          "${Urls.adminBookingStatus}&page=${page.value}", {},
          is_auth: true);
      if (response != null && response['success'] == true) {
        List dataList = response["data"]["result"];
        if (dataList.isEmpty) {
          hasMore.value = false;
        } else {
          List<BookingAdminModel> bookingData =
              dataList.map((e) => BookingAdminModel.fromJson(e)).toList();
          adminBookingModel.addAll(bookingData);
          page.value++;
        }
        return true;
      } else {
        log("get Booking failed message: ${response["message"]}");
        return false;
      }
    } catch (e) {
      log("Get Booking failed Error $e");
      return false;
    } finally {
      isLoadingBooking.value = false;
    }
  }
}
