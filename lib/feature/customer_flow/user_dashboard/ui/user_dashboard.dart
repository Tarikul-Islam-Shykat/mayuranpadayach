// views/home_page.dart

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
    // final BusinessListController controllerOne =
    //     Get.put(BusinessListController());

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
      // Remove the regular bottomNavigationBar and use floatingActionButton instead
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: 0,
            ),
          ],
        ),
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
