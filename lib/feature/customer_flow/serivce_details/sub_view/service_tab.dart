// lib/widgets/services_tab.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/user/serivce_details/controller/service_details_cnt.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({Key? key}) : super(key: key);

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
              const Text(
                'Popular Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_up,
                color: Colors.grey.shade600,
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Services list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.currentServices.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final service = controller.currentServices[index];
              final isFirst = index == 0;
              
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isFirst ? const Color(0xFF6B46C1) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isFirst ? const Color(0xFF6B46C1) : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Service image
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(service.serviceImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Service details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isFirst ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '\$${service.amount.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isFirst ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                ' / ${service.durationHours} hour${service.durationHours > 1 ? 's' : ''}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isFirst ? Colors.white70 : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Action button
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isFirst ? Colors.white : const Color(0xFF6B46C1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFirst ? Icons.remove : Icons.add,
                        color: isFirst ? const Color(0xFF6B46C1) : Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}