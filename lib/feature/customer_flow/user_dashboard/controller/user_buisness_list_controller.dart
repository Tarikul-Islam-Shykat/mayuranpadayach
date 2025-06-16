// business_list_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/model/user_featured_business_model.dart';

class BusinessListController extends GetxController {
  // Observable variables
  final RxList<Business> businessList = <Business>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreData = true.obs;
  final RxString errorMessage = ''.obs;

  // Pagination variables
  final RxInt currentPage = 1.obs;
  final RxInt totalItems = 0.obs;
  final int itemsPerPage = 10;

  final NetworkConfig _networkConfig = NetworkConfig();

  // Scroll controller for pagination
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    _initScrollListener();
    fetchBusinessList(); // Initial load
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        // Load more when user is 200px from bottom
        if (!isLoadingMore.value && hasMoreData.value) {
          loadMoreBusinesses();
        }
      }
    });
  }

  Future<void> fetchBusinessList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        businessList.clear();
        hasMoreData.value = true;
        errorMessage.value = '';
      }

      isLoading.value = true;

      final Map<String, dynamic> requestBody = {};
      final String url =
          "${Urls.baseUrl}/businesses?limit=$itemsPerPage&page=${currentPage.value}";

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        url,
        json.encode(requestBody),
        is_auth: true,
      );

      if (response['success'] == true) {
        final businessResponse = BusinessListResponse.fromJson(response);

        if (isRefresh) {
          businessList.assignAll(businessResponse.data.businesses);
        } else {
          businessList.addAll(businessResponse.data.businesses);
        }

        totalItems.value = businessResponse.data.meta.total;

        // Check if there's more data
        hasMoreData.value = businessList.length < totalItems.value;

        errorMessage.value = '';
      } else {
        errorMessage.value =
            response['message'] ?? 'Failed to fetch businesses';
        AppSnackbar.show(message: errorMessage.value, isSuccess: false);
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch businesses: $e";
      AppSnackbar.show(message: errorMessage.value, isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreBusinesses() async {
    if (!hasMoreData.value || isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;
      currentPage.value++;

      final Map<String, dynamic> requestBody = {};
      final String url =
          "${Urls.baseUrl}/businesses?limit=$itemsPerPage&page=${currentPage.value}";

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        url,
        json.encode(requestBody),
        is_auth: true,
      );

      if (response['success'] == true) {
        final businessResponse = BusinessListResponse.fromJson(response);

        if (businessResponse.data.businesses.isNotEmpty) {
          businessList.addAll(businessResponse.data.businesses);

          // Check if there's more data
          hasMoreData.value =
              businessList.length < businessResponse.data.meta.total;
        } else {
          hasMoreData.value = false;
        }
      } else {
        // Revert page increment on failure
        currentPage.value--;
        AppSnackbar.show(
            message: response['message'] ?? 'Failed to load more businesses',
            isSuccess: false);
      }
    } catch (e) {
      // Revert page increment on failure
      currentPage.value--;
      AppSnackbar.show(
          message: "Failed to load more businesses: $e", isSuccess: false);
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Method to refresh the list
  Future<void> refreshBusinessList() async {
    await fetchBusinessList(isRefresh: true);
  }

  // Method to search businesses (you can extend this)
  Future<void> searchBusinesses(String query) async {
    // Implement search functionality if needed
    // You can modify the API call to include search parameters
  }

  // Helper method to get business by id
  Business? getBusinessById(String id) {
    try {
      return businessList.firstWhere((business) => business.id == id);
    } catch (e) {
      return null;
    }
  }

  // Helper method to filter businesses by category
  List<Business> getBusinessesByCategory(String categoryId) {
    return businessList
        .where((business) => business.categoryId == categoryId)
        .toList();
  }

  // Helper method to filter businesses by status
  List<Business> getOpenBusinesses() {
    return businessList
        .where((business) => business.openStatus == 'OPEN')
        .toList();
  }
}
