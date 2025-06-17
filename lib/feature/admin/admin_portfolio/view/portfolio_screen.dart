import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_network_image.dart';
import 'package:prettyrini/core/global_widegts/custom_dialog.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/admin/admin_specialist/controller/specialist_controller.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/custom_text.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/text_field_widget.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_business/widget/common_dropdown_button.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import '../../admin_service/widget/service_tile.dart';
import '../../admin_specialist/model/get_specialist_model.dart';
import '../controller/portfolio_controller.dart';

class PortfolioScreen extends StatelessWidget {
   PortfolioScreen({super.key});
   final PortfolioController controller = Get.put(PortfolioController());
   final AdminSpecialistController specialistController = Get.put(AdminSpecialistController());
   final String? businessId = Get.arguments?["id"];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      specialistController.getAllSpecialist();
    });
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
        child: Obx(() {
          if(controller.isLoadingPortfolio.value){
            return Center(child: loading(),);
          }else if(controller.portfolioModel.isEmpty){
            return Center(child: Text("No Data Found"),);
          }else{
            return GridView.builder(
                itemCount: controller.portfolioModel.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context,index){
                  final data = controller.portfolioModel[index];
                  return Center(
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: (){
                            controller.setEditPortfolioData(data);
                            addPortfolioBuild(context);
                          },
                          child: Container(
                            height: 176,
                            width: 172,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.r),
                                child: AppNetworkImage(src: "${data.image}")),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: CustomCircularButton(
                            borderColor: AppColors.redColor,
                            icon: Icon(Icons.remove,color: Colors.white,size: 18,),
                            onTap: (){
                              deleteDialog(
                                  title: "Are you sure ?",
                                  content: "Are you sure you want to delete this portfolio?",
                                  onOk: (){
                                    controller.deletePortfolio(data.id.toString());

                                  });
                            },bgColor:AppColors.redColor,
                            height: 24,width: 24,
                          ),
                        ),

                      ],
                    ),
                  );
                });
          }

          }
        ),
      ),
    );
  }

  Future<dynamic> addPortfolioBuild(BuildContext context) {
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
                Text(controller.isEditing.value?"Edit Portfolio":
                  "Add Portfolio",
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

            fieldText(name: "Name"),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller:
              controller.title.value,
              hintText: "Name",
            ),
            SizedBox(
              height: 10.h,
            ),
            fieldText(name: "Specialist"),
            Obx((){
              if(specialistController.isLoadingSpecialist.value){
                return Center(child: loading(),);
              }else if(specialistController.specialistModel.isEmpty){
                return Center(child: Text("no data"),);
              }else{
                return CommonDropdown<GetSpecialistModel>(
                  items: specialistController.specialistModel,
                  selectedItem: specialistController.selectedSpecialist.value,
                  label: 'Select Specialist',
                  itemAsString: (item) => item.fullName ?? '',
                  onChanged: (value) {
                    controller.selectedSpecialist.value = value;
                  },
                );
              }

              }
            ),
            SizedBox(
              height: 10.h,
            ),
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
              height: 30.h,
            ),
            Obx(() {
                return controller.isLoadingPortfolio.value?btnLoading():CustomButton(
                    onTap: () {
                      if (controller.isEditing.value) {
                        controller.editPortfolio(controller.editingServiceId.value.toString());
                      } else {
                        controller.createPortfolio(businessId: businessId.toString());
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
