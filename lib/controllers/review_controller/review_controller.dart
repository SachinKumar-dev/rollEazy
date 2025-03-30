import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import '../../views/reviews_page/review_submit_page.dart';
import '../user_form_ctrl/global_user.dart';
import '../user_form_ctrl/image_ctrl.dart';

class ReviewController extends GetxController {

  final Dio dio = Dio();
  final pendingReviews = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final loggedInUser = Get.find<GlobalUserController>();
  final url = Get.find<ApiServices>();
  final currentRoute = ''.obs;

  void setCurrentRoute(String route) {
    currentRoute.value = route;
  }

  @override
  void onInit() {
    super.onInit();
    checkForPendingReviews();
  }

  //will get all pending rides whose review needs to be submitted
  Future<void> fetchPendingReviews({required String userId}) async {
    isLoading.value = true;
    final getPendingPopUpUrl = url.getPendingPopUpUrl();
    try {
      final response = await dio.post(
        getPendingPopUpUrl,
        data: {'RideID': userId},
      );
      if (response.statusCode == 200) {
        pendingReviews.value = List<Map<String, dynamic>>.from(response.data['data']);
      }
    } catch (error) {
      //print"Error fetching pending reviews: $error");
    } finally {
      isLoading.value = false;
    }
  }

  //trigger the pop-ups
  void showPendingReviewPopUps() async {
    for (var review in pendingReviews) {
      await Get.dialog(
        ReviewPage(reviewData: review),
        barrierDismissible: false,
      );
    }
  }

  //will call on init to find the all pending rides
  void checkForPendingReviews() {
    ever(currentRoute, (route) {
      if (route == '/home') {
        fetchPendingReviews(userId:loggedInUser.user.value?.id ?? "").then((_) {
          if (pendingReviews.isNotEmpty) {
            showPendingReviewPopUps();
          }
        });
      }
    });
  }

  //api call to submit review if submitted
  Future<void> submitReview(Map<String, dynamic> reviewData, int starsCount, String feedback) async {
    final submitReviewUrl = url.getSubmitReviewUrl();
    final rideId = reviewData['_id'];
    final vehicleId = reviewData['vehicleId'];
    var userId = loggedInUser.user.value!.id;
    try {
      Get.dialog(
        Center(
          child: Lottie.asset('assets/images/loadingImg.json'),
        ),
        barrierDismissible: false,
      );
     final response= await dio.post(
        submitReviewUrl,
        data: {
          'rideId': rideId,
          'vehicleId': vehicleId,
          'userid': userId,
          'stars_count': starsCount,
          'feedback': feedback,
        },
      );
      if(response.statusCode==200){
       if(Get.isDialogOpen==true){
         Get.back();
       }
        pendingReviews.removeWhere((review) => review['_id'] == rideId);
      }
      showSnackBar("Success!", "Review saved successfully", Colors.white,SnackPosition.TOP);
    }on DioException catch (error) {
      if(Get.isDialogOpen==true){
        Get.back();
      }
      showSnackBar("Oops!", "Something went wrong", Colors.white,SnackPosition.TOP);
      //print("Error submitting review: $error");
    }catch (e){
      //printe);
    }finally{
      Get.back();
    }
  }

  Future<void> changeStatusOfPopUp(Map<String, dynamic> reviewData)async{
    final getPopUpStatusChangeUrl = url.getPopUpStatusChangeUrl();
    final rideId = reviewData['_id'];

    try{
      final response= await dio.post(getPopUpStatusChangeUrl,data: {'rideId':rideId,'popUpShown':true});
      if(response.statusCode==200){
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Success!", "Review saved successfully", Colors.white,SnackPosition.TOP);
      }
    }on DioException catch(e){
      if(e.response!.statusCode!=null){
        if(e.response!.statusCode==500){
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          showSnackBar("Oops!", "Unable to save review!", Colors.red,SnackPosition.TOP);
        }
      }
    }catch(e){
    //printe);
    }
  }
  void showSnackBar(String title, String message, Color txtColor,position) {
    Get.back();
    Get.find<ImageController>().snackBar(title, message, txtColor: txtColor,position: position);
  }
}
