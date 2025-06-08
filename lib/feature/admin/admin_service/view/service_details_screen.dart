import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/service_controller.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import 'package:prettyrini/route/route.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/select_image_option.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/custome_dropdown.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import 'package:get/get.dart';
import '../widget/service_tile.dart';

class ServiceDetailsScreen extends StatelessWidget {
  ServiceDetailsScreen({super.key});
  final ServiceController controller = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundBackButton(onTap: () => Get.back()),
        ),
        title: Text(
          "Zero Hair Studio",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlackColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCircularButton(
              icon: Image.asset(
                ImagePath.editIcon,
                color: Colors.black,
              ),
              onTap: () => editBusinessBottomSheet(context),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
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
                          "https://t3.ftcdn.net/jpg/01/53/19/04/360_F_153190451_343c8c86tqWyYEpB066i6MICYURkMwmG.jpg",
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
                          Text(
                            "115 Manhattan, New York",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: AppColors.whiteColor),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.av_timer_sharp,
                                color: Colors.white.withValues(alpha: .40),
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Next Appointment 12:00',
                                style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: .40)),
                              ),
                            ],
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
                          "Open",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
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
              height: 15.h,
            ),
            ServiceTile(
              onTap: () {},
              name: 'Services',
              image: ImagePath.service,
            ),
            ServiceTile(
              onTap: () => Get.toNamed(AppRoute.serviceSpecialistScreen),
              name: 'Specialist',
              image: ImagePath.specialist,
            ),
            ServiceTile(
              onTap: () => Get.toNamed(AppRoute.servicePortfolioScreen),
              name: 'Portfolio',
              image: ImagePath.portfolio,
            ),
            ServiceTile(
              onTap: () {},
              name: 'Review',
              image: ImagePath.rating,
            ),
            ServiceTile(
              onTap: () => Get.toNamed(AppRoute.serviceAboutScreen),
              name: 'About',
              image: ImagePath.about,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> editBusinessBottomSheet(BuildContext context) {
    return Get.bottomSheet(
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
                Text(
                  "Edit Business",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.textBlackColor,
                  ),
                ),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.cancel_outlined))
              ],
            ),

            SizedBox(
              height: 10.h,
            ),
            Text("Edit Business Name",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),),
            CustomAuthField(
              radiusValue: 10,
                radiusValue2: 10,
                controller: controller.businessNameTEC.value, hintText: "Zero Hair Studio"),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Edit Category",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
            CustomDropdown(
              items: controller.selectBusinessCategoryList,
              selectedItem: controller.selectBusinessCategory,
              label: "Choose Category",
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Edit Sub Category",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
            CustomDropdown(
              items: controller.selectBusinessSubCategoryList,
              selectedItem: controller.selectBusinessSubCategory,
              label: "Choose Sub Category",
            ),
            SizedBox(
              height: 10.h,
            ),

            Text(
              "Edit Location",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Enter Location",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.grayColor),
                    ),
                    Icon(Icons.my_location_sharp),

                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),


            Text(
              "Upload Image",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () => SelectPicker.showImageDialog(
                  context: context, onCamera: () {}, onGallery: () {}),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor,
                ),
                child: Row(
                  children: [
                    Image.asset(ImagePath.fileIcon),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Upload image",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.grayColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
                onTap: () {},
                title: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor),
                ))
          ],
        ),
      ),
    );
  }
}
