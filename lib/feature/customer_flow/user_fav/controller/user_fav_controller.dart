// controllers/favorites_controller.dart

import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/user_fav/model/user_fav_model.dart';

class FavoritesController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  final RxList<FavoriteItem> favoriteStudios = <FavoriteItem>[].obs;
  final RxBool isFavLoading = false.obs;
  Future<void> loadFavorites() async {
    try {
      isFavLoading.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getFavBuisness,
        null,
        is_auth: true,
      );
      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> dataList = response['data'];
        favoriteStudios.value =
            dataList.map((e) => FavoriteItem.fromJson(e)).toList();
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch search histories",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch search histories: $e",
        isSuccess: false,
      );
    } finally {
      isFavLoading.value = false;
    }
  }

  void toggleFavorite(String favId) async {
    final index = favoriteStudios.indexWhere((favItem) => favItem.id == favId);
    if (index != -1) {
      favoriteStudios.removeAt(index);
    }
    try {
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        "${Urls.getFavBuisness}/$favId",
        null,
        is_auth: true,
      );
      if (response['success'] == true && response['data'] != null) {
        AppSnackbar.show(
          message: "Removed From Favourite",
          isSuccess: false,
        );
      } else {
        AppSnackbar.show(
          message: "Failed Removed From Favourite",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed Removed From Favourite",
        isSuccess: false,
      );
    } finally {}
  }

  // Refresh favorites
  void refreshFavorites() {
    loadFavorites();
  }

  void updateFavoritesFromApi(List<FavoriteItem> apiData) {
    favoriteStudios.value = apiData;
  }

  // Get studio by ID
  FavoriteItem? getStudioById(String id) {
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
