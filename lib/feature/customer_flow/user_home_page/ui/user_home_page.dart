import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/controller/user_dashboard_contrller.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/widget/buisness_list_widget.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/widget/card_swiper_.dart';

class UserHomePage extends StatelessWidget {
  final UserDashboardContrller controller = Get.put(UserDashboardContrller());

  UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(controller),
            _buildSearchBar(controller),
            SizedBox(
              height: 10,
            ),
            _buildCategories(controller, context),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: headingText(
                  text: 'Special Offer', fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: BusinessCardSwiper()),
            _buildNearbyProfessionals(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(UserDashboardContrller controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ResponsiveNetworkImage(
            imageUrl: controller.userImagePath.value,
            shape: ImageShape.circle,
            widthPercent: 0.1,
            heightPercent: 0.05,
            fit: BoxFit.cover,
            placeholderWidget: loading(),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smallText(
                text: 'Welcome back',
                color: Colors.grey,
              ),
              Obx(() => normalText(
                  text: controller.userName.value,
                  fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
              iconSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(UserDashboardContrller controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
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
        child: TextField(
          onChanged: controller.onSearchChanged,
          decoration: InputDecoration(
            hintText: 'I am looking for',
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildCategories(
      UserDashboardContrller controller, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingText(text: 'Categories', fontWeight: FontWeight.bold),
          const SizedBox(height: 15),
          Obx(() => Row(
                children: List.generate(
                    controller.userDashboardCategoryList.length, (index) {
                  final category = controller.userDashboardCategoryList[index];
                  return GestureDetector(
                    onTap: () => controller.onCategorySelected(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ResponsiveNetworkImage(
                                imageUrl: category.image.toString(),
                                shape: ImageShape.circle,
                                widthPercent: 0.12,
                                heightPercent: 0.06,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          smallerText(text: category.name),
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ],
      ),
    );
  }

  Widget _buildNearbyProfessionals(UserDashboardContrller controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              headingText(text: "Featured Business"),
              GestureDetector(
                  onTap: controller.onSeeAllNearbyProfessionals,
                  child: smallText(
                      text: 'See All',
                      color: Color(0xFF8B5CF6),
                      fontWeight: FontWeight.bold)),
            ],
          ),

          SizedBox(
            height: 800, // Fixed height for the business list
            child: BusinessListWidget(),
          ),
          const SizedBox(height: 16),
          // Obx(() => ListView.builder(
          //       shrinkWrap: true,
          //       physics: const NeverScrollableScrollPhysics(),
          //       itemCount: controller.filteredStudios.length,
          //       itemBuilder: (context, index) {
          //         final studio = controller.filteredStudios[index];
          //         return _buildProfessionalCard(studio, controller);
          //       },
          //     )),
        ],
      ),
    );
  }
}
