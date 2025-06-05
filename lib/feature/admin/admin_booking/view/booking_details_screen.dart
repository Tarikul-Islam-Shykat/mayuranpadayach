import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../../route/route.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundBackButton(onTap: ()=>Get.back()),
        ),
        title:Text("Booking Details",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.textBlackColor),) ,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ExpansionTile(
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
                backgroundColor: Colors.white,
                title: Text("Selected Services",style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.textBlackColor,
            ),),

              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: AppColors.gradientColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: AppNetworkImage(
                            height: 55,
                            width: 55,
                            src:
                            "https://ascottdhaka.com/uploads/media/1733210125_DSC00199__Edited.jpg"),
                      ),
                      SizedBox(width: 5.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Regular Haircut & Beard",
                            style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$15",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor),
                              ),
                              Text(
                                " / 1 hour",
                                style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor),
                              ),
                            ],
                          ),

                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }


}
