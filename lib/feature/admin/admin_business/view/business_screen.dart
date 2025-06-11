import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/feature/admin/admin_business/controller/add_business_controller.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/app_network_image.dart';
import '../../../../core/global_widegts/select_image_option.dart';
import '../../../../core/services_class/network_service/image_adding_controller.dart';
import '../../../../core/services_class/network_service/map.dart';
import '../../../../core/services_class/network_service/pop_up_adding_image.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../auth/widget/custome_dropdown.dart';
import '../../../auth/widget/text_field_widget.dart';
import '../../admin_home/widget/custom_circular_button.dart';
import '../../admin_service/controller/service_controller.dart';

class BusinessScreen extends StatelessWidget {
   BusinessScreen({super.key});
  final AddBusinessController controller = Get.put(AddBusinessController());
  final GalleryController imageController = Get.put(GalleryController());

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
        child: ListView.builder(
          itemCount: 5,
            itemBuilder: (context,index){
          return  Padding(
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
                            onTap: ()=>addBusinessPlane(context),
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
        }),
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
            Text("Business Name",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),),
            CustomAuthField(
                radiusValue: 10,
                radiusValue2: 10,
                controller: controller.businessNameTEC,
                hintText: "Zero Hair Studio"),
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
            CustomDropdown(
              items: controller.selectBusinessCategoryList,
              selectedItem: controller.selectBusinessCategory,
              label: "Choose Category",
            ),
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
            CustomDropdown(
              items: controller.selectBusinessSubCategoryList,
              selectedItem: controller.selectBusinessSubCategory,
              label: "Choose Sub Category",
            ),
            SizedBox(
              height: 10.h,
            ),

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
                final result = await Get.to<LocationResult>(() => MapPage(),);
                if (result != null) {
                  controller.long = result.longitude.toString();
                  controller.lat = result.latitude.toString();
                  controller.locationName = result.locationName.toString();

                  log('Location Picked: 1');
                  log('Latitude: ${result.latitude}');
                  log('Longitude: ${result.longitude}');
                  log(
                    'Location Name: ${result.locationName ?? "Unknown"}',
                  );
                } else {
                  log(
                    'User canceled location selection.',
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fillColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     controller.locationName != null?Text(controller.locationName): Text(
                          "Enter Location",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: AppColors.grayColor),
                        ),

                GestureDetector(
                  onTap: () async {
                    final result = await Get.to<LocationResult>(() => MapPage(),);
                    if (result != null) {
                      controller.long = result.longitude.toString();
                      controller.lat = result.latitude.toString();
                      controller.locationName = result.locationName.toString();

                      log('Location Picked: 1');
                      log('Latitude: ${result.latitude}');
                      log('Longitude: ${result.longitude}');
                      log(
                        'Location Name: ${result.locationName ?? "Unknown"}',
                      );
                    } else {
                      log(
                        'User canceled location selection.',
                      );
                    }
                  },
                  child: Icon(Icons.location_searching, color: AppColors.grayColor),
                ),

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
              onTap: () => showGalleryPopup(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                    Obx(() {
                      if (imageController.galleryImages.isEmpty) {
                        return Center(child: Text("No images selected"));
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // প্রতি row-তে ৩টা করে ছবি
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: imageController.galleryImages.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            imageController.galleryImages[index],
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }),
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
  Future<dynamic> addBusinessPlane(BuildContext context) {
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
                    fontWeight: FontWeight.w500,
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
             height: 515,
              child: ListView.builder(
                  itemCount: 3,
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context,index){
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
                        Text("Free",style:GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.sp,
                          color: AppColors.textBlackColor,
                        ) ,),
                        Text("\$2.00",style: GoogleFonts.poppins(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.grayColor,
                        ),),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("\$0.00",style: GoogleFonts.poppins(
                              fontSize: 48.sp,fontWeight: FontWeight.w600,color: AppColors.textBlackColor,
                            ),),
                            Text("/month",style: GoogleFonts.poppins(
                              fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.grayColor,
                            ),),
                          ],
                        ),
                        Text("15% Platform fee per booking",style: GoogleFonts.poppins(
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
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                return Column(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Verified Badge",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColors.textGreyColor),),
                                        Icon(Icons.cancel_outlined,color: Colors.purple,),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                );
                              }),
                        ),


                        SizedBox(height: 30,),
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
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple,
                            ),),),
                          ),
                        ),

                        SizedBox(height: 15.h,),


                      ],
                    ),
                  );
                }),

            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

}
