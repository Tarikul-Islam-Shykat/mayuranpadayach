// screens/search_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_search/controller/search_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_search/model/search_history_model.dart';

class SearchHistoryScreen extends StatelessWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchHistoryController controller =
        Get.put(SearchHistoryController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: loading(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchController.value,
                  onChanged: controller.onSearchChanged,
                  onSubmitted: controller.onSearchSubmitted,
                  decoration: InputDecoration(
                    hintText: 'I am looking for',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                    suffixIcon: Icon(
                      Icons.tune,
                      color: Colors.black,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
            // Header with Clear History button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  normalText(text: 'Recent Searches'),
                  if (controller.searchHistories.isNotEmpty)
                    GestureDetector(
                        onTap: controller.clearAllHistory,
                        child: smallerText(
                            text: 'Clear History',
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Search History Items
            Expanded(
              child: controller.searchHistories.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          normalText(
                              text: 'No search history yet',
                              color: Colors.grey),
                          SizedBox(height: 8),
                          smallText(
                              text: 'Your recent searches will appear here',
                              color: Colors.grey),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      itemCount: controller.searchHistories.length,
                      itemBuilder: (context, index) {
                        final searchHistory = controller.searchHistories[index];
                        return _buildSearchHistoryItem(
                          searchHistory,
                          controller,
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSearchHistoryItem(
    SearchHistoryModel searchHistory,
    SearchHistoryController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => controller.onSearchHistoryTap(searchHistory),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Search icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.history,
                    size: 16,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(width: 12),

                // Search term
                Expanded(child: smallText(text: searchHistory.searchTerm)),

                // Delete button
                Obx(
                  () => controller.isDeleting.value
                      ? loading()
                      : GestureDetector(
                          onTap: () => _showDeleteConfirmation(
                            searchHistory,
                            controller,
                          ),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    SearchHistoryModel searchHistory,
    SearchHistoryController controller,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Search'),
        content: Text(
            'Are you sure you want to delete "${searchHistory.searchTerm}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteSearchHistory(searchHistory.id);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
