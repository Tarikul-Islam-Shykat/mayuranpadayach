import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/route/route.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/custom_text.dart';
import '../../../../core/services_class/network_service/map.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/text_field_widget.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../controller/add_business_controller.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import 'package:get/get.dart';
import '../../admin_service/widget/service_tile.dart';
import '../model/business_category_model.dart';
import '../widget/common_dropdown_button.dart';

class BusinessDetailsScreen extends StatelessWidget {
  BusinessDetailsScreen({super.key});
  final AddBusinessController controller = Get.put(AddBusinessController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.businessDetails(Get.arguments["id"]);
    });
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Obx((){
          if(controller.isBusinessDetailsLoading.value){
            return Center(child: loading(),);
          }else if(controller.adminBusinessDetailsModel.value == null){
            return Center(child: Text("No Data Found"));
          }else{
            final data = controller.adminBusinessDetailsModel.value;
            return Column(
              children: [
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: roundBackButton(() => Get.back()),
                      ),
                    Text(
                      "${data.name}",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: AppColors.textBlackColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomCircularButton(
                        height: 40,
                        width: 40,
                        icon: Image.asset(
                          ImagePath.editIcon,
                          color: Colors.black,
                          height: 20,
                          width: 20,
                        ),
                        onTap: (){
                          controller.setEditBusinessValue(data);

                          editBusinessBottomSheet(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                Stack(
                  children: [
                    Container(
                      height: 160.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: AppNetworkImage(
                          src:
                          "${data.image}",
                          height: 160.h,
                          width: Get.width,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 15,
                      right: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width*0.62,
                                child: Text(
                                  "${data.address}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: AppColors.whiteColor),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.av_timer_sharp,
                                      color: Colors.white.withValues(alpha: .50),
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Next Appointment 12:00 PM',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withValues(alpha:2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withValues(alpha: .5),
                            ),
                            child: Text(
                              "${controller.adminBusinessDetailsModel.value.openStatus}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                serviceTile((){
                  Get.toNamed(
                      arguments:{"businessId":data.id.toString(),},
                      AppRoute.adminServiceScreen);
                },
                    'Services',
                    ImagePath.service,
                ),
                serviceTile((){
                  Get.toNamed(
                    arguments: {
                      "id":data.id.toString(),
                    },
                      AppRoute.businessSpecialistScreen);
                },
                    'Specialist',
                    ImagePath.specialist,
                ),
                serviceTile(()=> Get.toNamed(
                    arguments: {
                      "id":data.id.toString(),
                    },
                    AppRoute.businessPortfolioScreen), "Portfolio", ImagePath.portfolio,
                ),
                serviceTile(()=>Get.toNamed(
                  arguments: {
                    "businessId":data.id.toString(),
                  },
                    AppRoute.reviewAdminScreen), "Review", ImagePath.rating),
                serviceTile(()=> Get.toNamed(AppRoute.businessAboutScreen), "About", ImagePath.about),
              ],
            );
          }

          }
        ),
      ),
    );
  }
  Future<dynamic> editBusinessBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      isDismissible: false,
      isScrollControlled: true,
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
                Text("Edit Business",
                  style:  GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: AppColors.textBlackColor,
                  ),
                ),
                IconButton(
                    onPressed: (){
                      controller.clearForm();
                      controller.clearImage();
                      Get.back();
                    },
                    icon: Icon(Icons.cancel_outlined))
              ],
            ),

            SizedBox(
              height: 8.h,
            ),
            fieldText(name: "Edit Business Name"),
            CustomAuthField(
                radiusValue: 10,
                radiusValue2: 10,
                controller: controller.businessNameTEC,
                hintText: "Zero Hair Studio"),
            SizedBox(
              height: 8.h,
            ),

            fieldText(name: "Edit Category"),
            Obx(() => CommonDropdown<CategoryModel>(
              items: controller.categoryList,
              selectedItem: controller.selectedCategory.value,
              label: "Choose Category",
              onChanged: (value) {
                controller.onCategorySelected(value);
              },
              itemAsString: (CategoryModel cat) => cat.name,
            )),

            SizedBox(
              height: 8.h,
            ),
            fieldText(name: "Edit Sub Category"),
            // Sub Category Dropdown
            Obx(() => CommonDropdown<SubCategoryModel>(
              items: controller.subCategoryList,
              selectedItem: controller.selectedSubCategory.value,
              label: "Choose Sub Category",
              onChanged: controller.selectedCategory.value == null
                  ? null // disable if no category selected
                  : (value) {
                controller.onSubCategorySelected(value);
              },
              itemAsString: (SubCategoryModel sub) => sub.name,
              enabled: controller.selectedCategory.value != null,
            )),




            SizedBox(height: 8.h,),
            fieldText(name: "Edit Location"),
            InkWell(
              onTap: () async {
                final result = await Get.to<LocationResult>(() => MapPage());
                if (result != null) {
                  controller.long = result.longitude;
                  controller.lat = result.latitude;
                  controller.locationName = result.locationName ?? '';

                  log('Location Picked: 1');
                  log('Latitude: ${result.latitude}');
                  log('Longitude: ${result.longitude}');
                  log('Location Name: ${result.locationName ?? "Unknown"}');
                } else {
                  log('User canceled location selection.');
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 45.h,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor.withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:MediaQuery.sizeOf(context).width*0.8,
                      child: Text(
                        controller.locationName.isNotEmpty
                            ? controller.locationName
                            : "Enter Location",
                        overflow: TextOverflow.ellipsis,
                        style:  GoogleFonts.poppins(
                          color: AppColors.grayColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,),
                      ),
                    ),
                    Icon(Icons.location_searching),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),

            fieldText(name: "Opening & Closing Time"),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      controller.pickTime(context, controller.openingTime);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      height: 40.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fillColor,
                      ),
                      child:Obx(() => Text(
                        controller.openingTime.value != null
                            ?DateFormat("hh:mm a").format(controller.timeOfDayToDateTime(controller.openingTime.value!))
                            : "Opening Time",
                        style:  GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,),
                      )) ,
                    ),
                  ),
                ),
                SizedBox(width: 8.w,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      controller.pickTime(context, controller.closingTime);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      height: 40.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fillColor,
                      ),
                      child:Obx(() => Text(
                        controller.closingTime.value != null
                            ?DateFormat("hh:mm a").format(controller.timeOfDayToDateTime(controller.closingTime.value!))
                            : "Closing Time",
                        style:  GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,),
                      )) ,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h,),
              Obx(() => InkWell(
                onTap: (){
                  controller.status.value =
                  controller.status.value == "OPEN" ? "CLOSED" : "OPEN";
                },
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.fillColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Open Status: ${controller.status.value}",
                        style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor),
                      ),
                      Switch(
                        activeColor: Colors.green,
                        value: controller.status.value == "OPEN",
                        onChanged: (val) {
                          controller.status.value = val ? "OPEN" : "CLOSED";
                        },
                      ),
                    ],
                  ),
                ),
              )),



            SizedBox(
              height: 8.h,
            ),

            fieldText(name: "Upload Image"),
            InkWell(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60.h,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor.withValues(alpha:.1),
                ),
                child: Row(
                  children: [
                    Obx(() => Container(
                      height: 90.h,
                      width: 100.w,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: controller.profileImage.value != null
                            ? Image.file(
                          controller.profileImage.value!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ):controller.adminBusinessDetailsModel.value.image != null?Image.network(
                          controller.adminBusinessDetailsModel.value.image!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ): Image.asset(ImagePath.fileIcon,height: 100,width: 100,),
                      ),
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    normalText(text: "Select Image"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Obx(()=>controller.isAddBusinessLoading.value?
            btnLoading():CustomButton(
                onTap: (){
                  if (controller.isForEdit.value) {
                    controller.editBusinessProfile(controller.adminBusinessDetailsModel.value.id.toString());
                  } else {
                    controller.addBusinessProfile();
                  }

                },
                title: Text("Save",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor),
                ))),
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
            if (controller.profileImage.value != null) ...[
              SizedBox(height: 20.h),
              _buildImageOption(
                context,
                icon: Icons.delete,
                label: 'Remove',
                color: Colors.red,
                onTap: () {
                  Get.back();
                  controller.clearImage();
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
