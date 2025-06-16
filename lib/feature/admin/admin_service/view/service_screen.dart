import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/core/global_widegts/custom_dialog.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/admin/admin_home/widget/custom_circular_button.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/service_controller.dart';
import 'package:prettyrini/feature/admin/admin_service/widget/service_tile.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import 'package:prettyrini/feature/profile_screen/widget/round_back_button.dart';
import 'package:get/get.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/global_widegts/custom_text.dart';
import '../../../../route/route.dart';

class ServiceScreen extends GetView<ServiceController> {

  final String? businessId = Get.arguments?["id"]??"";
   ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page.value = 1;
      controller.getAllService(businessId.toString());
      log("business id ${businessId.toString()}");
    });
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40.h,bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  roundBackButton(() => Get.back()),
                  Text(
                    "All Services",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.textBlackColor),
                  ),
                  CustomCircularButton(
                      icon: Icon(Icons.add),
                      onTap: () => addServiceBuild(context))
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.serviceModel.isEmpty && controller.isLoadingService.value) {
                  return Center(
                    child: loading(),
                  );
                } else if (controller.serviceModel.isEmpty) {
                  return Center(
                    child: Text("No Data Found"),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.page.value = 1;
                      await controller.getAllService(controller.businessId.value.toString());
                    },
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount:  controller.hasMore.value
                            ? controller.serviceModel.length + 1
                            : controller.serviceModel.length,
                        itemBuilder: (context, index) {
                          if (index < controller.serviceModel.length) {
                            var data = controller.serviceModel[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: ListTile(
                                onTap: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Color(0xFFF1EEF9),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: AppNetworkImage(
                                      height: 50.h,
                                      width: 55.w,
                                      src: data.image.toString()),
                                ),
                                title: Text(
                                  data.name.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBlackColor),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$ ${data.price}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBlackColor),
                                    ),
                                    Text(
                                      " / 1 hour",
                                      style: GoogleFonts.poppins(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textBlackColor),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomCircularButton(
                                      height: 30,
                                      width: 30,
                                      icon: Icon(Icons.delete,color: Colors.red,),
                                      onTap: () {
                                        deleteDialog(
                                            title: "Are you sure ?",
                                            content: "Are you sure you want to delete this service?",
                                            onOk: (){
                                            controller.deleteService(data.id.toString());

                                        });

                                      },
                                    ),
                                    SizedBox(width: 8.w,),
                                    CustomCircularButton(
                                      height: 30,
                                      width: 30,
                                      icon: Image.asset(ImagePath.editIcon,height: 25,width: 25,),
                                      onTap: ()async {
                                         controller.setEditServiceData(data); // ServiceModel
                                       addServiceBuild(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return controller.serviceModel.length >= 10 && controller.hasMore.value? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: loading(),
                            ),
                          ):Center();
                        }),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> addServiceBuild(BuildContext context) {
    return Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text( controller.isEditing.value ? "Edit Service" : "Add Service",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.textBlackColor,
                  ),
                ),
                IconButton(
                    onPressed: (){
                      Get.back();
                      controller.allClear();
                    },
                    icon: Icon(Icons.cancel_outlined))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            fieldText(name: controller.isEditing.value ? "Edit Service Name" : "Service Name"),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller: controller.serviceNameTEC.value,
              hintText: "service name",
            ),
            SizedBox(
              height: 10.h,
            ),
            fieldText(name:controller.isEditing.value ? "Edit Service Price" : "Service Price"),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              keyboardType: TextInputType.number,
              controller: controller.servicePriceTEC.value,
              hintText: "\$0.0",
            ),
            controller.isEditing.value ? Obx(() => SwitchListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              title: Text("IsActive",style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlackColor
              ),),
              value: controller.isActive.value,
              onChanged: (value) => controller.isActive.value = value,
            )):Center(),

            controller.isEditing.value ?Obx(() => SwitchListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              title: Text(
                "Offer Percent",style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlackColor,
              ),),
              value: controller.isOffered.value,
              onChanged: (value) => controller.isOffered.value = value,
            )):Center(),

            Obx(() => controller.isOffered.value
                ? CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              keyboardType: TextInputType.number,
              controller: controller.offerPercentTEC.value,
              hintText: "0 %",
            )
                : SizedBox.shrink()
            ),
            SizedBox(height: 10.h,),
            fieldText(name: "Upload Image"),
            InkWell(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 105,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor.withValues(alpha: .1),
                ),
                child: Row(
                  children: [
                     Obx(() {
                      return Container(
                        height: 80.h,
                        width: 80.w,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: controller.serviceImage.value != null
                              ? Image.file(
                            controller.serviceImage.value!,
                            fit: BoxFit.cover,
                            width: 80.w,
                            height: 80.h,
                          )
                              : controller.serviceImageUrl.value.isNotEmpty
                              ? Image.network(
                            controller.serviceImageUrl.value,
                            fit: BoxFit.cover,
                            width: 80.w,
                            height: 80.h,
                          )
                              : Image.asset(
                            ImagePath.fileIcon,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      );
                    }),

                    SizedBox(
                      width: 5,
                    ),
                    normalText(text: "Select Image"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx((){
                return controller.isLoadingCreate.value?btnLoading(): CustomButton(
                  onTap: () async{
                    if (controller.businessId.value.isNotEmpty) {
                      if (controller.isEditing.value) {
                        controller.editService(businessId,controller.editingServiceId);
                      } else {
                        await controller.createService(businessId);
                      }
                    } else {
                      log("No ID was passed to this screen");
                    }
                  },

                  title: Text(
                      "Save",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor),
                    ));
              }
            ),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Select Profile Picture',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(
                  context,
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    controller.pickImageFormCamera();
                  },
                ),
                _buildImageOption(
                  context,
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    controller.pickImageProfile();
                  },
                ),
              ],
            ),
            if (controller.serviceImage.value != null) ...[
              SizedBox(height: 20.h),
              _buildImageOption(
                context,
                icon: Icons.delete,
                label: 'Remove',
                color: Colors.red,
                onTap: () {
                  Get.back();
                },
              ),
            ],
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: (color ?? AppColors.primaryColor).withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30.sp,
              color: color ?? AppColors.primaryColor,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: color ?? AppColors.textBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
