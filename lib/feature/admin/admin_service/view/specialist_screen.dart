import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/specialist_controller.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../../core/global_widegts/select_image_option.dart';
import '../../../../route/route.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/text_field_widget.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';

class SpecialistScreen extends StatelessWidget {
   SpecialistScreen({super.key});
   final SpecialistController controller = Get.put(SpecialistController());

  @override
  Widget build(BuildContext context) {
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
          "All Specialist",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlackColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCircularButton(icon: Icon(Icons.add), onTap: ()=>addSpecialistBuild(context)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: 15,
            itemBuilder: (context,index){
          return  Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              onTap: ()=>Get.toNamed(AppRoute.adminBusinessDetailsScreen),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor:Color(0xFFF1EEF9),
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AppNetworkImage(
                    height: 56.h,
                    width: 56.w,
                    src: "https://ascottdhaka.com/uploads/media/1733210125_DSC00199__Edited.jpg"),
              ),
              title:Text("Arlene McCoy",style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor),) ,
              subtitle:Text("Hair Specialist",style: GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w500,color: AppColors.textBlackColor),),
              trailing:CustomCircularButton(
                  height: 32,
                  width: 32,
                  icon: Image.asset(ImagePath.editIcon,color: Colors.black,height: 16,width: 16,), onTap:()=>addSpecialistBuild(context)) ,
            ),
          );
        }),
      ),
    );
  }

  //same function edit and add just change name
  Future<dynamic> addSpecialistBuild(BuildContext context) {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: 12),
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
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Specialist",
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
            Text(
              "Name",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(height: 5,),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller:
              controller.nameTEC.value,
              hintText: "Arlene McCoy",
            ),
            SizedBox(
              height: 10.h,
            ),


            Text(
              "Hair Specialist",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(height: 5,),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller:
              controller.specialistTEC.value,
              hintText: "Hair Specialist",
            ),
            SizedBox(
              height: 10.h,
            ),

            Text(
              "Year Of Experience",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(height: 5,),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller:
              controller.specialistExperienceTEC.value,
              hintText: "4 year",
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
            SizedBox(height: 5,),
            InkWell(
              onTap: ()=>SelectPicker.showImageDialog(context: context, onCamera: (){}, onGallery: (){}),
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10),
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
