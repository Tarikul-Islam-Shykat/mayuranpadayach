import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/admin/admin_review/controller/admin_review_controller.dart';

import '../../../../core/const/app_colors.dart';
import '../../../profile_screen/widget/round_back_button.dart';

class AdminReviewScreen extends StatelessWidget {
  AdminReviewScreen({super.key});
  final AdminReviewController controller = Get.put(AdminReviewController());
  final String? businessId = Get.arguments["businessId"];

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      controller.getAdminReview(businessId);
    });
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: roundBackButton(() => Get.back()),
        ),
        title: Text(
          "Review",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlackColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoadingReview.value) {
                  return Center(
                    child: loading(),
                  );
                } else if (controller.reviewAdminModel.isEmpty) {
                  return Center(
                    child: Text("No Review Found"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: controller.reviewAdminModel.length,
                      itemBuilder: (context, index) {
                        final data = controller.reviewAdminModel[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AppNetworkImage(
                                      src: "${data.specialist!.profileImage}",
                                      height: 100,
                                      width: 80,
                                    )),
                                title: Text(
                                  "${data.specialist!.fullName}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: AppColors.textBlackColor),
                                ),
                                subtitle:
                                    Text("${data.specialist!.specialization}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      ImagePath.rating,
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "${data.rating}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: AppColors.textBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: AppNetworkImage(
                                            src: "${data.user!.profileImage}",
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                        SizedBox(width: 5.w,),
                                        normalText(text: "${data.user!.fullName}",fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                   SizedBox(height: 5.h,),
                                   Text("${data.comment}",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),)

                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
