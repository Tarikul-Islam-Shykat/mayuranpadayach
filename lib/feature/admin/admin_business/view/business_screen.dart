import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/admin/admin_business/controller/add_business_controller.dart';
import 'package:prettyrini/feature/admin/admin_business/controller/admin_business_controller.dart';
import 'package:prettyrini/feature/admin/admin_business/controller/admin_subscription_controller.dart';
import 'package:prettyrini/route/route.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../../core/global_widegts/loading_screen.dart';
import '../../../../core/services_class/network_service/image_adding_controller.dart';
import '../../../../core/services_class/network_service/map.dart';
import '../../../../core/services_class/network_service/pop_up_adding_image.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/custome_dropdown.dart';
import '../../../auth/widget/text_field_widget.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import '../model/business_category_model.dart';
import '../widget/common_dropdown_button.dart';


class BusinessScreen extends StatelessWidget {
   BusinessScreen({super.key});
  final AddBusinessController controller = Get.put(AddBusinessController());
  final AdminBusinessController businessController = Get.put(AdminBusinessController());
  final GalleryController imageController = Get.put(GalleryController());
  final AdminSubscriptionController subscriptionController = Get.put(AdminSubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        title: Text(
          "Business",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlackColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCircularButton(icon: Icon(Icons.add), onTap:()=>addBusinessBottomSheet(context)),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx((){
          if(controller.isBusinessLoading.value){
            return Center(child: loading(),);
          }else if(controller.adminBusinessModel.isEmpty){
            return Center(child: Text("No Data Found"),);
          }else{
            return ListView.builder(
                itemCount: controller.adminBusinessModel.length,
                itemBuilder: (context,index){
                  final data = controller.adminBusinessModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GestureDetector(
                      onTap: ()=>Get.toNamed(
                        arguments:{
                          "id":data.id.toString(),
                        },
                          AppRoute.adminBusinessDetailsScreen),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: AppNetworkImage(
                                src: data.image.toString(),
                                height: 80,
                                width: 83,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp,
                                          color: AppColors.textBlackColor,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => addBusinessPlane(context),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Color(0xffFAF5FE),
                                          ),
                                          child: Image.asset(ImagePath.arrowUp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: AppNetworkImage(
                                          src: "${data.category!.image}",
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text("${data.category!.name}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Booking Date : ${DateFormat('dd-MM-yyyy').format(data.createdAt!)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                            color: AppColors.textGreyColor,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(ImagePath.starIcon),
                                          SizedBox(width: 3),
                                          Text("${data.overallRating}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textBlackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }

          }
        ),
      ),
    );
  }

  Future<dynamic> addBusinessBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Business",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
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
            Text("Business Name",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),),
            CustomAuthField(
                radiusValue: 10,
                radiusValue2: 10,
                controller: controller.businessNameTEC,
                hintText: "Business Name"),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Category",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => CommonDropdown<CategoryModel>(
              items: controller.categoryList,
              selectedItem: controller.selectedCategory.value,
              label: "Choose Category",
              onChanged: (value) {
                controller.onCategorySelected(value);
              },
              itemAsString: (CategoryModel cat) => cat.name,
            )),

            SizedBox(
              height: 10.h,
            ),
            Text(
              "Sub Category",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
            // Sub Category Dropdown
            Obx(() => CommonDropdown<SubCategoryModel>(
              items: controller.subCategoryList,
              selectedItem: controller.selectedSubCategory.value,
              label: "Choose Sub Category",
              onChanged: controller.selectedCategory.value == null
                  ? null // disable if no category selected
                  : (value) {
                controller.onSubCategorySelected(value);
              },
              itemAsString: (SubCategoryModel sub) => sub.name,
              enabled: controller.selectedCategory.value != null,
            )),


            SizedBox(
              height: 10.h,
            ),
            Text(
              "Opening & Closing Time",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      controller.pickTime(context, controller.openingTime);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      height: 55,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fillColor,
                      ),
                      child:Obx(() => Text(
                        controller.openingTime.value != null
                            ?DateFormat("hh:mm a").format(controller.timeOfDayToDateTime(controller.openingTime.value!))
                            : "Opening Time",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 15.sp,color:  AppColors.hintTextColor.withValues(alpha: 0.5)),
                      )) ,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      controller.pickTime(context, controller.closingTime);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      height: 55,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fillColor,
                      ),
                      child:Obx(() => Text(
                        controller.closingTime.value != null
                            ?DateFormat("hh:mm a").format(controller.timeOfDayToDateTime(controller.closingTime.value!))
                            : "Closing Time",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:15.sp,color:  AppColors.hintTextColor.withValues(alpha: 0.5)),
                      )) ,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h,),

            Text(
              "Location",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 5,
            ),
           InkWell(
            onTap: () async {
              final result = await Get.to<LocationResult>(() => MapPage());
              if (result != null) {
                controller.long = result.longitude;
                controller.lat = result.latitude;
                controller.locationName = result.locationName ?? '';

                log('Location Picked: 1');
                log('Latitude: ${result.latitude}');
                log('Longitude: ${result.longitude}');
                log('Location Name: ${result.locationName ?? "Unknown"}');
              } else {
                log('User canceled location selection.');
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.fillColor.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      controller.locationName.isNotEmpty
                          ? controller.locationName
                          : "Enter Location",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color:  AppColors.hintTextColor.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Icon(Icons.location_searching),
                ],
              ),
            ),
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
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 105,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor.withValues(alpha:.1),
                ),
                child: Row(
                  children: [
                    Obx(() => Container(

                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: controller.profileImage.value != null
                            ? Image.file(
                          controller.profileImage.value!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ): Image.asset(ImagePath.fileIcon,height: 100,width: 100,),
                      ),
                    )),
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
            Obx(()=>controller.isAddBusinessLoading.value?
            btnLoading():CustomButton(
                onTap: (){
                  controller.addBusinessProfile();

                },
                title: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor),
                ))),
            SizedBox(height: 10.h,),

          ],
        ),
      ),
    );
  }
  Future<dynamic> addBusinessPlane(BuildContext context) {
    final AdminSubscriptionController controller = Get.put(AdminSubscriptionController());
    return Get.bottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Subscription Plan",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.textBlackColor,
                  ),
                ),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.cancel_outlined))
              ],
            ),
            SizedBox(height: 10.h,),
            SizedBox(
             height: MediaQuery.sizeOf(context).height*0.54,
              child: Obx((){
                if(controller.isLoadingSubscription.value){
                  return Center(child: loading(),);
                }else if(controller.adminSubscription.isEmpty){
                  return Center(child: Text("No Data Found"),);
                }else{
                  return ListView.builder(
                      itemCount: controller.adminSubscription.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        final data = controller.adminSubscription[index];
                        return Container(
                          width: 350,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFE9EAEE),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.title,style:GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: AppColors.textBlackColor,
                              ) ,),



                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("\$${data.price}",style: GoogleFonts.poppins(
                                    fontSize: 40.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor,
                                  ),),
                                  Text("/ ${data.duration } month",style: GoogleFonts.poppins(
                                    fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.grayColor,
                                  ),),
                                ],
                              ),
                              Text("${data.platformFee}% Platform fee per booking",style: GoogleFonts.poppins(
                                fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.grayColor,
                              ),),
                              SizedBox(height: 10.h,),




                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.only(right:10,left:10,top:25,bottom:0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade100,
                                ),

                                child: ListView.builder(
                                    itemCount: data.features.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      final feature = data.features[index];
                                      return Column(
                                        mainAxisAlignment:MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("${feature.category} Badge",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColors.textGreyColor),),
                                              Icon(feature.value?Icons.done:Icons.cancel_outlined,color: Colors.purple,),
                                            ],
                                          ),
                                          Divider(),
                                        ],
                                      );
                                    }),
                              ),


                              SizedBox(height: 10.h,),
                              InkWell(
                                onTap: (){},
                                child: Container(
                                  width: Get.width,
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.purple),
                                    color:Colors.transparent,
                                  ),
                                  child: Center(child:Text("Choose Basic",style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.purple,
                                  ),),),
                                ),
                              ),

                              SizedBox(height: 10.h,),


                            ],
                          ),
                        );
                      });
                }

                }
              ),

            ),
            SizedBox(height: 20,),

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
             if (controller.profileImage.value != null) ...[
               SizedBox(height: 20.h),
               _buildImageOption(
                 context,
                 icon: Icons.delete,
                 label: 'Remove',
                 color: Colors.red,
                 onTap: () {
                   Get.back();
                   controller.clearImage();
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
