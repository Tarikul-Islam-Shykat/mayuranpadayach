// lib/widgets/portfolio_tab.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/controller/service_details_cnt.dart';

class PortfolioTab extends StatelessWidget {
  const PortfolioTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StudioController controller = Get.find<StudioController>();
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headingText(
                  text:
                      'All Portfolio (${controller.businessPortfolios.length})',
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 16),
              if (controller.businessPortfolios.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No portfolio items available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                // Main featured image
                GestureDetector(
                  onTap: () => _showImagePreview(
                    context,
                    controller.businessPortfolios.first.image,
                    controller.businessPortfolios.first.title,
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                    child: controller.businessPortfolios.first.image.isNotEmpty
                        ? ResponsiveNetworkImage(
                            imageUrl: controller.businessPortfolios.first.image,
                            shape: ImageShape.roundedRectangle,
                            borderRadius: 12,
                            widthPercent: 1.0,
                            fit: BoxFit.cover,
                            placeholderWidget: Container(
                              height: 200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: _buildImagePlaceholder(),
                          )
                        : _buildImagePlaceholder(),
                  ),
                ),

                // Portfolio title for featured image
                if (controller.businessPortfolios.first.title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: normalText(
                      text: controller.businessPortfolios.first.title,
                    ),
                  ),

                // Portfolio grid for remaining images
                if (controller.businessPortfolios.length > 1) ...[
                  headingText(text: 'More Works', fontWeight: FontWeight.bold),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.businessPortfolios.length - 1,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        // Skip the first image as it's already shown above
                        final portfolioIndex = index + 1;
                        final portfolioItem =
                            controller.businessPortfolios[portfolioIndex];

                        return GestureDetector(
                          onTap: () => _showImagePreview(
                            context,
                            portfolioItem.image,
                            portfolioItem.title,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: portfolioItem.image.isNotEmpty
                                    ? ResponsiveNetworkImage(
                                        imageUrl: portfolioItem.image,
                                        shape: ImageShape.roundedRectangle,
                                        borderRadius: 12,
                                        fit: BoxFit.cover,
                                        placeholderWidget: loading(),
                                        errorWidget:
                                            _buildSmallImagePlaceholder(),
                                      )
                                    : _buildSmallImagePlaceholder(),
                              ),
                              if (portfolioItem.title.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    portfolioItem.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Specialist info section (if available)
                // if (controller.businessPortfolios.isNotEmpty &&
                //     controller.businessPortfolios.first.specialist.fullName
                //         .isNotEmpty) ...[
                //   // const Text(
                //   //   'Portfolio by',
                //   //   style: TextStyle(
                //   //     fontSize: 16,
                //   //     fontWeight: FontWeight.w600,
                //   //   ),
                //   // ),
                //   //  const SizedBox(height: 8),
                //   // Row(
                //   //   children: [
                //   //     Container(
                //   //       width: 40,
                //   //       height: 40,
                //   //       decoration: BoxDecoration(
                //   //         shape: BoxShape.circle,
                //   //         color: Colors.grey.shade200,
                //   //       ),
                //   //       child: controller.businessPortfolios.first.specialist
                //   //               .profileImage.isNotEmpty
                //   //           ? ResponsiveNetworkImage(
                //   //               imageUrl: controller.businessPortfolios.first
                //   //                   .specialist.profileImage,
                //   //               shape: ImageShape.circle,
                //   //               fit: BoxFit.cover,
                //   //               errorWidget: _buildSpecialistAvatar(controller
                //   //                   .businessPortfolios
                //   //                   .first
                //   //                   .specialist
                //   //                   .fullName),
                //   //             )
                //   //           : _buildSpecialistAvatar(controller
                //   //               .businessPortfolios.first.specialist.fullName),
                //   //     ),
                //   //     const SizedBox(width: 12),
                //   //     Text(
                //   //       controller.businessPortfolios.first.specialist.fullName,
                //   //       style: const TextStyle(
                //   //         fontSize: 14,
                //   //         fontWeight: FontWeight.w500,
                //   //       ),
                //   //     ),
                //   //   ],
                //   // ),
                // ],
              ],
            ],
          ),
        ));
  }

  // Build placeholder for main featured image
  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'Image not available',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // Build placeholder for small grid images
  Widget _buildSmallImagePlaceholder() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey.shade100,
      child: Icon(
        Icons.image_outlined,
        size: 32,
        color: Colors.grey.shade400,
      ),
    );
  }

  // Build default avatar for specialist
  Widget _buildSpecialistAvatar(String fullName) {
    String initials = '';
    if (fullName.isNotEmpty) {
      List<String> names = fullName.split(' ');
      initials = names.length >= 2
          ? '${names[0][0]}${names[1][0]}'.toUpperCase()
          : names[0][0].toUpperCase();
    } else {
      initials = 'S';
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.shade100,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context, String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image
                    Flexible(
                      child: imageUrl.isNotEmpty
                          ? ResponsiveNetworkImage(
                              imageUrl: imageUrl,
                              shape: ImageShape.roundedRectangle,
                              borderRadius: 12,
                              widthPercent: 1.0,
                              fit: BoxFit.contain,
                              placeholderWidget: Container(
                                height: 300,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              errorWidget: Container(
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image_outlined,
                                      size: 64,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Failed to load image',
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No image available',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    // Title
                    if (title.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                        ),
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
