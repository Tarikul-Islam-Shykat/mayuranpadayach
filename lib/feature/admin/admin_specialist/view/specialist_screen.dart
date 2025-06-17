import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/admin/admin_business/widget/common_dropdown_button.dart';
import 'package:prettyrini/feature/admin/admin_service/controller/service_controller.dart';
import 'package:prettyrini/feature/admin/admin_specialist/controller/specialist_controller.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../../core/global_widegts/app_snackbar.dart';
import '../../../../core/global_widegts/custom_dialog.dart';
import '../../../../core/global_widegts/custom_text.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/text_field_widget.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import '../../admin_service/model/all_service_model.dart';
import '../../admin_service/widget/service_tile.dart';

class SpecialistScreen extends StatelessWidget {
   SpecialistScreen({super.key});
   final AdminSpecialistController controller = Get.put(AdminSpecialistController());
   final ServiceController serviceController = Get.put(ServiceController());
   final String? businessId = Get.arguments?["id"];


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        print("business id $businessId");
        serviceController.getAllService(businessId);

    });

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
            child: CustomCircularButton(icon: Icon(Icons.add),
                onTap: ()=>addSpecialistBuild(context)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx((){
          if(controller.specialistModel.isEmpty && controller.isLoadingSpecialist.value){
            return Center(child: loading(),);
          }else if(controller.specialistModel.isEmpty){
            return Center(child: Text("No Data Found"),);
          }else{
            return ListView.builder(
              controller: controller.scrollController,
                itemCount: controller.hasMore.value
                    ? controller.specialistModel.length + 1
                    : controller.specialistModel.length,
                itemBuilder: (context,index){
                  if (index < controller.specialistModel.length) {
                    final data = controller.specialistModel[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        onTap: (){},
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
                              src: "${data.profileImage}"),
                        ),
                        title:Text("${data.fullName}",style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor),) ,
                        subtitle:Text("${data.specialization}",style: GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w500,color: AppColors.textBlackColor),),
                        trailing:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomCircularButton(
                              height: 30,
                              width: 30,
                              icon: Icon(Icons.delete,color: Colors.red,),
                              onTap: () {
                                deleteDialog(
                                    title: "Are you sure ?",
                                    content: "Are you sure you want to delete this specialist?",
                                    onOk: (){
                                      controller.deleteSpecialist(data.id.toString());

                                    });

                              },
                            ),
                            SizedBox(width: 8.w,),
                            CustomCircularButton(
                                height: 32,
                                width: 32,
                                icon: Image.asset(
                                  ImagePath.editIcon,
                                  color: Colors.black,
                                  height: 16,
                                  width: 16,
                                ),
                                onTap:(){
                                  controller.setEditSpecialistData(data);
                                  addSpecialistBuild(context);
                                }),
                          ],
                        ) ,
                      ),
                    );
                  }

                  return controller.specialistModel.length >= 10 && controller.hasMore.value?  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: loading(),
                    ),
                  ):Center();
                });
          }

          }
        ),
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
                Text(controller.isEditing.value?"Update Specialist":
                  "Add Specialist",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.textBlackColor,
                  ),
                ),
                IconButton(
                    onPressed: (){
                      controller.allClear();
                      Get.back();
                    },
                    icon: Icon(Icons.cancel_outlined))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            fieldText(name: "Name"),
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


            fieldText(name: "Hair Specialist"),
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

            controller.isEditing.value?Center():fieldText(name: "Specialist"),


            controller.isEditing.value?Center():Obx(() {
              return CommonDropdown<ServiceModel>(
                items: serviceController.serviceModel,
                selectedItem: serviceController.selectedService.value,
                label: "Specialist",
                onChanged: (value) {
                  serviceController.selectedService.value = value!;
                },
                itemAsString: (item) => item.name ?? "Unknown",
              );
            }),

            SizedBox(height: 10.h,),
            fieldText(name: "Year Of Experience"),
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
            controller.isEditing.value ? Obx(() => SwitchListTile(
              tileColor: AppColors.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              title: Text("Status : ${controller.isActive.value ? "ACTIVE" : "INACTIVE"}",style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlackColor
              ),),
              value: controller.isActive.value,
              onChanged: (value) => controller.isActive.value = value,
            )):Center(),



            fieldText(name: "Upload Image"),
            InkWell(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 105,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor.withValues(alpha: .1),
                ),
                child: Row(
                  children: [
                    Obx(() {
                      return Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: controller.serviceImage.value != null
                              ? Image.file(
                            controller.serviceImage.value!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          )
                              : controller.serviceImageUrl.value.isNotEmpty
                              ? Image.network(
                            controller.serviceImageUrl.value,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          )
                              : Image.asset(
                            ImagePath.fileIcon,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      );
                    }),

                    SizedBox(
                      width: 5,
                    ),
                    normalText(text: "Select Image"),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            Obx(() {
                return controller.isLoadingSpecialist.value?btnLoading(): CustomButton(
                    onTap: () {
                        if (controller.isEditing.value) {
                          controller.editSpecialist(controller.editingSpecialistId.value.toString());
                        } else {
                          controller.createSpecialist(businessId: businessId.toString());
                        }


                    },
                    title: Text(
                      "Save",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor),
                    ));
              }
            ),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }

   void _showImagePickerOptions(BuildContext context) {
     showModalBottomSheet(
       context: context,
       backgroundColor: Colors.white,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
       ),
       builder: (context) => Container(
         padding: EdgeInsets.all(20.w),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Container(
               width: 40.w,
               height: 4.h,
               decoration: BoxDecoration(
                 color: Colors.grey.shade300,
                 borderRadius: BorderRadius.circular(2.r),
               ),
             ),
             SizedBox(height: 20.h),
             Text(
               'Select Profile Picture',
               style: GoogleFonts.poppins(
                 fontSize: 18.sp,
                 fontWeight: FontWeight.w600,
                 color: AppColors.textBlackColor,
               ),
             ),
             SizedBox(height: 20.h),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 _buildImageOption(
                   context,
                   icon: Icons.camera_alt,
                   label: 'Camera',
                   onTap: () {
                     Get.back();
                     controller.pickImageFormCamera();
                   },
                 ),
                 _buildImageOption(
                   context,
                   icon: Icons.photo_library,
                   label: 'Gallery',
                   onTap: () {
                     Get.back();
                     controller.pickImageProfile();
                   },
                 ),
               ],
             ),
             if (controller.serviceImage.value != null) ...[
               SizedBox(height: 20.h),
               _buildImageOption(
                 context,
                 icon: Icons.delete,
                 label: 'Remove',
                 color: Colors.red,
                 onTap: () {
                   Get.back();
                 },
               ),
             ],
             SizedBox(height: 20.h),
           ],
         ),
       ),
     );
   }

   Widget _buildImageOption(
       BuildContext context, {
         required IconData icon,
         required String label,
         required VoidCallback onTap,
         Color? color,
       }) {
     return GestureDetector(
       onTap: onTap,
       child: Container(
         padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
         decoration: BoxDecoration(
           color: (color ?? AppColors.primaryColor).withOpacity(0.1),
           borderRadius: BorderRadius.circular(12.r),
           border: Border.all(
             color: (color ?? AppColors.primaryColor).withOpacity(0.3),
           ),
         ),
         child: Column(
           children: [
             Icon(
               icon,
               size: 30.sp,
               color: color ?? AppColors.primaryColor,
             ),
             SizedBox(height: 8.h),
             Text(
               label,
               style: GoogleFonts.poppins(
                 fontSize: 14.sp,
                 fontWeight: FontWeight.w500,
                 color: color ?? AppColors.textBlackColor,
               ),
             ),
           ],
         ),
       ),
     );
   }
}
