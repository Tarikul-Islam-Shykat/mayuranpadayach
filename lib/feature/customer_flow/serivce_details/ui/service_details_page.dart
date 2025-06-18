// lib/pages/studio_detail_page.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/controller/service_details_cnt.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/sub_view/about_tab.dart'
    show AboutTab;
import 'package:prettyrini/feature/customer_flow/serivce_details/sub_view/portfolio_tab.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/sub_view/review_tab.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/sub_view/service_tab.dart';

class ServiceDetailsPage extends StatelessWidget {
  final StudioController controller = Get.put(StudioController());

  ServiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isFetchingBuisnessisLoading.value) {
          return Center(child: loading(value: 50));
        }

        if (controller.currentStudio == null) {
          return const Center(child: Text('No studio data available'));
        }

        // log("CustomScrollView ${controller.businessDetails.value!.image}");

        return CustomScrollView(
          slivers: [
            // App Bar with image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Main studio image
                    controller.businessDetails.value != null
                        ? ResponsiveNetworkImage(
                            imageUrl: controller
                                .businessDetails.value!.category.image,
                            shape: ImageShape.roundedRectangle,
                            borderRadius: 12,
                            widthPercent: 1,
                            heightPercent: 0.2,
                            fit: BoxFit.cover,
                            placeholderWidget: loading(),
                          )
                        : ResponsiveNetworkImage(
                            imageUrl: "",
                            shape: ImageShape.roundedRectangle,
                            borderRadius: 12,
                            widthPercent: 1,
                            heightPercent: 0.2,
                            fit: BoxFit.cover,
                            placeholderWidget: loading(),
                          ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    // Location and heart buttons
                    /*
                    
                    GestureDetector(
                      onTap: () {
                        final lat = controller.businessDetails.value!.latitude;
                        final long =
                            controller.businessDetails.value!.longitude;

                        final googleMapsUrl = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=$lat,$long');

                        launchUrl(googleMapsUrl,
                            mode: LaunchMode.externalApplication);
                      },
                    */
                    Positioned(
                      top: 50,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.red, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              controller.businessDetails.value!.address,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 16,
                      child: GestureDetector(
                        onTap: controller.toggleFavorite,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            controller.isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    // Studio info at bottom
                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(
                              text: controller.businessDetails.value!.name,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              smallerText(
                                  text:
                                      controller.businessDetails.value!.status,
                                  color: Colors.white),
                              const Spacer(),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: smallText(
                                      text: controller
                                          .businessDetails.value!.openStatus)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Share functionality
                  },
                ),
              ],
            ),

            // Tab buttons
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: List.generate(
                    controller.tabNames.length,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeTab(index),
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: controller.selectedTabIndex.value == index
                                  ? const Color(0xFF6B46C1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color:
                                    controller.selectedTabIndex.value == index
                                        ? const Color(0xFF6B46C1)
                                        : Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: smallText(
                                text: controller.tabNames[index],
                                textAlign: TextAlign.center,
                                color:
                                    controller.selectedTabIndex.value == index
                                        ? Colors.white
                                        : Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Tab content
            SliverToBoxAdapter(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildTabContent(),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTabContent() {
    switch (controller.selectedTabIndex.value) {
      case 0:
        return ServicesTab(key: const ValueKey('services'));
      case 1:
        return ReviewTab(key: const ValueKey('review'));
      case 2:
        return PortfolioTab(key: const ValueKey('portfolio'));
      case 3:
        return AboutTab(key: const ValueKey('about'));
      default:
        return ServicesTab(key: const ValueKey('services'));
    }
  }
}
