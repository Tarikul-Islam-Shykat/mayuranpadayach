// business_controller.dart
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'dart:convert';
import 'package:prettyrini/feature/customer_flow/user_dashboard/model/buisness_model.dart';

class CardSwiperVController extends GetxController {
  // Observable variables
  var isBusinessDataLoading = false.obs;
  var businessList = <CardSwiperBusiness>[].obs;
  var currentIndex = 0.obs;
  var totalBusinessCount = 0.obs;
  final NetworkConfig _networkConfig = NetworkConfig();

  // Pagination
  var currentPage = 1.obs;
  var hasMoreData = true.obs;

  // Add your network config instance here
  // final _networkConfig = YourNetworkConfig();

  @override
  void onInit() {
    super.onInit();
    fetchBusinessData();
  }

  // Fetch business data from API
  Future<void> fetchBusinessData({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        hasMoreData.value = true;
        businessList.clear();
      }

      isBusinessDataLoading.value = true;

      final Map<String, dynamic> requestBody = {
        'page': currentPage.value,
        'limit': 10,
      };

      // Replace with your actual API call
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        "${Urls.baseUrl}/businesses?limit=10&page=1", // Replace with your actual URL
        json.encode(requestBody),
        is_auth: true,
      );

      if (response['success'] == true) {
        final businessResponse = BusinessResponseModel.fromJson(response);

        if (isRefresh) {
          businessList.value = businessResponse.data.data;
        } else {
          businessList.addAll(businessResponse.data.data);
        }

        totalBusinessCount.value = businessResponse.data.meta.total;

        // Check if there's more data to load
        if (businessList.length >= totalBusinessCount.value) {
          hasMoreData.value = false;
        }

        currentPage.value++;
      } else {
        AppSnackbar.show(
            message: response['message'] ?? "Failed to fetch business data",
            isSuccess: false);
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed to fetch data: $e", isSuccess: false);
    } finally {
      isBusinessDataLoading.value = false;
    }
  }

  // Handle card swipe
  void onCardSwiped(int index) {
    currentIndex.value = index;

    // If we're near the end and have more data, load more
    if (index >= businessList.length - 2 &&
        hasMoreData.value &&
        !isBusinessDataLoading.value) {
      fetchBusinessData();
    }
  }

  // Remove card (when swiped away)
  void removeCard(int index) {
    if (index < businessList.length) {
      businessList.removeAt(index);

      // If no cards left, show reload option
      if (businessList.isEmpty) {
        // You can trigger a reload here or show reload UI
      }
    }
  }

  // Reload data
  Future<void> reloadData() async {
    currentIndex.value = 0;
    await fetchBusinessData(isRefresh: true);
  }

  // Get current business
  CardSwiperBusiness? getCurrentBusiness() {
    if (currentIndex.value < businessList.length) {
      return businessList[currentIndex.value];
    }
    return null;
  }

  // Check if business is open
  bool isBusinessOpen(CardSwiperBusiness business) {
    return business.openStatus.toLowerCase() == 'open';
  }

  // Format rating
  String getFormattedRating(double rating) {
    return rating > 0 ? rating.toStringAsFixed(1) : '4.9'; // Default rating
  }
}
