import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/user_search/model/search_history_model.dart';

class SearchHistoryController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  // Observable variables
  var searchHistories = <SearchHistoryModel>[].obs;
  var isLoading = false.obs;
  var isCreating = false.obs;
  var isDeleting = false.obs;
  var searchController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    fetchSearchHistories();
  }

  @override
  void onClose() {
    searchController.value.dispose();
    super.onClose();
  }

  // GET: Fetch search histories
  Future<void> fetchSearchHistories() async {
    try {
      isLoading.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/searchHistories',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final searchHistoryResponse = SearchHistoryResponse.fromJson(response);
        searchHistories.assignAll(searchHistoryResponse.data);
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
      isLoading.value = false;
    }
  }

  // POST: Create new search history
  Future<void> createSearchHistory(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      AppSnackbar.show(
        message: "Search term cannot be empty",
        isSuccess: false,
      );
      return;
    }

    try {
      isCreating.value = true;

      final Map<String, dynamic> requestBody = {
        'searchTerm': searchTerm.trim(),
      };

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        '${Urls.baseUrl}/searchHistories',
        json.encode(requestBody),
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final searchHistoryCreateResponse =
            SearchHistoryCreateResponse.fromJson(response);

        // Add to the beginning of the list
        searchHistories.insert(0, searchHistoryCreateResponse.data);

        // Clear search field
        searchController.value.clear();

        AppSnackbar.show(
          message: response['message'] ?? "Search history created successfully",
          isSuccess: true,
        );
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to create search history",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to create search history: $e",
        isSuccess: false,
      );
    } finally {
      isCreating.value = false;
    }
  }

  // DELETE: Delete search history by ID
  Future<void> deleteSearchHistory(String id) async {
    try {
      isDeleting.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.DELETE,
        '${Urls.baseUrl}/searchHistories/$id',
        null,
        is_auth: true,
      );

      if (response['success'] == true) {
        // Remove from local list
        searchHistories.removeWhere((item) => item.id == id);

        AppSnackbar.show(
          message: response['message'] ?? "Search history deleted successfully",
          isSuccess: true,
        );
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to delete search history",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to delete search history: $e",
        isSuccess: false,
      );
    } finally {
      isDeleting.value = false;
    }
  }

  // Clear all search histories
  Future<void> clearAllHistory() async {
    if (searchHistories.isEmpty) return;

    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Clear History'),
        content:
            const Text('Are you sure you want to clear all search history?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await _clearAllHistoryConfirmed();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  Future<void> _clearAllHistoryConfirmed() async {
    final List<String> idsToDelete = searchHistories.map((e) => e.id).toList();

    for (String id in idsToDelete) {
      await deleteSearchHistory(id);
    }
  }

  // Search functionality (if needed for filtering)
  void onSearchChanged(String query) {
    // You can implement search filtering here if needed
    // For now, this is just a placeholder
  }

  // Handle search submission
  void onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      createSearchHistory(query);
    }
  }

  // Select search history item
  void onSearchHistoryTap(SearchHistoryModel searchHistory) {
    searchController.value.text = searchHistory.searchTerm;
    // You can add navigation or other actions here
    // For example: navigating to search results page
  }
}
