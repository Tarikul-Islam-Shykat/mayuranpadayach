import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global_widegts/app_snackbar.dart';

class GalleryController extends GetxController {
  final _picker = ImagePicker();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var uploadProgress = ''.obs;
  var currentUploadIndex = 0.obs;
  var totalImages = 0.obs;
  RxList<File> galleryImages = <File>[].obs;

  // Set to store image hashes for duplicate detection
  final Set<String> _imageHashes = <String>{};

  // Generate SHA-256 hash for an image file
  Future<String> _generateImageHash(File imageFile) async {
    try {
      Uint8List imageBytes = await imageFile.readAsBytes();
      var digest = sha256.convert(imageBytes);
      return digest.toString();
    } catch (e) {
      log("Error generating image hash: $e");
      return '';
    }
  }

  Future<void> pickGalleryImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imageHash = await _generateImageHash(imageFile);

      if (imageHash.isNotEmpty && !_imageHashes.contains(imageHash)) {
        galleryImages.add(imageFile);
        _imageHashes.add(imageHash);
        errorMessage.value = ''; // Clear error when image is added

        AppSnackbar.show(message: "Image added successfully", isSuccess: true);
      } else if (_imageHashes.contains(imageHash)) {
        AppSnackbar.show(
          message: "This image is already added",
          isSuccess: false,
        );
      }
    }
  }

  Future<void> pickMultipleGalleryImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        int addedCount = 0;
        int duplicateCount = 0;

        // Process each selected image
        for (XFile file in pickedFiles) {
          File imageFile = File(file.path);
          String imageHash = await _generateImageHash(imageFile);

          if (imageHash.isNotEmpty && !_imageHashes.contains(imageHash)) {
            galleryImages.add(imageFile);
            _imageHashes.add(imageHash);
            addedCount++;
          } else if (_imageHashes.contains(imageHash)) {
            duplicateCount++;
          }
        }

        errorMessage.value = ''; // Clear any previous errors

        // Show appropriate success/warning message based on results
        if (addedCount > 0 && duplicateCount == 0) {
          // All images were new
          AppSnackbar.show(
            message:
                "$addedCount ${addedCount == 1 ? 'image' : 'images'} added successfully",
            isSuccess: true,
          );
        } else if (addedCount > 0 && duplicateCount > 0) {
          // Some images were new, some were duplicates
          AppSnackbar.show(
            message:
                "$addedCount ${addedCount == 1 ? 'image' : 'images'} added. $duplicateCount ${duplicateCount == 1 ? 'duplicate' : 'duplicates'} not added (already in list)",
            isSuccess: true,
          );
        } else if (addedCount == 0 && duplicateCount > 0) {
          // All images were duplicates
          AppSnackbar.show(
            message:
                "$duplicateCount ${duplicateCount == 1 ? 'image' : 'images'} not added - already in the list",
            isSuccess: false,
          );
        } else {
          // No images were processed successfully
          AppSnackbar.show(
            message: "No images could be processed",
            isSuccess: false,
          );
        }
      }
    } catch (e) {
      log("Error picking multiple images: $e");
      errorMessage.value = 'Failed to select images: ${e.toString()}';
    }
  }

  // Remove image from gallery
  void removeImage(int index) {
    if (index >= 0 && index < galleryImages.length) {
      // Remove the corresponding hash when removing image
      File imageToRemove = galleryImages[index];
      _generateImageHash(imageToRemove).then((hash) {
        if (hash.isNotEmpty) {
          _imageHashes.remove(hash);
        }
      });

      galleryImages.removeAt(index);
    }
  }

  // Clear all images
  void clearGallery() {
    galleryImages.clear();
    _imageHashes.clear(); // Clear the hash set as well
    errorMessage.value = '';
    uploadProgress.value = '';
    currentUploadIndex.value = 0;
    totalImages.value = 0;
  }

  // Upload single image
  Future<bool> uploadSingleImage(File imageFile, int index) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${Urls.baseUrl}/gallery"),
      );

      SharedPreferences sh = await SharedPreferences.getInstance();

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': "${sh.getString("token")}",
      });

      // Add single image
      var imageBytes = await imageFile.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'images', // Use 'images' as field name
        imageBytes,
        filename: 'gallery_${index}_${imageFile.path.split('/').last}',
      );
      request.files.add(multipartFile);

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final responseJson = json.decode(responseString);

      log("Single image upload response: $responseJson");

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseJson['success'] == true) {
        return true;
      } else {
        log("Failed to upload image ${index + 1}: ${responseJson['message']}");
        return false;
      }
    } catch (e) {
      log("Single image upload error: $e");
      return false;
    }
  }

  // Upload gallery images one by one
  Future<bool> uploadGalleryImages() async {
    if (galleryImages.isEmpty) {
      errorMessage.value = 'Please select at least one image';
      return false;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
      totalImages.value = galleryImages.length;
      currentUploadIndex.value = 0;

      int successCount = 0;
      int failedCount = 0;

      // Upload each image one by one
      for (int i = 0; i < galleryImages.length; i++) {
        currentUploadIndex.value = i + 1;
        uploadProgress.value = 'Uploading ${i + 1}/${galleryImages.length}...';

        bool success = await uploadSingleImage(galleryImages[i], i);

        if (success) {
          successCount++;
        } else {
          failedCount++;
        }

        // Small delay between uploads to prevent overwhelming the server
        await Future.delayed(Duration(milliseconds: 500));
      }

      // Show final result
      if (failedCount == 0) {
        AppSnackbar.show(
          message: "All $successCount images uploaded successfully!",
          isSuccess: true,
        );
      } else if (successCount > 0) {
        AppSnackbar.show(
          message: "$successCount images uploaded, $failedCount failed",
          isSuccess: false,
        );
      } else {
        errorMessage.value = "All uploads failed. Please try again.";
        return false;
      }

      // Refresh gallery data
     // final ShopProfileController controller = Get.put(ShopProfileController());
      //await controller.fetchGalleryData();

      // Clear gallery and close dialog only if at least some uploads succeeded
      if (successCount > 0) {
        clearGallery();
        Get.back();
        return true;
      }

      return false;
    } catch (e) {
      log("Gallery upload error: $e");
      errorMessage.value = 'Upload failed: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
      uploadProgress.value = '';
    }
  }

  @override
  void onClose() {
    clearGallery();
    super.onClose();
  }
}
