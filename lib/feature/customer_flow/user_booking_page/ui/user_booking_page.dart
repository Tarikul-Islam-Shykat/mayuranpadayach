// user_booking_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/controller/user_booking_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/model/user_booking_model.dart';

class UserBookingScreen extends StatelessWidget {
  const UserBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: normalText(
                text: "Booking",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Floating Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Obx(() => Row(
                    children: [
                      _buildTabItem(
                        "Pending",
                        0,
                        controller.selectedTabIndex.value == 0,
                        () => controller.changeTab(0),
                      ),
                      _buildTabItem(
                        "Request",
                        1,
                        controller.selectedTabIndex.value == 1,
                        () => controller.changeTab(1),
                      ),
                      _buildTabItem(
                        "Complete",
                        2,
                        controller.selectedTabIndex.value == 2,
                        () => controller.changeTab(2),
                      ),
                    ],
                  )),
            ),
          ),
          const SizedBox(height: 20),

          // Tab Content with Sliding Animation
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) => controller.onPageChanged(index),
              children: [
                _buildBookingList(
                  controller.pendingBookings,
                  controller.isLoadingPending.value,
                  controller.refreshPendingBookings,
                  controller.navigateToBookingDetails,
                  controller,
                ),
                _buildBookingList(
                  controller.requestBookings,
                  controller.isLoadingRequest.value,
                  controller.refreshRequestBookings,
                  controller.navigateToBookingDetails,
                  controller,
                ),
                _buildBookingList(
                  controller.completedBookings,
                  controller.isLoadingCompleted.value,
                  controller.refreshCompletedBookings,
                  controller.navigateToBookingDetails,
                  controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
      String title, int index, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 50,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF7B4BF5),
                      Color(0xFFBD5FF3),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(
    List<BookingModel> bookings,
    bool isLoading,
    Future<void> Function() onRefresh,
    Function(BookingModel) onTap,
    BookingController controller,
  ) {
    if (isLoading && bookings.isEmpty) {
      return loading();
    }

    if (bookings.isEmpty && !isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No bookings found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your bookings will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: const Color(0xFF8B5CF6),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: bookings.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == bookings.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  color: Color(0xFF8B5CF6),
                ),
              ),
            );
          }

          final booking = bookings[index];
          return _buildBookingCard(booking, onTap, controller);
        },
      ),
    );
  }

  Widget _buildBookingCard(
    BookingModel booking,
    Function(BookingModel) onTap,
    BookingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(booking),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ResponsiveNetworkImage(
                  imageUrl: booking.business.image,
                  shape: ImageShape.roundedRectangle,
                  borderRadius: 12,
                  widthPercent: 0.2,
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
                          text: booking.business.name,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 4),
                      smallText(text: booking.service.name, color: Colors.grey),
                      const SizedBox(height: 4),
                      smallerText(
                          text:
                              'Booking Date: ${controller.formatBookingDate(booking.bookingDate)}',
                          color: Colors.grey),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple.shade50, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF8B5CF6),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        smallerText(
                          text:
                              booking.business.overallRating.toStringAsFixed(2),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
class UserBookingScreen extends StatelessWidget {
  const UserBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: normalText(
            text: "Booking", color: Colors.black, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[600],
          indicator: BoxDecoration(
            // color: const Color(0xFF8B5CF6),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7B4BF5),
                Color(0xFFBD5FF3),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(child: smallText(text: 'Pending', fontWeight: FontWeight.bold)),
            Tab(child: smallText(text: 'Request', fontWeight: FontWeight.bold)),
            Tab(
                child:
                    smallText(text: 'Complete', fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          // Pending Tab
          Obx(() => _buildBookingList(
                controller.pendingBookings,
                controller.isLoadingPending.value,
                controller.refreshPendingBookings,
                controller.navigateToBookingDetails,
                controller,
              )),
          // Request Tab
          Obx(() => _buildBookingList(
                controller.requestBookings,
                controller.isLoadingRequest.value,
                controller.refreshRequestBookings,
                controller.navigateToBookingDetails,
                controller,
              )),
          // Complete Tab
          Obx(() => _buildBookingList(
                controller.completedBookings,
                controller.isLoadingCompleted.value,
                controller.refreshCompletedBookings,
                controller.navigateToBookingDetails,
                controller,
              )),
        ],
      ),
    );
  }

  Widget _buildBookingList(
    List<BookingModel> bookings,
    bool isLoading,
    Future<void> Function() onRefresh,
    Function(BookingModel) onTap,
    BookingController controller,
  ) {
    if (isLoading && bookings.isEmpty) {
      return loading();
      // const Center(
      //   child: CircularProgressIndicator(
      //     color: Color(0xFF8B5CF6),
      //   ),
      // );
    }

    if (bookings.isEmpty && !isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No bookings found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your bookings will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: const Color(0xFF8B5CF6),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == bookings.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  color: Color(0xFF8B5CF6),
                ),
              ),
            );
          }

          final booking = bookings[index];
          return _buildBookingCard(booking, onTap, controller);
        },
      ),
    );
  }

  Widget _buildBookingCard(
    BookingModel booking,
    Function(BookingModel) onTap,
    BookingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(booking),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ResponsiveNetworkImage(
                  imageUrl: booking.business.image,
                  shape: ImageShape.roundedRectangle,
                  borderRadius: 12,
                  widthPercent: 0.2,
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
                          text: booking.business.name,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 4),
                      smallText(text: booking.service.name, color: Colors.grey),
                      const SizedBox(height: 4),
                      smallerText(
                          text:
                              'Booking Date: ${controller.formatBookingDate(booking.bookingDate)}',
                          color: Colors.grey),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),

                // Price, Rating and Status
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple.shade50, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF8B5CF6),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        smallerText(
                          text:
                              booking.business.overallRating.toStringAsFixed(2),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/
