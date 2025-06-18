import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_fav/controller/user_fav_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_fav/model/user_fav_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesController controller = Get.put(FavoritesController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        title: headingText(text: 'Favorite', fontWeight: FontWeight.bold),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
      ),
      body: Obx(() {
        if (controller.isFavLoading.value) {
          return loading();
        }

        if (controller.errorMessage.value.isNotEmpty) {
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
                  onPressed: controller.refreshFavorites,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.favoriteStudios.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                headingText(
                    text: 'No favorites yet',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 8),
                smallText(
                    text: 'Add some studios to your favorites',
                    color: Colors.grey)
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshFavorites(),
          color: Colors.purple,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.favoriteStudios.length,
            itemBuilder: (context, index) {
              final favData = controller.favoriteStudios[index];
              return FavoriteStudioCard(
                fav: favData,
                onToggleFavorite: () => controller.toggleFavorite(favData.id),
                onTap: () {
                  // Get.to(() => StudioDetailsPage(studioId: studio.id));
                },
              );
            },
          ),
        );
      }),
    );
  }
}

class FavoriteStudioCard extends StatelessWidget {
  final FavoriteItem fav;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  const FavoriteStudioCard({
    Key? key,
    required this.fav,
    required this.onToggleFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Studio Image
              ResponsiveNetworkImage(
                imageUrl: fav.business.image,
                shape: ImageShape.roundedRectangle,
                borderRadius: 12,
                widthPercent: 0.25,
                heightPercent: 0.1,
                fit: BoxFit.cover,
                placeholderWidget: loading(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalText(
                        text: fav.business.name, fontWeight: FontWeight.bold),
                    smallText(
                        text: fav.business.category.name, color: Colors.grey),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        smallerText(text: 'Booking Date: ', color: Colors.grey),
                        smallerText(
                            text: DateFormat('dd MMM, yyyy')
                                .format(fav.createdAt),
                            color: Colors.grey)

                        // smallerText(text: fav.createdAt.toIso8601String()),
                      ],
                    ),
                  ],
                ),
              ),

              // Rating and Favorite Button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: onToggleFavorite,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.purple.shade50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.purple,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.purple,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      smallText(text: fav.business.overallRating.toString())
                      // Text(
                      //   studio.rating.toStringAsFixed(1),
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
