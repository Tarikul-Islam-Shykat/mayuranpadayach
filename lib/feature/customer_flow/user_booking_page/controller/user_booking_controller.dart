
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../serivce_details/model/dummy_data.dart';
import '../../serivce_details/model/studio_model.dart';
import '../ui/user_booking_details.dart';

class BookingController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  
  // Observable lists for both tabs
  final RxList<StudioModel> pendingBookings = <StudioModel>[].obs;
  final RxList<StudioModel> completedBookings = <StudioModel>[].obs;
  
  // Loading states
  final RxBool isLoadingPending = false.obs;
  final RxBool isLoadingCompleted = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadBookingData();
  }
  
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
  
  // Load booking data - replace this with actual API calls later
  void loadBookingData() {
    loadPendingBookings();
    loadCompletedBookings();
  }
  
  void loadPendingBookings() {
    isLoadingPending.value = true;
    
    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      // For now, using dummy data - replace with actual API response
      pendingBookings.value = DummyData.getStudioList();
      isLoadingPending.value = false;
    });
  }
  
  void loadCompletedBookings() {
    isLoadingCompleted.value = true;
    
    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      // For now, using dummy data - replace with actual API response
      completedBookings.value = DummyData.getStudioList();
      isLoadingCompleted.value = false;
    });
  }
  
  // Navigate to booking details
  void navigateToBookingDetails(StudioModel studio) {
    Get.to(() => UserBookingDetailsScreen(studio: studio));
  }
  
  // Refresh data
  void refreshPendingBookings() {
    loadPendingBookings();
  }
  
  void refreshCompletedBookings() {
    loadCompletedBookings();
  }
}



