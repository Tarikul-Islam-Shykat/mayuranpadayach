import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/admin/admin_home/widget/custom_circular_button.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/service_controller.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import 'package:prettyrini/feature/profile_screen/widget/round_back_button.dart';
import 'package:get/get.dart';
import 'package:prettyrini/route/route.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/global_widegts/select_image_option.dart';

class ServiceScreen extends StatelessWidget {
  final ServiceController controller = Get.put(ServiceController());
  final scrollController = ScrollController();
  ServiceScreen({super.key}){
    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        controller.getAllService(Get.arguments["id"]);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllService(Get.arguments["id"]);
    });
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                roundBackButton(()=>Get.back()),
                Text(
                  "All Services",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: AppColors.textBlackColor),
                ),
                CustomCircularButton(icon: Icon(Icons.add), onTap: ()=>addServiceBuild(context))
              ],
            ),

            Expanded(
              child: Obx(() {
                if(controller.isLoadingService.value){
                  return Center(child: loading(),);
                }else if(controller.serviceModel.isEmpty){
                  return Center(child: Text("No Data Found"),);
                }else{
                  return ListView.builder(
                      controller: scrollController,
                      itemCount: controller.serviceModel.length+1,
                      itemBuilder: (context, index) {
                        if(index <controller.serviceModel.length){
                          var data = controller.serviceModel[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              onTap: () =>
                                  Get.toNamed(AppRoute.adminBusinessDetailsScreen),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Color(0xFFF1EEF9),
                              contentPadding: EdgeInsets.symmetric(horizontal: 5),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: AppNetworkImage(
                                    height: 42.h,
                                    width: 45.w,
                                    src:data.image.toString()),
                              ),
                              title: Text(data.name.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textBlackColor),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "\$ ${data.price}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlackColor),
                                  ),
                                  Text(
                                    " / 1 hour",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textBlackColor),
                                  ),
                                ],
                              ),
                              trailing: CustomCircularButton(
                                icon: Image.asset(ImagePath.editIcon),
                                onTap: () {
                                  addServiceBuild(context);
                                },
                              ),
                            ),
                          );
                        }
                        return null;

                      });
                }

                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> addServiceBuild(BuildContext context) {
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
                                        "Add Service",
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
                                    "Service Name",
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
                                        controller.serviceNameTEC.value,
                                    hintText: "Vip Haircut & Beard",
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Service Price",
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
                                        controller.serviceNameTEC.value,
                                    hintText: "\$50",
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
