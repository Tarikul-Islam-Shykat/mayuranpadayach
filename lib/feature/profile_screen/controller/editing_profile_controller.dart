import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePictureController extends GetxController {
  final _picker = ImagePicker();
  var isUploading = false.obs;
  var errorMessage = ''.obs;
  var uploadProgress = 0.0.obs;
  var imageSizeText = ''.obs;
  Rx<File?> profileImage = Rx<File?>(null);

  // Pick profile image from gallery
  Future<void> pickProfileImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Compress the image
        File? compressedImage = await _compressImage(imageFile);

        if (compressedImage != null) {
          profileImage.value = compressedImage;
          await _updateImageSizeText(compressedImage);
          errorMessage.value = '';
          AppSnackbar.show(
            message: "Profile picture selected successfully",
            isSuccess: true,
          );
        } else {
          errorMessage.value = 'Failed to compress image';
        }
      }
    } catch (e) {
      log("Error picking profile image: $e");
      errorMessage.value = 'Failed to select image: ${e.toString()}';
    }
  }

  // Pick profile image from camera
  Future<void> pickProfileImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Compress the image
        File? compressedImage = await _compressImage(imageFile);

        if (compressedImage != null) {
          profileImage.value = compressedImage;
          await _updateImageSizeText(compressedImage);
          errorMessage.value = '';
          AppSnackbar.show(
            message: "Profile picture captured successfully",
            isSuccess: true,
          );
        } else {
          errorMessage.value = 'Failed to compress image';
        }
      }
    } catch (e) {
      log("Error capturing profile image: $e");
      errorMessage.value = 'Failed to capture image: ${e.toString()}';
    }
  }

  // Compress image to meet size requirements
  Future<File?> _compressImage(File imageFile) async {
    try {
      // Get file size before compression
      int originalSize = await imageFile.length();
      log("Original image size: ${(originalSize / 1024).toStringAsFixed(2)} KB");

      // If image is already under 250KB, return as is
      if (originalSize <= 250 * 1024) {
        return imageFile;
      }

      // Compress image
      String targetPath = imageFile.path
          .replaceAll('.jpg', '_compressed.jpg')
          .replaceAll('.jpeg', '_compressed.jpeg')
          .replaceAll('.png',
              '_compressed.jpg'); // Convert PNG to JPG for better compression

      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 800, // Maximum width
        minHeight: 800, // Maximum height
        quality: 85, // Start with 85% quality
        format: CompressFormat.jpeg,
      );

      if (compressedBytes == null) {
        log("Failed to compress image");
        return null;
      }

      // If still too large, try with lower quality
      int currentSize = compressedBytes.length;
      int quality = 85;

      while (currentSize > 250 * 1024 && quality > 50) {
        quality -= 10;
        log("Trying with quality: $quality");

        compressedBytes = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 600,
          minHeight: 600,
          quality: quality,
          format: CompressFormat.jpeg,
        );

        if (compressedBytes != null) {
          currentSize = compressedBytes.length;
        } else {
          break;
        }
      }

      if (compressedBytes == null) {
        log("Failed to compress image to required size");
        return null;
      }

      // Write compressed image to file
      File compressedFile = File(targetPath);
      await compressedFile.writeAsBytes(compressedBytes);

      int finalSize = compressedBytes.length;
      log("Compressed image size: ${(finalSize / 1024).toStringAsFixed(2)} KB");

      return compressedFile;
    } catch (e) {
      log("Error compressing image: $e");
      return null;
    }
  }

  // Update image size text for display
  Future<void> _updateImageSizeText(File imageFile) async {
    try {
      int sizeInBytes = await imageFile.length();
      double sizeInKB = sizeInBytes / 1024;

      if (sizeInKB < 1024) {
        imageSizeText.value = "${sizeInKB.toStringAsFixed(1)} KB";
      } else {
        double sizeInMB = sizeInKB / 1024;
        imageSizeText.value = "${sizeInMB.toStringAsFixed(1)} MB";
      }
    } catch (e) {
      imageSizeText.value = "Size unknown";
    }
  }

  // Clear selected image
  void clearImage() {
    profileImage.value = null;
    imageSizeText.value = '';
    errorMessage.value = '';
    uploadProgress.value = 0.0;
  }

  // Upload profile picture
  Future<bool> uploadProfilePicture({
    required String fullName,
    required String phoneNumber,
  }) async {
    if (profileImage.value == null) {
      errorMessage.value = 'Please select a profile picture';
      return false;
    }

    try {
      isUploading.value = true;
      errorMessage.value = '';
      uploadProgress.value = 0.0;

      final request = http.MultipartRequest(
        'PUT', // Using PUT as shown in your Postman screenshot
        Uri.parse("${Urls.baseUrl}/users/profile"),
      );

      SharedPreferences sh = await SharedPreferences.getInstance();

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });

      // Create the JSON data for the data field
      Map<String, dynamic> userData = {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };

      // Add the data field as JSON string
      request.fields['data'] = json.encode(userData);

      // Add the image file
      var imageBytes = await profileImage.value!.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'image', // Field name for image as shown in Postman
        imageBytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      request.files.add(multipartFile);

      // Send request with progress tracking
      var streamedResponse = await request.send();

      // Simulate progress for better UX
      for (int i = 0; i <= 100; i += 10) {
        uploadProgress.value = i.toDouble();
        await Future.delayed(Duration(milliseconds: 50));
      }

      final response = await http.Response.fromStream(streamedResponse);
      final responseJson = json.decode(response.body);

      log("Profile picture upload response: $responseJson");
      log("Status code: ${response.statusCode}");

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseJson['success'] == true) {
        AppSnackbar.show(
          message: "Profile picture uploaded successfully!",
          isSuccess: true,
        );

        // Clear image and close dialog
        clearImage();
        Get.back();
        return true;
      } else {
        errorMessage.value = responseJson['message'] ?? 'Upload failed';
        log("Upload failed: ${responseJson['message']}");
        return false;
      }
    } catch (e) {
      log("Profile picture upload error: $e");
      errorMessage.value = 'Upload failed: ${e.toString()}';
      return false;
    } finally {
      isUploading.value = false;
    }
  }

  @override
  void onClose() {
    clearImage();
    super.onClose();
  }
}
