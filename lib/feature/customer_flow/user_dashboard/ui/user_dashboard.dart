// views/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/studio_model.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/controller/user_buisness_list_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/controller/user_dashboard_contrller.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/widget/buisness_list_widget.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDashboardContrller controller = Get.put(UserDashboardContrller());
    final BusinessListController controllerOne =
        Get.put(BusinessListController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.currentNavIndex.value,
              children: [
                _buildHomeContent(controller, context),
                _buildDummyPage("Search", Icons.search),
                _buildDummyPage("Bookings", Icons.calendar_today),
                _buildDummyPage("Messages", Icons.message),
                _buildDummyPage("Profile", Icons.person),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Obx(() => GNav(
                  rippleColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                  hoverColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: const Color(0xFF8B5CF6),
                  color: Colors.grey[600],
                  selectedIndex: controller.currentNavIndex.value,
                  onTabChange: controller.onBottomNavTapped,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.search, text: 'Search'),
                    GButton(icon: Icons.calendar_today, text: 'Bookings'),
                    GButton(icon: Icons.message, text: 'Messages'),
                    GButton(icon: Icons.person, text: 'Profile'),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(
      UserDashboardContrller controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(controller),
          _buildSearchBar(controller),
          _buildCategories(controller, context),
          _buildSpecialOffers(controller),
          _buildNearbyProfessionals(controller),
        ],
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
              ),
              Obx(() => normalText(
                  text: controller.userName.value,
                  fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            iconSize: 24,
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingText(text: 'Categories', fontWeight: FontWeight.bold),
          const SizedBox(height: 12),
          Obx(() => Row(
                children: List.generate(
                    controller.userDashboardCategoryList.length, (index) {
                  final category = controller.userDashboardCategoryList[index];

                  return GestureDetector(
                    onTap: () => controller.onCategorySelected(index),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ResponsiveNetworkImage(
                            imageUrl: category.image.toString(),
                            shape: ImageShape.circle,
                            widthPercent: 0.15,
                            heightPercent: 0.08,
                            fit: BoxFit.cover,
                          ),
                          smallerText(
                              text: category.name, fontWeight: FontWeight.bold),
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

  Widget _buildSpecialOffers(UserDashboardContrller controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              headingText(text: "Special Offer"),
              GestureDetector(
                  onTap: controller.onSeeAllSpecialOffers,
                  child: smallText(
                      text: 'See All',
                      color: Color(0xFF8B5CF6),
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => controller.filteredStudios.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    _buildCustomCarousel(controller),
                    const SizedBox(height: 12),
                    _buildCarouselIndicators(controller),
                  ],
                )),
        ],
      ),
    );
  }

  Widget _buildCustomCarousel(UserDashboardContrller controller) {
    return SizedBox(
      height: 180,
      child: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: Container(
              key: ValueKey(controller.currentCarouselIndex.value),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildSpecialOfferCard(
                controller
                    .filteredStudios[controller.currentCarouselIndex.value],
                controller,
              ),
            ),
          )),
    );
  }

  Widget _buildCarouselIndicators(UserDashboardContrller controller) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.filteredStudios.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => controller.onCarouselPageChanged(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width:
                    controller.currentCarouselIndex.value == entry.key ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: controller.currentCarouselIndex.value == entry.key
                      ? const Color(0xFF8B5CF6)
                      : Colors.grey[300],
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildSpecialOfferCard(
      StudioModel studio, UserDashboardContrller controller) {
    return GestureDetector(
      onTap: () => controller.onStudioTapped(studio),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
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
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${studio.discountPercentage}% OFF',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studio.name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${studio.rating}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${studio.totalReviews} reviews',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

          Container(
            height: 400, // Fixed height for the business list
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

  Widget _buildProfessionalCard(
      StudioModel studio, UserDashboardContrller controller) {
    return GestureDetector(
      onTap: () => controller.onStudioTapped(studio),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.business,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studio.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    studio.category,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    studio.contactInfo.address,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${studio.rating}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDummyPage(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '$title Page',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
