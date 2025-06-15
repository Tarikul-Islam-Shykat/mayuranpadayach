import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/feature/admin/admin_booking/controller/booking_controller.dart';
import 'package:prettyrini/feature/admin/admin_booking/widget/complete_screen.dart';
import '../../../../core/const/app_colors.dart';
import '../widget/pending_screen.dart';

class BookingAdminScreen extends StatelessWidget {
   BookingAdminScreen({super.key});
   final BookingAdminController controller =Get.put( BookingAdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Booking",style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.textBlackColor,
        ),),
        centerTitle: true,
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: Colors.transparent,

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                        return InkWell(
                          onTap: () => controller.showPending(),

                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              gradient:controller.isPending.value?AppColors.gradientColor:null,
                              borderRadius: BorderRadius.circular(40),
                              color: !controller.isPending.value?Color(0xFFF6F1FE):null
                            ),
                            child: Center(
                              child: Text("Pending",style: GoogleFonts.poppins(
                                fontSize: 14.sp,fontWeight: FontWeight.w500,
                                color:controller.isPending.value? Colors.white:Colors.black,
                              ),),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Obx((){
                        return InkWell(
                          onTap: ()=>controller.showComplete(),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                gradient:!controller.isPending.value?AppColors.gradientColor:null,
                                borderRadius: BorderRadius.circular(40),
                                color: controller.isPending.value?Color(0xFFF6F1FE):null
                            ),
                            child: Center(
                              child: Text("Complete",style: GoogleFonts.poppins(
                                fontSize: 14.sp,fontWeight: FontWeight.w500,
                                color: !controller.isPending.value? Colors.white:Colors.black,
                              ),),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:Obx((){
                  return controller.isPending.value? PendingScreen():CompleteScreen();
                }
              ),
            )

          ],
        ),
      ),
    );
  }
}


