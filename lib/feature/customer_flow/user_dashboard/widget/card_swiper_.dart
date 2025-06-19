// business_card_swiper.dart
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/controller/card_swiper_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/model/buisness_model.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/widget/discount_badge.dart';
import 'package:prettyrini/route/route.dart';

class BusinessCardSwiper extends StatelessWidget {
  final CardSwiperVController controller = Get.put(CardSwiperVController());
  final CardSwiperController cardController = CardSwiperController();

  BusinessCardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isBusinessDataLoading.value &&
              controller.businessList.isEmpty) {
            return Center(
              child: loading(),
            );
          }

          if (controller.businessList.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: CardSwiper(
                  controller: cardController,
                  cardsCount: controller.businessList.length,
                  onSwipe: (previousIndex, currentIndex, direction) {
                    controller.onCardSwiped(currentIndex ?? 0);
                    if (direction == CardSwiperDirection.left ||
                        direction == CardSwiperDirection.right) {
                      controller.removeCard(previousIndex);
                    }
                    return true;
                  },
                  onUndo: (previousIndex, currentIndex, direction) {
                    // Handle undo logic if needed
                    return true;
                  },
                  numberOfCardsDisplayed: controller.businessList.length >= 3
                      ? 3
                      : controller.businessList.length,
                  backCardOffset: const Offset(0, -20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  cardBuilder:
                      (context, index, horizontalThreshold, verticalThreshold) {
                    if (index < controller.businessList.length) {
                      return _buildBusinessCard(controller.businessList[index]);
                    }
                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildSliderIndicators(),
            ],
          );
        }),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         const Text(
  //           'Discover Businesses',
  //           style: TextStyle(
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black87,
  //           ),
  //         ),
  //         IconButton(
  //           onPressed: () => controller.reloadData(),
  //           icon: const Icon(Icons.refresh),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildBusinessCard(CardSwiperBusiness business) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.userServiceDetailsPage);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: business.image.isNotEmpty
                    ? ResponsiveNetworkImage(
                        imageUrl: business.image,
                        shape: ImageShape.roundedRectangle,
                        borderRadius: 12,
                        widthPercent: 0.9,
                        heightPercent: 0.2,
                        fit: BoxFit.cover,
                        placeholderWidget: loading(),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),
              // Business Image
              // Positioned.fill(
              //   child: business.image.isNotEmpty
              //       ? Image.network(
              //           business.image,
              //           fit: BoxFit.cover,
              //           errorBuilder: (context, error, stackTrace) {
              //             return Container(
              //               color: Colors.grey[300],
              //               child: const Icon(
              //                 Icons.business,
              //                 size: 50,
              //                 color: Colors.grey,
              //               ),
              //             );
              //           },
              //         )
              //       : Container(
              //           color: Colors.grey[300],
              //           child: const Icon(
              //             Icons.business,
              //             size: 50,
              //             color: Colors.grey,
              //           ),
              //         ),
              // ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
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
              ),

              // Business Info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: normalText(
                              text: business.category.name,
                              color: Colors.white)),
                      const SizedBox(height: 16),
                      headingText(text: business.name, color: Colors.white),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                smallText(
                                    text: controller.getFormattedRating(
                                        business.overallRating),
                                    color: Colors.white),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          smallText(text: '120 reviews', color: Colors.grey)
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Address
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.location_on,
                      //       color: Colors.white,
                      //       size: 16,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Expanded(
                      //       child: Text(
                      //         business.address,
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           color: Colors.white.withOpacity(0.9),
                      //         ),
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      const SizedBox(height: 8),

                      // Status and Hours
                      // Row(
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 8, vertical: 4),
                      //       decoration: BoxDecoration(
                      //         color: controller.isBusinessOpen(business)
                      //             ? Colors.green
                      //             : Colors.red,
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       child: Text(
                      //         business.openStatus,
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 12),
                      //     Text(
                      //       '${business.openingHours} - ${business.closingHours}',
                      //       style: TextStyle(
                      //         fontSize: 12,
                      //         color: Colors.white.withOpacity(0.8),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),

              Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                        color: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  )),

              Positioned(
                  bottom: 70,
                  right: -10,
                  child: DiscountBadge(
                      discount: "-20%", color: Colors.purpleAccent)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderIndicators() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            controller.businessList.length > 5
                ? 5
                : controller.businessList.length,
            (index) {
              bool isActive = index == controller.currentIndex.value;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Reject Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                //        cardController.swipeLeft();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 28,
              ),
            ),
          ),

          const SizedBox(width: 40),

          // Like Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                //  cardController.swipeRight();
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.green,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business_center,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          normalText(text: 'No more businesses to show', color: Colors.black),
          const SizedBox(height: 8),
          smallText(
              text: 'Swipe to discover more businesses', color: Colors.grey),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => controller.reloadData(),
            icon: const Icon(Icons.refresh),
            // label: const Text('Reload'),
            label: smallText(text: 'Reload', color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage:
// DiscountBadge(discount: "-20%")
// DiscountBadge(discount: "-20%", color: Colors.red)
