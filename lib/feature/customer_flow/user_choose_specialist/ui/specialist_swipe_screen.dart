// screens/specialist_swiper_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prettyrini/feature/customer_flow/user_choose_specialist/controller/specialist_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_choose_specialist/widget/specialist_card_widget.dart';

class SpecialistSwiperScreen extends StatelessWidget {
  const SpecialistSwiperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpecialistController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            _buildHeader(context),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    // Card Swiper Section
                    _buildCardSwiper(controller),

                    // Action Buttons
                    _buildActionButtons(controller),

                    const SizedBox(height: 16),

                    // Portfolio Section
                    _buildPortfolioSection(controller),

                    // Add bottom padding for better scrolling experience
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          const Text(
            'Choose a Specialist',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSwiper(SpecialistController controller) {
    return Obx(() {
      if (controller.specialists.isEmpty) {
        return const SizedBox(
          height: 500,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return Container(
        height: 500,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CardSwiper(
          controller: controller.cardController,
          cardsCount: controller.specialists.length,
          onSwipe: controller.onSwipe,
          numberOfCardsDisplayed: 3,
          backCardOffset: const Offset(0, -30),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
              horizontal: true, vertical: true),
          cardBuilder: (context, index, horizontalThresholdPercentage,
              verticalThresholdPercentage) {
            // Create stacked effect with different scales and positions
            final bool isTopCard = index == controller.currentIndex.value;
            final bool isSecondCard = index ==
                (controller.currentIndex.value + 1) %
                    controller.specialists.length;

            return Transform.scale(
              scale: isTopCard ? 1.0 : (isSecondCard ? 0.95 : 0.9),
              child: Container(
                margin: EdgeInsets.only(
                  top: isTopCard ? 0 : (isSecondCard ? 15 : 30),
                  left: isTopCard ? 0 : (isSecondCard ? 8 : 16),
                  right: isTopCard ? 0 : (isSecondCard ? 8 : 16),
                ),
                child: Opacity(
                  opacity: isTopCard ? 1.0 : (isSecondCard ? 0.8 : 0.6),
                  child: SpecialistCardWidget(
                    specialist: controller.specialists[index],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildActionButtons(SpecialistController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Dislike Button
          _buildActionButton(
            onTap: controller.dislikeCurrentCard,
            backgroundColor: Colors.red.shade100,
            iconColor: Colors.red,
            icon: Icons.close,
            size: 50,
          ),

          // Super Like Button
          _buildActionButton(
            onTap: controller.superLikeCurrentCard,
            backgroundColor: Colors.blue.shade100,
            iconColor: Colors.blue,
            icon: Icons.star,
            size: 45,
          ),

          // Like Button
          _buildActionButton(
            onTap: controller.likeCurrentCard,
            backgroundColor: Colors.green.shade100,
            iconColor: Colors.green,
            icon: Icons.favorite,
            size: 50,
          ),

          // Add Button
          _buildActionButton(
            onTap: controller.addSpecialist,
            backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.2),
            iconColor: const Color(0xFF8B5CF6),
            icon: Icons.add,
            size: 45,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color iconColor,
    required IconData icon,
    required double size,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.4,
        ),
      ),
    );
  }

  Widget _buildPortfolioSection(SpecialistController controller) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Portfolio Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Best Work',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Obx(() => Text(
                    controller.specialists.isNotEmpty
                        ? '${controller.currentSpecialistName.value} Portfolio'
                        : 'Portfolio',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8B5CF6),
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 12),

          // Portfolio Grid - Fully scrollable without height constraints
          Obx(() {
            if (controller.specialists.isEmpty) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final currentSpec =
                controller.specialists[controller.currentIndex.value];

            return GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Let parent handle scrolling
              shrinkWrap: true, // Size itself based on content
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: currentSpec.portfolioImages.isNotEmpty
                  ? currentSpec.portfolioImages.length
                  : 6,
              itemBuilder: (context, index) {
                // Handle case where portfolio has fewer images
                if (currentSpec.portfolioImages.isEmpty) {
                  return _buildPlaceholderImage();
                }

                final imageIndex = index < currentSpec.portfolioImages.length
                    ? index
                    : index % currentSpec.portfolioImages.length;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      currentSpec.portfolioImages[imageIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage();
                      },
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}
