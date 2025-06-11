// checkout_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  // Observable variables with proper type annotations
  var selectedDate = Rxn<DateTime>();
  var selectedTime = RxnString();
  var selectedSpecialist = RxnString();
  var showCalendar = false.obs;
  var showServicesExpanded = true.obs;

  // Service data with proper type annotation
  final Map<String, dynamic> serviceData = {
    'name': 'Regular Haircut & Beard',
    'price': 30,
    'duration': '1 Hour',
  };

  // Available time slots with proper type annotation
  final List<String> timeSlots = [
    '11:00 - 12:00',
    '01:00 - 02:00',
    '02:00 - 03:00',
    '03:00 - 04:00',
    '04:00 - 05:00',
    '06:00 - 07:00',
    '07:00 - 08:00',
    '08:00 - 09:00',
    '09:00 - 10:00',
  ];

  // Available specialists with proper type annotation
  final List<String> specialists = [
    'John Smith',
    'Sarah Johnson',
    'Mike Wilson',
    'Emily Davis',
  ];

  // Methods
  void toggleServicesExpanded() {
    showServicesExpanded.value = !showServicesExpanded.value;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    showCalendar.value = false;
  }

  void selectTime(String time) {
    selectedTime.value = time;
  }

  void selectSpecialist(String specialist) {
    selectedSpecialist.value = specialist;
  }

  void toggleCalendar() {
    showCalendar.value = !showCalendar.value;
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Select booking date';

    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  bool isBookingComplete() {
    return selectedDate.value != null &&
        selectedTime.value != null &&
        selectedSpecialist.value != null;
  }

  void confirmBooking() {
    if (isBookingComplete()) {
      // Handle booking confirmation
      Get.snackbar(
        'Booking Confirmed',
        'Your appointment has been booked for ${formatDate(selectedDate.value)} at ${selectedTime.value}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      // Print booking details for debugging
      print('Booking Details:');
      print('Service: ${serviceData['name']}');
      print('Date: ${formatDate(selectedDate.value)}');
      print('Time: ${selectedTime.value}');
      print('Specialist: ${selectedSpecialist.value}');
      print('Price: \$${serviceData['price']}');
    } else {
      Get.snackbar(
        'Incomplete Booking',
        'Please select date, time, and specialist',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Generate calendar days for current month with proper return type
  List<DateTime> getCalendarDays() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    List<DateTime> days = [];
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(now.year, now.month, i));
    }

    return days;
  }

  // Check if date is selectable (not in the past)
  bool isDateSelectable(DateTime date) {
    final today = DateTime.now();
    return date.isAfter(today.subtract(Duration(days: 1)));
  }
}