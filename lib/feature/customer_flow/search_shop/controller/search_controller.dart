import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/customer_flow/search_shop/ui/user_filter_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final RxList<String> recentSearches = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList('recent_searches') ?? [];
    recentSearches.assignAll(searches);
  }

  Future<void> addToRecentSearches(String searchText) async {
    if (searchText.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    // Remove if already exists
    recentSearches.remove(searchText);

    // Add to beginning
    recentSearches.insert(0, searchText);

    // Keep only last 6 items
    if (recentSearches.length > 6) {
      recentSearches.removeRange(6, recentSearches.length);
    }

    await prefs.setStringList('recent_searches', recentSearches);
    update();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
    recentSearches.clear();
    update();
  }

  void performSearch() {
    if (searchTextController.text.trim().isNotEmpty) {
      addToRecentSearches(searchTextController.text.trim());
      Get.to(() => FilterPage(), arguments: searchTextController.text);
    }
  }

  void searchFromHistory(String searchText) {
    searchTextController.text = searchText;
    addToRecentSearches(searchText);
    Get.to(() => FilterPage(), arguments: searchText);
  }
}
