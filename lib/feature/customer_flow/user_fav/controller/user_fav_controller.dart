// controllers/favorites_controller.dart

import 'package:get/get.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/dummy_data.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/studio_model.dart';

class FavoritesController extends GetxController {
  // Observable list of favorite studios
  final RxList<StudioModel> favoriteStudios = <StudioModel>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Error message
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // Load favorite studios (currently using dummy data)
  void loadFavorites() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Replace with actual API call
      // final response = await apiService.getFavoriteStudios();
      // favoriteStudios.value = response.data;

      // For now, using dummy data
      favoriteStudios.value = DummyData.getStudioList();
    } catch (e) {
      errorMessage.value = 'Failed to load favorites: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle favorite status
  void toggleFavorite(String studioId) {
    final index = favoriteStudios.indexWhere((studio) => studio.id == studioId);
    if (index != -1) {
      favoriteStudios.removeAt(index);
      // TODO: Call API to remove from favorites
      // await apiService.removeFromFavorites(studioId);
    }
  }

  // Refresh favorites
  void refreshFavorites() {
    loadFavorites();
  }

  // Update favorites list from API response
  void updateFavoritesFromApi(List<StudioModel> apiData) {
    favoriteStudios.value = apiData;
  }

  // Get studio by ID
  StudioModel? getStudioById(String id) {
    try {
      return favoriteStudios.firstWhere((studio) => studio.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if studio is in favorites
  bool isStudioFavorite(String studioId) {
    return favoriteStudios.any((studio) => studio.id == studioId);
  }
}
