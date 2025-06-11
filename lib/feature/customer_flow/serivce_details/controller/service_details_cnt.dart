// lib/controllers/studio_controller.dart

import 'package:get/get.dart';


import '../model/dummy_data.dart';
import '../model/studio_model.dart';


class StudioController extends GetxController {
  // Observable variables
  var studioList = <StudioModel>[].obs;
  var selectedStudio = Rxn<StudioModel>();
  var selectedTabIndex = 0.obs;
  var isLoading = false.obs;
  var isFavorite = false.obs;

  // Tab names
  final List<String> tabNames = ['Services', 'Review', 'Portfolio', 'About'];

  @override
  void onInit() {
    super.onInit();
    loadStudioData();
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
    double total = currentReviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / currentReviews.length;
  }

  // Get formatted address
  String get formattedAddress => currentStudio?.contactInfo.address ?? '';

  // Get formatted rating
  String get formattedRating => currentStudio?.rating.toStringAsFixed(1) ?? '0.0';

  // Get formatted review count
  String get formattedReviewCount => '${currentStudio?.totalReviews ?? 0}+';

  // Search studios by name or category
  List<StudioModel> searchStudios(String query) {
    if (query.isEmpty) return studioList;
    
    return studioList.where((studio) =>
      studio.name.toLowerCase().contains(query.toLowerCase()) ||
      studio.category.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Filter studios by category
  List<StudioModel> filterByCategory(String category) {
    return studioList.where((studio) =>
      studio.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  // Get studios within a certain rating range
  List<StudioModel> getStudiosByRating(double minRating) {
    return studioList.where((studio) => studio.rating >= minRating).toList();
  }
}