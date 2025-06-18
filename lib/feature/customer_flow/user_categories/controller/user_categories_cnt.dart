import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/model/user_categories_model.dart';

class UserCategoryController extends GetxController {
  final isFetchCategories = false.obs;
  final userDashboardCategoryList = <UserCategoriesModel>[].obs;
  final expandedCategories = <String>[].obs;
  final NetworkConfig _networkConfig = NetworkConfig();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

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

        // Debug: Print fetched categories
        log('Fetched ${fetchedCategories.length} categories');
        for (var category in fetchedCategories) {
          log('Category: ${category.name}, ID: ${category.id}, SubCategories: ${category.subCategories.length}');
        }
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch categories",
          isSuccess: false,
        );
      }
    } catch (e) {
      log('Error fetching categories: $e');
      AppSnackbar.show(
          message: "Failed To Fetch Categories: $e", isSuccess: false);
    } finally {
      isFetchCategories.value = false;
    }
  }

  void toggleCategory(String categoryId) {
    log('Toggling category: $categoryId');
    log('Current expanded categories: ${expandedCategories.toList()}');

    if (expandedCategories.contains(categoryId)) {
      expandedCategories.remove(categoryId);
      log('Removed $categoryId from expanded list');
    } else {
      expandedCategories.add(categoryId);
      log('Added $categoryId to expanded list');
    }

    log('Updated expanded categories: ${expandedCategories.toList()}');
    // Force update to ensure reactivity
    expandedCategories.refresh();
  }

  bool isCategoryExpanded(String categoryId) {
    return expandedCategories.contains(categoryId);
  }

  void selectSubCategory(
      UserCategoriesModel category, SubCategory subCategory) {
    // Print the selected information as requested
    log('Selected Category: ${category.name}');
    log('Category ID: ${category.id}');
    log('Selected Subcategory: ${subCategory.name}');
    log('Subcategory ID: ${subCategory.id}');
    log('---');

    // You can also show a snackbar or navigate to another screen
    Get.snackbar(
      'Selection Made',
      'Category: ${category.name}\nSubcategory: ${subCategory.name}',
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}
