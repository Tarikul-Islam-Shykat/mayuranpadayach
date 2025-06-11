import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/customer_flow/search_shop/controller/filter_controller.dart';
import 'package:prettyrini/feature/customer_flow/search_shop/widget/price_range.dart';

class FilterPage extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories Section
                    _buildSectionTitle('All Categories'),
                    SizedBox(height: 15),
                    _buildCategoryChips(),

                    SizedBox(height: 30),

                    // Price Range Section
                    _buildSectionTitle('Price Range'),
                    SizedBox(height: 15),
                    PriceRangeWidget(controller: controller),

                    SizedBox(height: 30),

                    // Rating Section
                    _buildSectionTitle('Rating'),
                    SizedBox(height: 15),
                    _buildRatingChips(),

                    SizedBox(height: 30),

                    // Date Section
                    _buildSectionTitle('Date'),
                    SizedBox(height: 15),
                    _buildDateSelector(context),

                    SizedBox(height: 30),

                    // Location Section
                    _buildSectionTitle('Location'),
                    SizedBox(height: 15),
                    _buildLocationInput(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.clearAll,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      height: 40,
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              final isSelected = controller.selectedCategory.value == category;

              return Padding(
                padding: EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => controller.selectCategory(category),
                  selectedColor: Colors.purple,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildRatingChips() {
    return Container(
      height: 40,
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6, // 0 (any) + 1-5 stars
            itemBuilder: (context, index) {
              final rating = index.toDouble();
              final isSelected = controller.selectedRating.value == rating;

              return Padding(
                padding: EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (rating == 0)
                        Text('Any')
                      else ...[
                        Icon(Icons.star,
                            size: 16,
                            color: isSelected ? Colors.white : Colors.amber),
                        SizedBox(width: 4),
                        Text('${rating.toInt()}'),
                      ],
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (_) => controller.selectRating(rating),
                  selectedColor: Colors.purple,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(() => Text(
                    controller.selectedDate.value == null
                        ? 'Select booking date'
                        : '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}',
                    style: TextStyle(
                      color: controller.selectedDate.value == null
                          ? Colors.grey
                          : Colors.black87,
                    ),
                  )),
            ),
            Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInput() {
    return TextField(
      controller: controller.locationController,
      decoration: InputDecoration(
        hintText: 'Enter location',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.purple),
        ),
        suffixIcon: Icon(Icons.location_on, color: Colors.grey),
      ),
    );
  }
}
