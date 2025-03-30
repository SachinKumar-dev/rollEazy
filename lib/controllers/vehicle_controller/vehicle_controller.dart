import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/vehicle_model/vehicle_model.dart';
import '../user_form_ctrl/image_ctrl.dart';

class VehicleController extends GetxController {
  final GetStorage storage = GetStorage();

  final url = Get.find<ApiServices>();
  final dio = Dio();

  //for storing vehicle ids
  final vehicleId = "".obs;

  //list of vehicles from api
  List<Vehicle> listOfVehicles = [];

  //fetch data based on object id
  final reviews = <Review>[].obs;

  // Track loading state
  var isLoading = false.obs;

  //Detailed vehicle holds
  final data = <VehicleDetails>[].obs;

  // Cache the vehicles data in an RxList
  RxList<Vehicle> vehicleCache = <Vehicle>[].obs;

  void showSnackBar(String title, String message, Color txtColor) {
    Get.find<ImageController>().snackBar(title, message, txtColor: txtColor);
  }

  // Set vehicle data and save to GetStorage
  void setVehicle(List<Vehicle> vehicleData) {
    vehicleCache.value = vehicleData;
    // Convert list of Vehicles to JSON format for storage
    storage.write(
        'vehicle', jsonEncode(vehicleData.map((v) => v.toJson()).toList()));
  }

  //fetch all vehicles data
  Future<List<Vehicle>?> getAllVehicles() async {
    //print("called");
    try {
      final response = await dio.get(url.getAllVehicleUrl());
      if (response.statusCode == 200) {
        // Assuming response.data['data'] contains the list of vehicles
        var vehicleData = response.data['data'];

        // Convert the 'data' to a List of Vehicle objects
        listOfVehicles = (vehicleData as List).map((item) {
          return Vehicle.fromJson(item);
        }).toList();

        //print("List of vehicles inside getAllVehicles: $listOfVehicles");

        return listOfVehicles;
      } else {
        //print('Failed to load vehicles, status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      //print('Error fetching vehicle data: $e');
    } catch (e) {
      //print('Unexpected error: $e');
    }
    return null;
  }

  //fix first fields are missing from reviews......
  Future<void> getDetailedData({required String vehicleId}) async {
    final getDetailedDataUrl = url.getDetailedVehicleUrl();

    try {
      isLoading.value = true;
      final response = await dio.get(
        getDetailedDataUrl,
        data: {'veichleId': vehicleId},
      );

      if (response.statusCode == 200 && response.data != null) {
        //print("here ");
        final detailedVehicle =
            VehicleDetails.fromJson(response.data['data']['vBody']);
        //print(response.data['data']['vBody']);
        reviews.value = detailedVehicle.reviews;
        data.assign(detailedVehicle);
        data.refresh();
        await cacheDetailedVehicle(response.data['data']);
      } else {
        //print("else m hu");
        throw Exception('Failed to fetch vehicle details');
      }
    } on DioException catch (e) {
      //print('DioException: ${e.message}');
      final cachedData = await loadCachedDetailedVehicle();
      if (cachedData != null) {
        data.add(VehicleDetails.fromJson(cachedData));
      } else {
        rethrow;
      }
    } catch (error) {
      //print('Error: ${error}');
    } finally {
      isLoading.value = false;
    }
  }

  //fine working
  Future<void> getUserBasedReviews(
      {required String userId, required String vehicleID}) async {
    final getUserBasedReviewsUrl = url.getUserBasedReviews();

    try {
      isLoading.value = true;
      final response = await dio.get(
        getUserBasedReviewsUrl,
        data: {'userId': userId, 'vehicleId': vehicleID},
      );
      if (response.statusCode == 200 && response.data != null) {
        final userReviews = (response.data['userReviews'] as List)
            .map((review) => Review.fromJson(review))
            .toList();
        //print(userReviews);
        //print(response.data['userReviews']);
        reviews.value = userReviews;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        reviews.value = [];
      } else {
        showSnackBar("Oops!", "Network error", Colors.red);
      }
      //print('DioException: ${e.message}');
    } catch (error) {
      //print('Error in catch: $error');
    } finally {
      isLoading.value = false;
    }
  }

  //this will track down the selected category
  RxString? categoryName = "".obs;

  //get category-wise vehicles
  Future<List<Vehicle>?> categoryVehicles({required String category}) async {
    //print("even am i calling");
    final getUrl = url.getCategoryWiseVehicles();
    try {
      isLoading.value = true;
      final response = await dio.post(getUrl, data: {'category': category});
      if (response.statusCode == 200) {
        //print(response);

        //when list is coming map it....
        listOfVehicles = (response.data['data'] as List<dynamic>)
            .map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
            .toList();

        //print(listOfVehicles.length);

        isLoading.value = false;

        return listOfVehicles;
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == null) {
        //print("no internet");
      }
    } catch (error) {
      //print("error in catch is $error");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

// Cache the detailed vehicle data
  Future<void> cacheDetailedVehicle(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('detailed_vehicle', jsonEncode(data));
  }

// Load cached detailed vehicle data
  Future<Map<String, dynamic>?> loadCachedDetailedVehicle() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('detailed_vehicle');
    //printdata);
    return data != null ? jsonDecode(data) as Map<String, dynamic> : null;
  }
}
