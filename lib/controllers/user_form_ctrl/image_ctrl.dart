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
        double sizeInMB = sizeInBytes / (1024 * 1024 * 1024);

        if (sizeInMB > 3.0) {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          Get.snackbar("Warning!", "Image size exceeds 1MB",
              colorText: Colors.red,backgroundColor: darkBlue);
          return;
        }
        //proceed to crop the image
        cropImage(file);
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.snackbar("Error!", "No image selected",
            colorText: Colors.red,backgroundColor: darkBlue);
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.snackbar("Oops!", "Unable to select the image",
          colorText: Colors.red,backgroundColor: darkBlue);
      return;
    }
  }

  // Crop the image
  Future<void> cropImage(File imageFile) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(
            ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: darkBlue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        File croppedImage = File(croppedFile.path);
        isImageSelected.value = true;
        // Now, send image for api call
        Get.find<UserFormController>().profileImage = croppedImage;
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.snackbar('Success!', 'Image cropped successfully',
            colorText: Colors.white,backgroundColor: darkBlue);
      } else {
        // Cropping was canceled
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.snackbar('Error!', 'Failed to crop image',
            colorText: Colors.red,backgroundColor: darkBlue);
      }
    } catch (e) {
      // Handle error
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      snackBar("Error", "An error occurred :$e",txtColor: Colors.red);
    }
  }

//snackBar controller
  SnackbarController snackBar(String title, String message,{SnackPosition position=SnackPosition.TOP,
      Color txtColor = Colors.white}) {
    return Get.snackbar(title, message,snackPosition:position,backgroundColor:darkBlue,
        colorText: txtColor);
  }
}
