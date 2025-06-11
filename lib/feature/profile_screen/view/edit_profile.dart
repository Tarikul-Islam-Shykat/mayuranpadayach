import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import 'package:prettyrini/feature/profile_screen/controller/editing_profile_controller.dart';
import '../../../core/const/app_colors.dart';
import '../../auth/widget/custom_booton_widget.dart';
import '../widget/round_back_button.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final profileController = Get.put(ProfilePictureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                roundBackButton(
                  () => Get.back(),
                ),
                //SizedBox(width: 50.w,),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Edit Profile",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlackColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                _showImagePickerOptions(context);
              },
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Obx(() => Container(
                          height: 105,
                          width: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.purple.shade50,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: profileController.profileImage.value != null
                                ? Image.file(
                                    profileController.profileImage.value!,
                                    fit: BoxFit.cover,
                                    width: 105,
                                    height: 105,
                                  )
                                : Center(
                                    child: Image.asset(ImagePath.profile),
                                  ),
                          ),
                        )),
                    Positioned(
                      bottom: -6,
                      child: InkWell(
                        onTap: () {
                          _showImagePickerOptions(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            gradient: AppColors.gradientColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                            ImagePath.editIcon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Show image size if image is selected
            // Obx(() => profileController.imageSizeText.value.isNotEmpty
            //     ? Center(
            //         child: Padding(
            //           padding: EdgeInsets.only(top: 8.h),
            //           child: Text(
            //             profileController.imageSizeText.value,
            //             style: GoogleFonts.poppins(
            //               fontSize: 12.sp,
            //               color: Colors.grey.shade600,
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox.shrink()),

            SizedBox(
              height: 15.h,
            ),
            Text(
              "Full Name",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.textBlackColor),
            ),
            CustomAuthField(
                radiusValue: 15.r,
                radiusValue2: 15.r,
                controller: nameController,
                hintText: "Darrell Steward"),

            SizedBox(
              height: 15.h,
            ),
            Text(
              "Email",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.textBlackColor),
            ),
            CustomAuthField(
                radiusValue: 15.r,
                radiusValue2: 15.r,
                controller: emailController,
                hintText: "darrellsteward@example.com"),

            SizedBox(
              height: 15.h,
            ),
            Text(
              "Phone",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.textBlackColor),
            ),
            CustomAuthField(
                radiusValue: 15.r,
                radiusValue2: 15.r,
                controller: phoneController,
                hintText: "+1 761 234 5678"),

            // Show error message if any
            Obx(() => profileController.errorMessage.value.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      profileController.errorMessage.value,
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox.shrink()),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => profileController.isUploading.value
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: btnLoading(),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Column(
                                children: [
                                  Text(
                                    'Updating Profile...',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBlackColor,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  LinearProgressIndicator(
                                    value:
                                        profileController.uploadProgress.value /
                                            100,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.purple,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${profileController.uploadProgress.value.toInt()}% Complete',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : CustomButton(
                          onTap: _updateProfile,
                          title: Text(
                            "Update Profile",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: AppColors.whiteColor),
                          ))),
                ],
              ),
            ),
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
                    profileController.pickProfileImageFromCamera();
                  },
                ),
                _buildImageOption(
                  context,
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    profileController.pickProfileImage();
                  },
                ),
              ],
            ),
            if (profileController.profileImage.value != null) ...[
              SizedBox(height: 20.h),
              _buildImageOption(
                context,
                icon: Icons.delete,
                label: 'Remove',
                color: Colors.red,
                onTap: () {
                  Get.back();
                  profileController.clearImage();
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

  void _updateProfile() async {
    // Validate inputs
    if (nameController.text.trim().isEmpty) {
      profileController.errorMessage.value = 'Please enter your full name';
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      profileController.errorMessage.value = 'Please enter your phone number';
      return;
    }

    // Clear any previous error
    profileController.errorMessage.value = '';

    // Call the upload function with form data
    bool success = await profileController.uploadProfilePicture(
      fullName: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
    );
  }
}
