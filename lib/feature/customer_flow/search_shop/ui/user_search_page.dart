import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/user/search_shop/controller/search_controller.dart';

class SearchPage extends StatelessWidget {
  final UserSearchController controller = Get.put(UserSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchTextController,
                  decoration: InputDecoration(
                    hintText: 'I am looking for',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.tune, color: Colors.grey),
                      onPressed: controller.performSearch,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onSubmitted: (_) => controller.performSearch(),
                ),
              ),

              SizedBox(height: 30),

              // Recent Searches Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Obx(() => controller.recentSearches.isNotEmpty
                      ? TextButton(
                          onPressed: controller.clearHistory,
                          child: Text(
                            'Clear History',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : SizedBox()),
                ],
              ),

              SizedBox(height: 15),

              // Recent Search Tags
              Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.recentSearches
                    .map((search) => GestureDetector(
                          onTap: () => controller.searchFromHistory(search),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.history, size: 16, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  search,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}