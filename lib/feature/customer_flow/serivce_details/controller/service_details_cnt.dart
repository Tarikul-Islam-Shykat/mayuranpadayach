// lib/controllers/studio_controller.dart

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/buisiness_details_model.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/dummy_data.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/portfolio_model.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/review_model.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/service_data_model.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/studio_model.dart';

class StudioController extends GetxController {
  // Observable variables
  var studioList = <StudioModel>[].obs;
  var selectedStudio = Rxn<StudioModel>();
  var selectedTabIndex = 0.obs;
  var isLoading = false.obs;
  var isFavorite = false.obs;

  final NetworkConfig _networkConfig = NetworkConfig();

  // Tab names
  final List<String> tabNames = ['Services', 'Review', 'Portfolio', 'About'];

  @override
  void onInit() {
    super.onInit();
    loadStudioData();
    getBuisnessDetails();
    getServices();
    getReviews();
    getBusinessPortfolio();
  }

  final RxList<PortfolioItem> businessPortfolios = <PortfolioItem>[].obs;
  Future<bool> getBusinessPortfolio(
      {String id = "68513f4df256aa740e9e3665"}) async {
    try {
      isFetchingBuisnessisLoading.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        "${Urls.getBuisnessView}/$id",
        null,
        is_auth: true,
      );

      log("getBusinessPortfolio Response: ${response.toString()}");

      if (response == null || response['success'] != true) {
        AppSnackbar.show(
          message: response?['message'] ?? "Something went wrong",
          isSuccess: false,
        );
        return false;
      }

      final dataJson = response['data'];
      if (dataJson == null || (dataJson as List).isEmpty) {
        businessPortfolios.clear();
        AppSnackbar.show(message: "No portfolio found", isSuccess: false);
        return true;
      }

      businessPortfolios.value = dataJson
          .map<PortfolioItem>((e) => PortfolioItem.fromJson(e))
          .toList();

      AppSnackbar.show(message: "Portfolio Retrieved", isSuccess: true);
      return true;
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to retrieve portfolio: $e",
        isSuccess: false,
      );
      return false;
    } finally {
      isFetchingBuisnessisLoading.value = false;
    }
  }

  final RxList<Review> reviews = <Review>[].obs;
  Future<bool> getReviews({String id = "68513f4df256aa740e9e3665"}) async {
    try {
      isFetchingBuisnessisLoading.value = true;
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        "${Urls.getReviewsByID}/$id",
        null, // GET request doesn't need a body
        is_auth: true,
      );
      log("getReviews ${response.toString()}");
      if (response == null || response['success'] != true) {
        AppSnackbar.show(
          message: response?['message'] ?? "Something went wrong",
          isSuccess: false,
        );
        return false;
      }
      final data = response['data'];
      if (data == null || (data as List).isEmpty) {
        reviews.clear();
        AppSnackbar.show(message: "No data found", isSuccess: false);
        return true;
      }
      reviews.assignAll((data as List).map((e) => Review.fromJson(e)).toList());
      AppSnackbar.show(message: "Reviews Retrieved", isSuccess: true);
      return true;
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to retrieve reviews: $e",
        isSuccess: false,
      );
      return false;
    } finally {
      isFetchingBuisnessisLoading.value = false;
    }
  }

  final RxList<Service> services = <Service>[].obs;
  var selectedServiceIndex = (-1).obs; // -1 means no selection initially
  Future<bool> getServices({String id = "68513f4df256aa740e9e3665"}) async {
    try {
      isFetchingBuisnessisLoading.value = true;

      final Map<String, dynamic> requestBody = {};
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        "${Urls.getServiceByBuisnesID}/$id",
        json.encode(requestBody),
        is_auth: true,
      );

      log("getServices ${response.toString()}");

      if (response == null || response['success'] != true) {
        AppSnackbar.show(
          message: response?['message'] ?? "Something went wrong",
          isSuccess: false,
        );
        return false;
      }

      final serviceDataJson = response['data'];
      if (serviceDataJson == null ||
          serviceDataJson['data'] == null ||
          (serviceDataJson['data'] as List).isEmpty) {
        services.clear();
        AppSnackbar.show(message: "No data found", isSuccess: false);
        return true;
      }

      final ServiceData serviceData = ServiceData.fromJson(serviceDataJson);
      services.assignAll(serviceData.services);

      AppSnackbar.show(message: "Service list retrieved", isSuccess: true);
      return true;
    } catch (e) {
      AppSnackbar.show(
          message: "Failed to fetch services: $e", isSuccess: false);
      return false;
    } finally {
      isFetchingBuisnessisLoading.value = false;
    }
  }

  void selectService(int index) {
    selectedServiceIndex.value = index;
    update(); // Force update
  }

  var isFetchingBuisnessisLoading = false.obs;
  final Rxn<BusinessData> businessDetails = Rxn<BusinessData>();
  Future<bool> getBuisnessDetails(
      {String id = "68513f4df256aa740e9e3665"}) async {
    try {
      isFetchingBuisnessisLoading.value = true;
      final Map<String, dynamic> requestBody = {};
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        "${Urls.getBuiessnessDetailsById}/$id",
        json.encode(requestBody),
        is_auth: true,
      );

      if (response == null || response['success'] != true) {
        AppSnackbar.show(
          message: response?['message'] ?? "Something went wrong",
          isSuccess: false,
        );
        return false;
      }

      log("getBuisnessDetails ${response.toString()}");

      businessDetails.value = BusinessData.fromJson(response['data']);

      AppSnackbar.show(message: "Business Details Retrieved", isSuccess: true);
      return true;
    } catch (e) {
      AppSnackbar.show(
          message: "Failed to fetch business details: $e", isSuccess: false);
      return false;
    } finally {
      isFetchingBuisnessisLoading.value = false;
    }
  }

  // Load studio data from dummy data
  void loadStudioData() {
    isLoading.value = true;
    try {
      studioList.value = DummyData.getStudioList();
      if (studioList.isNotEmpty) {
        selectedStudio.value = studioList.first;
      }
    } catch (e) {
      print('Error loading studio data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Select a specific studio
  void selectStudio(String studioId) {
    selectedStudio.value = studioList.firstWhere(
      (studio) => studio.id == studioId,
      orElse: () => studioList.first,
    );
  }

  // Change selected tab
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Toggle favorite status
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  // Get current studio
  StudioModel? get currentStudio => selectedStudio.value;

  // Get current tab name
  String get currentTabName => tabNames[selectedTabIndex.value];

  // Get services for current studio
  List<SubService> get currentServices => currentStudio?.subServices ?? [];

  // Get reviews for current studio
  List<WrittenReview> get currentReviews => currentStudio?.writtenReviews ?? [];

  // Get portfolio images for current studio
  List<String> get currentPortfolio => currentStudio?.portfolioImages ?? [];

  // Get specialists for current studio
  List<Specialist> get currentSpecialists => currentStudio?.specialists ?? [];

  // Get review summary for current studio
  ReviewSummary? get currentReviewSummary => currentStudio?.reviewSummary;

  // Get contact info for current studio
  ContactInfo? get currentContactInfo => currentStudio?.contactInfo;

  // Calculate average rating from written reviews
  double get averageRating {
    if (currentReviews.isEmpty) return 0.0;
    double total =
        currentReviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / currentReviews.length;
  }

  // Get formatted address
  String get formattedAddress => currentStudio?.contactInfo.address ?? '';

  // Get formatted rating
  String get formattedRating =>
      currentStudio?.rating.toStringAsFixed(1) ?? '0.0';

  // Get formatted review count
  String get formattedReviewCount => '${currentStudio?.totalReviews ?? 0}+';

  // Search studios by name or category
  List<StudioModel> searchStudios(String query) {
    if (query.isEmpty) return studioList;

    return studioList
        .where((studio) =>
            studio.name.toLowerCase().contains(query.toLowerCase()) ||
            studio.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Filter studios by category
  List<StudioModel> filterByCategory(String category) {
    return studioList
        .where(
            (studio) => studio.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Get studios within a certain rating range
  List<StudioModel> getStudiosByRating(double minRating) {
    return studioList.where((studio) => studio.rating >= minRating).toList();
  }
}
