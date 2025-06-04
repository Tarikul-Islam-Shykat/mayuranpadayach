import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../profile_screen/widget/profile_list_tile.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import 'package:get/get.dart';

import '../widget/service_tile.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundBackButton(onTap: (){}),
        ),
        title:Text("Zero Hair Studio",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.textBlackColor),) ,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCircularButton(icon: Icon(Icons.add), onTap:(){}),
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
                    child: AppNetworkImage(src: "https://t3.ftcdn.net/jpg/01/53/19/04/360_F_153190451_343c8c86tqWyYEpB066i6MICYURkMwmG.jpg",
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
                          Text("115 Manhattan, New York",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16.sp,color: AppColors.whiteColor),),
                          Row(

                            children: [
                              Icon(Icons.av_timer_sharp,color: Colors.white.withValues(alpha: .40),size: 18,),
                              SizedBox(width: 5,),
                              Text('Next Appointment 12:00',style: GoogleFonts.poppins(fontSize: 11.sp,fontWeight: FontWeight.w400,color: Colors.white.withValues(alpha: .40)),),
                            ],
                          ),

                        ],
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withValues(alpha: .5),
                        ),
                        child: Text("Open",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12.sp,color: AppColors.whiteColor),),
                      ),

                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.h,),
            ServiceTile(onTap: () {  }, name: 'Services', image: ImagePath.service,),
            ServiceTile(onTap: () {  }, name: 'Specialist', image: ImagePath.specialist,),
            ServiceTile(onTap: () {  }, name: 'Portfolio', image: ImagePath.portfolio,),
            ServiceTile(onTap: () {  }, name: 'Review', image: ImagePath.rating,),
            ServiceTile(onTap: () {  }, name: 'About', image: ImagePath.about,),


          ],
        ),
      ),
    );
  }
}


