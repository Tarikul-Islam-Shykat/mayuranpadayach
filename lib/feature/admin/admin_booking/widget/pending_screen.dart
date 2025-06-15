import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../../route/route.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: InkWell(
              onTap: ()=>Get.toNamed(AppRoute.bookingAdminDetailsScreen),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AppNetworkImage(
                        src: "https://adonis.com.bd/wp-content/uploads/2025/03/man-getting-haircut-in-salon.jpg",
                        height: 80,
                        width: 83,
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Zero Hair Studio",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: AppColors.textBlackColor,
                              ),),
                            SizedBox(width: 55.w,),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xffFAF5FE)
                                ),
                                child: Center(child: Image.asset(ImagePath.arrowUp),),
                              ),
                            ),

                          ],
                        ),
                        Text("Ronald Richards",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w500,color: AppColors.textGreyColor),),
                        Text(
                          "Booking Date : 05-04-2025",
                          overflow: TextOverflow.ellipsis,

                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: AppColors.textGreyColor,
                          ),),


                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        });
  }
}