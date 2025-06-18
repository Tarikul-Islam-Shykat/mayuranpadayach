// lib/widgets/services_tab.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image_v2.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import '../controller/service_details_cnt.dart';

class ServicesTab extends StatefulWidget {
  const ServicesTab({Key? key}) : super(key: key);

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  @override
  Widget build(BuildContext context) {
    final StudioController controller = Get.find<StudioController>();

    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(
                    text: 'Popular Services',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.services.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final service = controller.services[index];
                  // Check if this item is selected
                  bool isSelected =
                      controller.selectedServiceIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      controller.selectService(index);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
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
                                  Colors.grey.shade300,
                                  Colors.grey.shade300,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF6B46C1)
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          ResponsiveNetworkImage(
                            imageUrl: service.image,
                            shape: ImageShape.roundedRectangle,
                            borderRadius: 12,
                            widthPercent: 0.2,
                            heightPercent: 0.08,
                            fit: BoxFit.cover,
                            placeholderWidget: loading(),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                normalText(
                                    text: service.name,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    smallText(
                                        text:
                                            '\$${service.price.toStringAsFixed(0)}',
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black),
                                    smallText(
                                        text: ' / 1 hour',
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF6B46C1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelected ? Icons.remove : Icons.add,
                              color: isSelected
                                  ? const Color(0xFF6B46C1)
                                  : Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
