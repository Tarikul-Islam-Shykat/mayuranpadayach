import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import '../../../../core/const/app_colors.dart';
import '../widget/custom_circular_button.dart';

class AdminHomeScreen extends StatelessWidget {
   AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 30.h,),
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                      child: AppNetworkImage(
                          src: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLA994hpL3PMmq0scCuWOu0LGsjef49dyXVg&s",
                      ),
                  ),
                ),
                SizedBox(width: 10.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back,",style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300
                    ),),
                    Text("Darlene Robertson",style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
                Spacer(),
                CustomCircularButton(icon:Image.asset(ImagePath.notifyIcon,height: 25,width: 25,), onTap: () {},),
              ],
            ),
            SizedBox(height: 15.h,),
            buildBookingDashboard(),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Upcoming Bookings",style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor,
                ),),
                InkWell(
                  onTap: (){},
                  child: Text("See All",style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple,
                  ),),
                ),

              ],
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(height: 4.h,),
                          Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: AppNetworkImage(src: "https://adonis.com.bd/wp-content/uploads/2025/03/man-getting-haircut-in-salon.jpg",height: 15,width: 15,)),
                              SizedBox(width: 5.w,),
                              Text("Ronald Richards",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w500,color: AppColors.textGreyColor),),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "Booking Date : 05-04-2025",
                                  overflow: TextOverflow.ellipsis,

                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                    color: AppColors.textGreyColor,
                                  ),),
                              ),
                              SizedBox(width: 15.w,),
                              Row(
                                children: [
                                  Image.asset(ImagePath.starIcon,),
                                  SizedBox(width: 3,),
                                  Text("4.9",style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textBlackColor,
                                  ),)

                                ],
                              )
                            ],
                          ),


                        ],
                      )

                    ],
                  ),
                ),
              );
            })


          ],
        ),
      ),

    );
  }

  SizedBox buildBookingDashboard() {
    return SizedBox(
            height: 200,
            child: GridView.builder(
              itemCount: dashBoard.length,
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ), itemBuilder: (context,index){
                final data = dashBoard[index];
                  return  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(child: Image.asset(data["icon"],color: AppColors.textBlackColor,),),
                        ),
                        Text(data["title"],style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.textGreyColor,

                        ),),
                        Text(data["bookingNumber"],style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: AppColors.textBlackColor,

                        ),),
                        SizedBox(height: 8.h,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(data["incrementIcon"]),
                                  Text(data["percent"],style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greenColor,
                                  ),)
                                ],
                              ),
                              Text("last week",style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: AppColors.textGreyColor,
                              ),)
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
            }),
          );
  }

 final  List<Map<String,dynamic>> dashBoard =[
    {
      "icon":ImagePath.termsIcon,
      "title":"Total Booking",
      "bookingNumber":"25+",
      "incrementIcon":ImagePath.increseIcon,
      "percent":"20%",
    },
    {
      "icon":ImagePath.pandingIcon,
      "title":"Pending Booking",
      "bookingNumber":"05",
      "incrementIcon":ImagePath.lossIcon,
      "percent":"10%",
    },
  ];
}


