import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/feature/admin/admin_home/widget/custom_circular_button.dart';
import 'package:prettyrini/feature/profile_screen/widget/round_back_button.dart';
import 'package:get/get.dart';
import 'package:prettyrini/route/route.dart';
import '../../../../core/const/app_colors.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

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
        title:Text("All Services",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.textBlackColor),) ,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCircularButton(icon: Icon(Icons.add), onTap:(){}),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     RoundBackButton(onTap: (){}),
            //     Text("All Services",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.textBlackColor),),
            //     CustomCircularButton(icon: Icon(Icons.add), onTap:(){})
            //   ],
            // ),
            // Container(
            //   padding: EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(6),
            //     color: Colors.purple.shade50,
            //   ),
            //   child: Row(
            //     children: [
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(6),
            //           child: AppNetworkImage(
            //             height: 42.h,
            //               width: 42.w,
            //               src: "https://ascottdhaka.com/uploads/media/1733210125_DSC00199__Edited.jpg"),
            //       ),
            //       SizedBox(width: 5.w,),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text("Regular Haircut & Beard",style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500,color: AppColors.textBlackColor),),
            //           SizedBox(height: 3.h,),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text("\$15",style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor),),
            //               Text(" / 1 hour",style: GoogleFonts.poppins(fontSize: 11.sp,fontWeight: FontWeight.w500,color: AppColors.textBlackColor),),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Spacer(),
            //       CustomCircularButton(icon: Image.asset(ImagePath.editIcon), onTap:(){})
            //
            //     ],
            //   ),
            // ),
           // SizedBox(height: 10,),

            Expanded(
              flex: 20,
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (context,index){
                return  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    onTap: ()=>Get.toNamed(AppRoute.adminServiceDetailsScreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor:Color(0xFFF1EEF9),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: AppNetworkImage(
                          height: 42.h,
                          width: 42.w,
                          src: "https://ascottdhaka.com/uploads/media/1733210125_DSC00199__Edited.jpg"),
                    ),
                    title:Text("Regular Haircut & Beard",style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500,color: AppColors.textBlackColor),) ,
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("\$15",style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor),),
                        Text(" / 1 hour",style: GoogleFonts.poppins(fontSize: 11.sp,fontWeight: FontWeight.w500,color: AppColors.textBlackColor),),
                      ],
                    ) ,
                    trailing:CustomCircularButton(icon: Image.asset(ImagePath.editIcon), onTap:(){}) ,
                  ),
                );
              }),
            ),


          ],
        ),
      ),
    );
  }
}
