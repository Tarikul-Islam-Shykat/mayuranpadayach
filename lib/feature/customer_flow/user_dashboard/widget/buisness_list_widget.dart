// business_list_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/controller/user_buisness_list_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/model/user_featured_business_model.dart';

class BusinessListWidget extends StatelessWidget {
  final BusinessListController controller = Get.put(BusinessListController());

  BusinessListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.businessList.isEmpty) {
        return Center(
          child: loading(),
        );
      }

      if (controller.errorMessage.isNotEmpty &&
          controller.businessList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                controller.errorMessage.value,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.refreshBusinessList(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (controller.businessList.isEmpty) {
        return const Center(
          child: Text('No businesses found'),
        );
      }

      return RefreshIndicator(
        onRefresh: () => controller.refreshBusinessList(),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.businessList.length +
                    (controller.hasMoreData.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.businessList.length) {
                    // Loading indicator at the bottom
                    return Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: controller.isLoadingMore.value
                          ? loading()
                          : const SizedBox.shrink(),
                    );
                  }

                  final business = controller.businessList[index];
                  return BusinessCard(business: business);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class BusinessCard extends StatelessWidget {
  final Business business;

  const BusinessCard({
    Key? key,
    required this.business,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Handle business card tap
          // You can navigate to business details page
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Business Image
                  ResponsiveNetworkImage(
                    imageUrl: business.image,
                    shape: ImageShape.roundedRectangle,
                    borderRadius: 12,
                    widthPercent: 0.2,
                    heightPercent: 0.1,
                    fit: BoxFit.cover,
                    placeholderWidget: loading(),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            normalText(
                                text: business.name,
                                fontWeight: FontWeight.bold),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.deepPurple.withValues(alpha: 0.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        smallerText(
                            text: business.category.name,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            smallerText(
                                text: business.subCategory.name,
                                color: Colors.grey),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 22,
                                  color: Colors.purple,
                                ),
                                const SizedBox(width: 4),
                                smallerText(
                                    fontWeight: FontWeight.bold,
                                    text: business.overallRating
                                        .toStringAsFixed(1))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Rating (if available)
            ],
          ),
        ),
      ),
    );
  }
}

/*
// How to use in your existing UI

// 1. In your existing page where you want to show the business list:
class YourExistingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses'),
      ),
      body: Column(
        children: [
          // Your existing UI components here
          Container(
            padding: const EdgeInsets.all(16),
            child: Text('Your existing content above'),
          ),
          
          // Add the business list widget
          Expanded(
            child: BusinessListWidget(),
          ),
        ],
      ),
    );
  }
}

// 2. Or if you want to embed it in a specific section:
class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your existing scrollable content
            YourExistingContent(),
            
            // Business list section
            Container(
              height: 400, // Fixed height for the business list
              child: BusinessListWidget(),
            ),
            
            // More content below
            YourOtherContent(),
          ],
        ),
      ),
    );
  }
}

// 3. If you want to access the controller from another widget:
class SomeOtherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BusinessListController businessController = Get.find<BusinessListController>();
    
    return Obx(() {
      return Text('Total businesses: ${businessController.businessList.length}');
    });
  }
}

// 4. To manually trigger refresh from anywhere:
void refreshBusinesses() {
  final BusinessListController controller = Get.find<BusinessListController>();
  controller.refreshBusinessList();
}

// 5. To get specific business data:
void getBusinessInfo() {
  final BusinessListController controller = Get.find<BusinessListController>();
  
  // Get open businesses
  List<Business> openBusinesses = controller.getOpenBusinesses();
  
  // Get business by ID
  Business? specificBusiness = controller.getBusinessById('some-id');
  
  // Get businesses by category
  List<Business> categoryBusinesses = controller.getBusinessesByCategory('category-id');
}
*/
