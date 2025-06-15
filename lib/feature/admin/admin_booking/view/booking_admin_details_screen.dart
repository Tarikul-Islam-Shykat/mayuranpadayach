import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/feature/admin/admin_booking/controller/booking_controller.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../profile_screen/widget/round_back_button.dart';


class BookingAdminDetailsScreen extends StatelessWidget {
   BookingAdminDetailsScreen({super.key});
  final BookingAdminController controller = Get.put(BookingAdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: roundBackButton(()=>Get.back()),
        ),
        title:Text("Booking Details",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.textBlackColor),) ,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 10),
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
            ),
            SizedBox(height: 10.h,),


            Text("Add Specialist",style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlackColor,
            ),),
            SizedBox(height: 5,),
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
                      Text(
                        "Hair Studio",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor),
                      ),

                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 15.h,),
            Text("Date",style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlackColor,
            ),),
            CustomTextField(
                textEditingController:controller.dateTimeController.value,
              hitText: "18-03-2025",
              suffixIcon: IconButton(onPressed: ()async{
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                  controller.dateTimeController.value.text = formattedDate;
                }
              }, icon: Icon(Icons.calendar_month,color: AppColors.grayColor,)),
            ),

            SizedBox(height: 15.h,),
            Text("Choose Timeslot",style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlackColor,
            ),),
            SizedBox(height: 5,),
            GridView.builder(
              itemCount: 12,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                  childAspectRatio: 3
            ),
                itemBuilder: (context,index){

              return  Obx((){
                  return GestureDetector(
                    onTap: (){
                      controller.selectedTime.value=index;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: controller.selectedTime.value == index?Colors.purple:Colors.transparent,width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: controller.selectedTime.value==index?Colors.white:Colors.grey.shade200,
                      ),
                      child: Center(child: Text("11:00 - 12:00",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: controller.selectedTime.value == index?Colors.purple:Colors.black,
                      ),)),
                    ),
                  );
                }
              );
            })



          ],
        ),
      ),
    );
  }


}
