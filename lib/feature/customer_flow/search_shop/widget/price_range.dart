import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/customer_flow/search_shop/controller/filter_controller.dart';

class PriceRangeWidget extends StatelessWidget {
  final FilterController controller;

  const PriceRangeWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Min/Max Input Fields
        Row(
          children: [
            Expanded(
              child: _buildPriceInput(
                title: 'Minimum',
                value: controller.minPrice,
                onChanged: controller.updateMinPrice,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: _buildPriceInput(
                title: 'Maximum',
                value: controller.maxPrice,
                onChanged: controller.updateMaxPrice,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Range Slider
        Obx(() => RangeSlider(
              values: RangeValues(
                  controller.minPrice.value, controller.maxPrice.value),
              min: 0,
              max: 1000,
              divisions: 100,
              activeColor: Colors.purple,
              inactiveColor: Colors.grey.shade300,
              onChanged: (values) {
                controller.updateMinPrice(values.start);
                controller.updateMaxPrice(values.end);
              },
            )),
      ],
    );
  }

  Widget _buildPriceInput({
    required String title,
    required RxDouble value,
    required Function(double) onChanged,
  }) {
    final TextEditingController textController = TextEditingController();

    return Obx(() {
      textController.text = '\$${value.value.toInt()}';
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (text) {
                final cleanText = text.replaceAll('\$', '');
                final newValue = double.tryParse(cleanText);
                if (newValue != null && newValue >= 0 && newValue <= 1000) {
                  onChanged(newValue);
                }
              },
              onTap: () {
                // Clear the dollar sign when user taps to edit
                textController.text = value.value.toInt().toString();
                textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: textController.text.length),
                );
              },
              onEditingComplete: () {
                // Add back the dollar sign when done editing
                textController.text = '\$${value.value.toInt()}';
              },
            ),
          ],
        ),
      );
    });
  }
}
