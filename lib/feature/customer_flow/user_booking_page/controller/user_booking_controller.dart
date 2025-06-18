// user_booking_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/model/user_booking_model.dart';
import '../ui/user_booking_details.dart';

class BookingController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  // PageController for sliding animation
  late PageController pageController;

  // Selected tab index for custom tab bar
  final RxInt selectedTabIndex = 0.obs;

  // Observable lists for different booking statuses
  final RxList<BookingModel> pendingBookings = <BookingModel>[].obs;
  final RxList<BookingModel> requestBookings = <BookingModel>[].obs;
  final RxList<BookingModel> completedBookings = <BookingModel>[].obs;

  // Loading states
  final RxBool isLoadingPending = false.obs;
  final RxBool isLoadingRequest = false.obs;
  final RxBool isLoadingCompleted = false.obs;

  // Pagination
  final RxInt pendingPage = 1.obs;
  final RxInt requestPage = 1.obs;
  final RxInt completedPage = 1.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    loadAllBookings();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Change tab method with smooth sliding animation
  void changeTab(int index) {
    if (selectedTabIndex.value != index) {
      selectedTabIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Load data for the selected tab if it's empty
      _loadDataForTab(index);
    }
  }

  // Handle page change from PageView (when user swipes)
  void onPageChanged(int index) {
    selectedTabIndex.value = index;
    _loadDataForTab(index);
  }

  // Helper method to load data for specific tab
  void _loadDataForTab(int index) {
    switch (index) {
      case 0:
        if (pendingBookings.isEmpty && !isLoadingPending.value) {
          loadPendingBookings();
        }
        break;
      case 1:
        if (requestBookings.isEmpty && !isLoadingRequest.value) {
          loadRequestBookings();
        }
        break;
      case 2:
        if (completedBookings.isEmpty && !isLoadingCompleted.value) {
          loadCompletedBookings();
        }
        break;
    }
  }

  // Load all booking types
  void loadAllBookings() {
    loadPendingBookings();
    loadRequestBookings();
    loadCompletedBookings();
  }

  // Load pending bookings
  Future<void> loadPendingBookings({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pendingPage.value = 1;
        pendingBookings.clear();
      }

      isLoadingPending.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/bookings/user-bookings?page=${pendingPage.value}&limit=$limit&bookingStatus=PENDING',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final bookingResponse = BookingResponse.fromJson(response);

        if (isRefresh) {
          pendingBookings.value = bookingResponse.data.result;
        } else {
          pendingBookings.addAll(bookingResponse.data.result);
        }

        pendingPage.value++;
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch pending bookings",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch pending bookings: $e",
        isSuccess: false,
      );
    } finally {
      isLoadingPending.value = false;
    }
  }

  // Load request bookings (COMPLETE_REQUEST)
  Future<void> loadRequestBookings({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        requestPage.value = 1;
        requestBookings.clear();
      }

      isLoadingRequest.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/bookings/user-bookings?page=${requestPage.value}&limit=$limit&bookingStatus=COMPLETE_REQUEST',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final bookingResponse = BookingResponse.fromJson(response);

        if (isRefresh) {
          requestBookings.value = bookingResponse.data.result;
        } else {
          requestBookings.addAll(bookingResponse.data.result);
        }

        requestPage.value++;
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch request bookings",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch request bookings: $e",
        isSuccess: false,
      );
    } finally {
      isLoadingRequest.value = false;
    }
  }

  // Load completed bookings
  Future<void> loadCompletedBookings({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        completedPage.value = 1;
        completedBookings.clear();
      }

      isLoadingCompleted.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/bookings/user-bookings?page=${completedPage.value}&limit=$limit&bookingStatus=COMPLETED',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final bookingResponse = BookingResponse.fromJson(response);

        if (isRefresh) {
          completedBookings.value = bookingResponse.data.result;
        } else {
          completedBookings.addAll(bookingResponse.data.result);
        }

        completedPage.value++;
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch completed bookings",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch completed bookings: $e",
        isSuccess: false,
      );
    } finally {
      isLoadingCompleted.value = false;
    }
  }

  // Navigate to booking details
  void navigateToBookingDetails(BookingModel booking) {
    Get.to(() => UserBookingDetailsScreenVersion2(booking: booking));
  }

  // Refresh methods
  Future<void> refreshPendingBookings() async {
    await loadPendingBookings(isRefresh: true);
  }

  Future<void> refreshRequestBookings() async {
    await loadRequestBookings(isRefresh: true);
  }

  Future<void> refreshCompletedBookings() async {
    await loadCompletedBookings(isRefresh: true);
  }

  // Format date for display
  String formatBookingDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  // Format time for display
  String formatBookingTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  // Get booking status color
  Color getBookingStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'COMPLETE_REQUEST':
        return Colors.blue;
      case 'COMPLETED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get booking status display text
  String getBookingStatusText(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'Pending';
      case 'COMPLETE_REQUEST':
        return 'Request';
      case 'COMPLETED':
        return 'Completed';
      case 'CANCELLED':
        return 'Cancelled';
      default:
        return status;
    }
  }
}
/*
class BookingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final NetworkConfig _networkConfig = NetworkConfig();

  // Observable lists for different booking statuses
  final RxList<BookingModel> pendingBookings = <BookingModel>[].obs;
  final RxList<BookingModel> requestBookings = <BookingModel>[].obs;
  final RxList<BookingModel> completedBookings = <BookingModel>[].obs;

  // Loading states
  final RxBool isLoadingPending = false.obs;
  final RxBool isLoadingRequest = false.obs;
  final RxBool isLoadingCompleted = false.obs;

  // Pagination
  final RxInt pendingPage = 1.obs;
  final RxInt requestPage = 1.obs;
  final RxInt completedPage = 1.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    loadAllBookings();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // Load all booking types
  void loadAllBookings() {
    loadPendingBookings();
    loadRequestBookings();
    loadCompletedBookings();
  }

  // Load pending bookings
  Future<void> loadPendingBookings({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pendingPage.value = 1;
        pendingBookings.clear();
      }

      isLoadingPending.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/bookings/user-bookings?page=${pendingPage.value}&limit=$limit&bookingStatus=PENDING',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final bookingResponse = BookingResponse.fromJson(response);

        if (isRefresh) {
          pendingBookings.value = bookingResponse.data.result;
        } else {
          pendingBookings.addAll(bookingResponse.data.result);
        }

        pendingPage.value++;
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch pending bookings",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch pending bookings: $e",
        isSuccess: false,
      );
    } finally {
      isLoadingPending.value = false;
    }
  }

  // Load request bookings (COMPLETE_REQUEST)
  Future<void> loadRequestBookings({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        requestPage.value = 1;
        requestBookings.clear();
      }

      isLoadingRequest.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/bookings/user-bookings?page=${requestPage.value}&limit=$limit&bookingStatus=COMPLETE_REQUEST',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final bookingResponse = BookingResponse.fromJson(response);

        if (isRefresh) {
          requestBookings.value = bookingResponse.data.result;
        } else {
          requestBookings.addAll(bookingResponse.data.result);
        }

        requestPage.value++;
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch request bookings",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch request bookings: $e",
        isSuccess: false,
      );
    } finally {
      isLoadingRequest.value = false;
    }
  }

  // Load completed bookings
  Future<void> loadCompletedBookings({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        completedPage.value = 1;
        completedBookings.clear();
      }

      isLoadingCompleted.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        '${Urls.baseUrl}/bookings/user-bookings?page=${completedPage.value}&limit=$limit&bookingStatus=COMPLETED',
        null,
        is_auth: true,
      );

      if (response['success'] == true && response['data'] != null) {
        final bookingResponse = BookingResponse.fromJson(response);

        if (isRefresh) {
          completedBookings.value = bookingResponse.data.result;
        } else {
          completedBookings.addAll(bookingResponse.data.result);
        }

        completedPage.value++;
      } else {
        AppSnackbar.show(
          message: response['message'] ?? "Failed to fetch completed bookings",
          isSuccess: false,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        message: "Failed to fetch completed bookings: $e",
        isSuccess: false,
      );
    } finally {
      isLoadingCompleted.value = false;
    }
  }

  // Navigate to booking details
  void navigateToBookingDetails(BookingModel booking) {
    Get.to(() => UserBookingDetailsScreenVersion2(booking: booking));
  }

  // Refresh methods
  Future<void> refreshPendingBookings() async {
    await loadPendingBookings(isRefresh: true);
  }

  Future<void> refreshRequestBookings() async {
    await loadRequestBookings(isRefresh: true);
  }

  Future<void> refreshCompletedBookings() async {
    await loadCompletedBookings(isRefresh: true);
  }

  // Mark booking as complete (for admin/business use)
  // Future<void> markBookingAsComplete(String bookingId) async {
  //   try {
  //     final response = await _networkConfig.ApiRequestHandler(
  //       RequestMethod.PATCH,
  //       '${Urls.baseUrl}/bookings/$bookingId/complete',
  //       null,
  //       is_auth: true,
  //     );

  //     if (response['success'] == true) {
  //       AppSnackbar.show(
  //         message: "Booking marked as complete successfully",
  //         isSuccess: true,
  //       );

  //       // Refresh all booking lists
  //       loadAllBookings();
  //       Get.back(); // Go back to booking list
  //     } else {
  //       AppSnackbar.show(
  //         message: response['message'] ?? "Failed to mark booking as complete",
  //         isSuccess: false,
  //       );
  //     }
  //   } catch (e) {
  //     AppSnackbar.show(
  //       message: "Failed to mark booking as complete: $e",
  //       isSuccess: false,
  //     );
  //   }
  // }

  // Format date for display
  String formatBookingDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  // Format time for display
  String formatBookingTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  // Get booking status color
  Color getBookingStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'COMPLETE_REQUEST':
        return Colors.blue;
      case 'COMPLETED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get booking status display text
  String getBookingStatusText(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'Pending';
      case 'COMPLETE_REQUEST':
        return 'Request';
      case 'COMPLETED':
        return 'Completed';
      case 'CANCELLED':
        return 'Cancelled';
      default:
        return status;
    }
  }
}

*/
