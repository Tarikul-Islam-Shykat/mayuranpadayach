import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/ui/user_booking_page.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/controller/user_dashboard_contrller.dart';
import 'package:prettyrini/feature/customer_flow/user_fav/ui/user_fav_ui.dart';
import 'package:prettyrini/feature/customer_flow/user_home_page/ui/user_home_page.dart';
import 'package:prettyrini/feature/customer_flow/user_search/ui/user_search_page.dart';
import 'package:prettyrini/feature/profile_screen/view/profile_screen.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDashboardContrller controller = Get.put(UserDashboardContrller());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing with increased vertical space
    final double navWidth = screenWidth * 0.95;
    final double navPaddingHorizontal = screenWidth * 0.02;
    final double navPaddingVertical =
        screenHeight * 0.01; // Increased from 0.005 to 0.015
    final double iconSize = screenWidth * 0.1;
    final double fontSize = screenWidth * 0.04;
    final double gap = screenWidth * 0.015;
    final double borderRadius = screenWidth * 0.05;
    final double minHeight =
        screenHeight * 0.08; // Minimum height of 8% of screen height

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.currentNavIndex.value,
              children: [
                UserHomePage(),
                SearchHistoryScreen(),
                UserBookingScreen(),
                FavoritesPage(),
                ProfileScreen(),
              ],
            )),
      ),
      floatingActionButton: Container(
        width: navWidth > 300 ? navWidth : 300,
        height: minHeight, // Added minimum height to increase size
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.015,
          left: screenWidth * 0.025,
          right: screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: screenWidth * 0.04,
              offset: Offset(0, screenHeight * 0.008),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: navPaddingHorizontal,
            vertical: navPaddingVertical,
          ),
          child: Obx(() => GNav(
                rippleColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                hoverColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                gap: gap,
                activeColor: Colors.white,
                iconSize: iconSize,
                padding: EdgeInsets.symmetric(
                  horizontal: navPaddingHorizontal * 0.5,
                  vertical: navPaddingVertical,
                ),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color(0xFF8B5CF6),
                color: Colors.grey[600],
                selectedIndex: controller.currentNavIndex.value,
                onTabChange: controller.onBottomNavTapped,
                textStyle: GoogleFonts.poppins(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                tabs: const [
                  GButton(icon: Icons.home, text: 'Home'),
                  GButton(icon: Icons.search, text: 'Search'),
                  GButton(icon: Icons.calendar_today, text: 'Bookings'),
                  GButton(icon: Icons.favorite, text: 'Favourite'),
                  GButton(icon: Icons.person, text: 'Profile'),
                ],
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
