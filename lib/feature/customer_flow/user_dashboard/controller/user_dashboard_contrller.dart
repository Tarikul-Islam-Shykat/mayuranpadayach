// controllers/home_controller.dart

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/dummy_data.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/studio_model.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/model/user_categories_model.dart';
import 'dart:async';

import 'package:prettyrini/feature/customer_flow/user_dashboard/model/user_model.dart';

class UserDashboardContrller extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  // Observable variables
  var currentCarouselIndex = 0.obs;
  var studios = <StudioModel>[].obs;
  var filteredStudios = <StudioModel>[].obs;
  var selectedCategoryIndex = 0.obs;
  var searchQuery = ''.obs;

  // Carousel timer
  Timer? carouselTimer;

  // Categories
  final categories = [
    {'name': 'All', 'icon': '🏠'},
    {'name': 'Beauty', 'icon': '💄'},
    {'name': 'Health', 'icon': '🏥'},
    {'name': 'Tutoring', 'icon': '📚'},
    {'name': 'Event', 'icon': '🎉'},
    {'name': 'More', 'icon': '➕'},
  ];

  // Bottom navigation
  var currentNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStudios();
    startCarouselAutoSlide();
    fetchUserData();
    fetchCategories();
  }

  final isFetchCategories = false.obs;
  final userDashboardCategoryList = <UserCategoriesModel>[].obs;
  Future<void> fetchCategories() async {
    try {
      isFetchCategories.value = true;

      final Map<String, dynamic> requestBody = {};
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.addBusinessCategory,
        json.encode(requestBody),
        is_auth: true,
      );
      if (response['success'] == true && response['data'] != null) {
        final List<UserCategoriesModel> fetchedCategories =
            List<Map<String, dynamic>>.from(response['data'])
                .map((e) => UserCategoriesModel.fromJson(e))
                .toList();
        userDashboardCategoryList.assignAll(fetchedCategories);
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch categories",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
          message: "Failed To Fetch Categories: $e", isSuccess: false);
    } finally {
      isFetchCategories.value = false;
    }
  }

  final isUserDataFetchLoading = false.obs;
  final userProfile = Rxn<UserProfile>();
  final userName = "".obs;
  final userImagePath = "".obs;
  Future<void> fetchUserData() async {
    try {
      isUserDataFetchLoading.value = true;
      final Map<String, dynamic> requestBody = {};
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getUserProfile,
        json.encode(requestBody),
        is_auth: true,
      );
      if (response['success'] == true) {
        userProfile.value = UserProfile.fromJson(response['data']);
        userName.value = userProfile.value?.fullName ?? '';
        userImagePath.value = userProfile.value?.profileImage ?? '';
      }
    } catch (e) {
      isUserDataFetchLoading.value = false;
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
    } finally {
      isUserDataFetchLoading.value = false;
    }
  }

  @override
  void onClose() {
    carouselTimer?.cancel();
    super.onClose();
  }

  void loadStudios() {
    studios.value = DummyData.getStudioList();
    filteredStudios.value = studios;
  }

  void startCarouselAutoSlide() {
    carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (filteredStudios.isNotEmpty) {
        currentCarouselIndex.value =
            (currentCarouselIndex.value + 1) % filteredStudios.length;
      }
    });
  }

  void onCarouselPageChanged(int index) {
    currentCarouselIndex.value = index;
  }

  void onCategorySelected(int index) {
    selectedCategoryIndex.value = index;
    filterStudios();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    filterStudios();
  }

  void filterStudios() {
    var filtered = studios.where((studio) {
      bool matchesSearch = searchQuery.value.isEmpty ||
          studio.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          studio.category
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());

      bool matchesCategory = selectedCategoryIndex.value == 0 || // All
          (selectedCategoryIndex.value == 1 &&
              studio.category.toLowerCase().contains('beauty')) ||
          (selectedCategoryIndex.value == 1 &&
              studio.category.toLowerCase().contains('hair')) ||
          (selectedCategoryIndex.value == 2 &&
              studio.category.toLowerCase().contains('health')) ||
          (selectedCategoryIndex.value == 3 &&
              studio.category.toLowerCase().contains('tutor')) ||
          (selectedCategoryIndex.value == 4 &&
              studio.category.toLowerCase().contains('event')) ||
          (selectedCategoryIndex.value == 2 &&
              studio.category.toLowerCase().contains('electric'));

      return matchesSearch && matchesCategory;
    }).toList();

    filteredStudios.value = filtered;

    // Reset carousel index if filtered list is smaller
    if (currentCarouselIndex.value >= filtered.length && filtered.isNotEmpty) {
      currentCarouselIndex.value = 0;
    }
  }

  void onBottomNavTapped(int index) {
    currentNavIndex.value = index;
  }

  void onStudioTapped(StudioModel studio) {
    // Navigate to studio details
    Get.toNamed('/studio-details', arguments: studio);
  }

  void onSeeAllSpecialOffers() {
    // Navigate to special offers page
    Get.toNamed('/special-offers');
  }

  void onSeeAllNearbyProfessionals() {
    // Navigate to all professionals page
    Get.toNamed('/all-professionals');
  }
}
