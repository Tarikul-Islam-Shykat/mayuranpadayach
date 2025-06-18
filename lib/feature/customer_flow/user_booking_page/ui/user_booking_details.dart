// user_booking_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/controller/user_booking_controller.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/model/user_booking_model.dart';

class UserBookingDetailsScreenVersion2 extends StatelessWidget {
  final BookingModel booking;

  const UserBookingDetailsScreenVersion2({Key? key, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: normalText(
            text: 'Booking Details',
            color: Colors.black,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Services
            _buildSectionCard(
              title: 'Selected Services',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF7B4BF5), // Start color
                      Color(0xFFBD5FF3), // End color
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    ResponsiveNetworkImage(
                      imageUrl: booking.business.image,
                      shape: ImageShape.roundedRectangle,
                      borderRadius: 12,
                      widthPercent: 0.1,
                      heightPercent: 0.05,
                      fit: BoxFit.cover,
                      placeholderWidget: loading(colors: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(
                              text: booking.service.name, color: Colors.white),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              smallText(
                                  text:
                                      '\$${booking.service.price.toStringAsFixed(0)}',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              smallerText(
                                  text: " / 1 hour", color: Colors.white)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Add Specialist
            _buildSectionCard(
              title: 'Add Specialist',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF7B4BF5), // Start color
                      Color(0xFFBD5FF3), // End color
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    ResponsiveNetworkImage(
                      imageUrl: booking.specialist.profileImage,
                      shape: ImageShape.roundedRectangle,
                      borderRadius: 12,
                      widthPercent: 0.1,
                      heightPercent: 0.05,
                      fit: BoxFit.cover,
                      placeholderWidget: loading(colors: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(
                              text: booking.specialist.fullName,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          const SizedBox(height: 4),
                          smallerText(
                              text: booking.specialist.specialization,
                              color: Colors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Date
            _buildSectionCard(
              title: 'Date',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    smallText(
                        text: controller.formatBookingDate(booking.bookingDate))
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Choose Timeslot
            _buildSectionCard(
              title: 'Choose Timeslot',
              child: Column(
                children: [
                  _buildTimeSlotRow(
                    ['09:00 - 10:00', '10:00 - 11:00', '11:00 - 12:00'],
                    selectedTime:
                        controller.formatBookingTime(booking.bookingDate),
                  ),
                  const SizedBox(height: 12),
                  _buildTimeSlotRow(
                    ['03:00 - 04:00', '04:00 - 05:00', '05:00 - 06:00'],
                    selectedTime:
                        controller.formatBookingTime(booking.bookingDate),
                  ),
                  const SizedBox(height: 12),
                  _buildTimeSlotRow(
                    ['07:00 - 08:00', '08:00 - 09:00', '09:00 - 10:00'],
                    selectedTime:
                        controller.formatBookingTime(booking.bookingDate),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Mark As Complete Button (conditional based on booking status)
            //   if (booking.bookingStatus == 'COMPLETE_REQUEST') ...[
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF7B4BF5),
                      Color(0xFFBD5FF3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Success',
                      'Booking marked as complete',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: normalText(
                    text: "Mark As Complete",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )

            // ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        normalText(text: title),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildTimeSlotRow(List<String> times, {required String selectedTime}) {
    return Row(
      children: times.asMap().entries.map((entry) {
        int index = entry.key;
        String time = entry.value;

        // Check if this time slot matches the booking time
        // Extract hour from booking time (e.g., "10:00" from selectedTime)
        String bookingHour = selectedTime.split(':')[0];
        bool isSelected = time.startsWith('$bookingHour:') ||
            time.startsWith('0$bookingHour:') ||
            (bookingHour.length == 1 && time.startsWith('0$bookingHour:'));

        return Expanded(
          child: Container(
              margin: EdgeInsets.only(
                right: index < times.length - 1 ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF7B4BF5),
                          Color(0xFFBD5FF3),
                        ],
                      )
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 252, 252, 252),
                          Color.fromARGB(255, 241, 241, 241),
                        ],
                      ),
                color:
                    isSelected ? const Color(0xFF8B5CF6) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      isSelected ? const Color(0xFF8B5CF6) : Colors.grey[300]!,
                ),
              ),
              child: smallerText(
                  text: time,
                  textAlign: TextAlign.center,
                  color: isSelected ? Colors.white : Colors.black)),
        );
      }).toList(),
    );
  }
}
