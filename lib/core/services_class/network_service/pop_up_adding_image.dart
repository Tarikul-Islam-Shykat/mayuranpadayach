import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Import your app colors and size config
import 'package:prettyrini/core/const/app_colors.dart';


import '../../global_widegts/loading_screen.dart';
import 'image_adding_controller.dart';

class GalleryPopupDialog extends StatelessWidget {
  final controller = Get.put(GalleryController());

  GalleryPopupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 20),

            // Gallery Images Grid/List
            Flexible(child: _buildGallerySection(context)),
            SizedBox(height: 20),

            // Add Image Buttons
            _buildImageButtons(context),
            SizedBox(height: 16),
            Obx(() => controller.uploadProgress.value.isNotEmpty
                      ? _buildProgressSection(context)
                      : SizedBox.shrink(),
            ),
            Obx(() => controller.errorMessage.value.isNotEmpty
                      ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          controller.errorMessage.value,
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : SizedBox.shrink(),
            ),
            SizedBox(height: 16),
            Obx(() => controller.isLoading.value
                      ? Center(child: loadingSmall())
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              controller.galleryImages.isNotEmpty
                                  ? () async {
                                    await controller.uploadGalleryImages();
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Upload ${controller.galleryImages.length} Images',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    double progress =
        controller.totalImages.value > 0
            ? controller.currentUploadIndex.value / controller.totalImages.value
            : 0.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Column(
        children: [
          // Progress text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Uploading Images...',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${controller.currentUploadIndex.value}/${controller.totalImages.value}',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Modern progress bar
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                // Background
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Progress fill with gradient
                Container(
                  width: MediaQuery.of(context).size.width * progress * 0.8,
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.blue.shade600,
                        Colors.blue.shade800,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                // Animated shimmer effect
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * progress * 0.8,
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8),

          // Percentage text
          Text(
            '${(progress * 100).toInt()}% Complete',
            style: GoogleFonts.inter(
              color: Colors.white60,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gallery Images',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Obx(
              () => Text(
                '${controller.galleryImages.length} images selected',
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            controller.clearGallery();
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _buildGallerySection(BuildContext context) {
    return Obx(() => controller.galleryImages.isEmpty
              ? _buildEmptyGallery(context)
              : _buildImagesGrid(context),
    );
  }

  Widget _buildEmptyGallery(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.sp,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_library, color: Colors.white, size: 40),
          SizedBox(height: 12),
          Text(
            'No images selected',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagesGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: controller.galleryImages.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                controller.galleryImages[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => controller.removeImage(index),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageButtons(BuildContext context) {
    return Column(
      children: [
        // Multiple Images Button
        GestureDetector(
          onTap: controller.pickMultipleGalleryImages,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade700),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo_library, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'Press to Select Images',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Function to show the gallery dialog
void showGalleryPopup() {
  Get.dialog(GalleryPopupDialog(), barrierDismissible: false);
}
