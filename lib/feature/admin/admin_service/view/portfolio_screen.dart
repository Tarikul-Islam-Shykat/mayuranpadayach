import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/portfolio_controller.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/select_image_option.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/custome_dropdown.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';

class PortfolioScreen extends StatelessWidget {
   PortfolioScreen({super.key});
   final PortfolioController controller = Get.put(PortfolioController());

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
        title:Text("Portfolio",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.textBlackColor),) ,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCircularButton(icon: Icon(Icons.add), onTap:()=>addPortfolioBuild(context),),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemBuilder: (context,index){
              return Center(
                child: Stack(
                  children: [
                    Container(
                      height: 176,
                      width: 172,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.r),
                          child: AppNetworkImage(src: "https://www.saltgrooming.com/cdn/shop/articles/haircut-clippers_54d401f5-2c6f-4064-a5f7-e3546f7860ea_1200x.png?v=1719220336")),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: CustomCircularButton(
                        borderColor: AppColors.redColor,
                        icon: Icon(Icons.remove,color: Colors.white,size: 18,),
                        onTap: (){},bgColor:AppColors.redColor,
                        height: 24,width: 24,
                      ),
                    ),

                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<dynamic> addPortfolioBuild(BuildContext context) {
    return Get.bottomSheet(
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
            CustomDropdown(
              items: controller.specialistName,
              selectedItem: controller.selectSpecialist,
              label: "Select Specialist",
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
