import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_categories/controller/user_categories_cnt.dart';

class UserCategoryScreen extends StatefulWidget {
  @override
  _UserCategoryScreenState createState() => _UserCategoryScreenState();
}

class _UserCategoryScreenState extends State<UserCategoryScreen> {
  final UserCategoryController controller = Get.put(UserCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Center(
            child: normalText(
                text: 'Select Category', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.isFetchCategories.value) {
          return Center(
            child: loading(),
          );
        }

        if (controller.userDashboardCategoryList.isEmpty) {
          return Center(
            child: normalText(
              text: 'No categories available',
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.userDashboardCategoryList.length,
          itemBuilder: (context, index) {
            final category = controller.userDashboardCategoryList[index];

            return Obx(() {
              final isExpanded = controller.isCategoryExpanded(category.id);

              return Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Main Category Header
                    InkWell(
                      onTap: () {
                        print(
                            'Tapping category: ${category.name} (${category.id})');
                        controller.toggleCategory(category.id);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                                child: normalText(
                                    text: category.name,
                                    fontWeight: FontWeight.bold)),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.arrow_forward_ios,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Subcategories with AnimatedContainer for smooth expansion
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: isExpanded && category.subCategories.isNotEmpty
                          ? category.subCategories.length * 100.0
                          : 0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: category.subCategories.map((subCategory) {
                              return InkWell(
                                onTap: () => controller.selectSubCategory(
                                    category, subCategory),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[100]!,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.deepPurple
                                                  .withValues(alpha: 0.1)),
                                          child: smallText(
                                              text: subCategory.name)),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      }),
    );
  }
}
