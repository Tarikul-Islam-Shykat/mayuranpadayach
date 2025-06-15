import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/route/route.dart';
import '../../../../core/const/app_colors.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_service/widget/title_and_edit_button.dart';
import '../controller/add_business_controller.dart';


class AboutScreen extends StatelessWidget {
   AboutScreen({super.key});
  final AddBusinessController controller = Get.put(AddBusinessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: roundBackButton( () => Get.back()),
        ),
        title: Text(
          "About",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlackColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Obx((){
          if(controller.isBusinessDetailsLoading.value){
            return Center(child: loading(),);
          }else{
            return Column(
              children: [
                titleAndEditButton('Basic Info', 'Edit', ()=>Get.toNamed(AppRoute.serviceAboutDetailsScreen)),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 220.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.fillColor,
                  ),
                  child: Text("${controller.adminBusinessDetailsModel.value.about}",
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000)),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                titleAndEditButton('Contract Info', 'Edit', (){
                  controller.setEditBusinessValue(controller.adminBusinessDetailsModel.value);
                  Get.toNamed(AppRoute.serviceAboutDetailsScreen);
                    },),
                SizedBox(height: 5,),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.fillColor,
                  ),
                  child: Text("${controller.adminBusinessDetailsModel.value.contactNumber}",
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000)),
                  ),
                )
              ],
            );
          }

          }
        ),
      ),
    );
  }
}


