import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final RxString selectedCategory = 'All'.obs;
  final RxDouble minPrice = 20.0.obs;
  final RxDouble maxPrice = 520.0.obs;
  final RxDouble selectedRating = 0.0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final TextEditingController locationController = TextEditingController();

  final List<String> categories = [
    'All', 'Barber', 'Carpenter', 'Painter', 'Cleaner', 'Coke Maker', 'Tutor'
  ];

  @override
  void onInit() {
    super.onInit();
    // Set random pre-selected options
    selectedCategory.value = categories[1]; // Random category (Barber)
    selectedRating.value = 3.0; // Random rating
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void updateMinPrice(double price) {
    minPrice.value = price;
  }

  void updateMaxPrice(double price) {
    maxPrice.value = price;
  }

  void selectRating(double rating) {
    selectedRating.value = rating;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  void clearAll() {
    selectedCategory.value = 'All';
    minPrice.value = 20.0;
    maxPrice.value = 520.0;
    selectedRating.value = 0.0;
    selectedDate.value = null;
    locationController.clear();
  }

  void performSearch() {
    print('Search Data:');
    print('Category: ${selectedCategory.value}');
    print('Price Range: \$${minPrice.value.toInt()} - \$${maxPrice.value.toInt()}');
    print('Rating: ${selectedRating.value} stars');
    print('Date: ${selectedDate.value?.toString() ?? 'Not selected'}');
    print('Location: ${locationController.text}');
    
    // Show success message
    Get.snackbar(
      'Search Performed',
      'Check console for search data',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}