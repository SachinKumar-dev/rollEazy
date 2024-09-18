import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';

class ImageController extends GetxController {
  RxBool isImageSelected = false.obs;

//Image picker
  Future<void> imagePicker() async {
    try {
      final picker = ImagePicker();
      var pickedFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
      //check size of image
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        int sizeInBytes = file.lengthSync();
        double sizeInMB = sizeInBytes / (1024 * 1024);

        if (sizeInMB > 1.0) {
          Get.snackbar("Warning!", "Image size exceeds 1MB",
              colorText: Colors.red);
          return;
        }
        //proceed to crop the image
        cropImage(file);
      } else {
        Get.snackbar("Error!", "No image selected",
            colorText: Colors.red,);
      }
    } catch (e) {
      Get.snackbar("Oops!", "Unable to select the image",
          colorText: Colors.red);
      return;
    }
  }

  // Crop the image
  Future<void> cropImage(File imageFile) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(
            ratioX: 1.0, ratioY: 1.0), // Circular aspect ratio
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: greenTextColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            // Locks to 1:1 aspect ratio
            hideBottomControls: true, // Hide aspect ratio controls
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true, // Locks the aspect ratio for iOS
          ),
        ],
      );

      if (croppedFile != null) {
        File croppedImage = File(croppedFile.path);
        isImageSelected.value = true;
        // Now, send image for api call
        Get.find<UserFormController>().profileImage = croppedImage;
        Get.snackbar('Success!', 'Image cropped successfully',
            colorText: greenTextColor);
      } else {
        // Cropping was canceled
        Get.snackbar('Error!', 'Failed to crop image',
            colorText: Colors.red);
      }
    } catch (e) {
      // Handle error
      snackBar("Error", "An error occurred :$e",txtColor: Colors.red);
    }
  }

//snackBar controller
  SnackbarController snackBar(String title, String message,
      {
      Color txtColor = Colors.white}) {
    return Get.snackbar(title, message,
        colorText: txtColor);
  }
}
