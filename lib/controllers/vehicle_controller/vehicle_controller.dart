import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/vehicle_model/vehicle_model.dart';

class VehicleController extends GetxController {
  final GetStorage storage = GetStorage();

  //for storing vehicle ids
  final vehicleId= "".obs;

  // Cache the vehicles data in an RxList
  RxList<Vehicle> vehicleCache = <Vehicle>[].obs;

  //detailed vehicle data
  // var detailedVehicle = Rx<DetailedVehicle?>(null);

  final url = Get.find<ApiServices>();
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    _loadVehicle();
  }

  // Load cached vehicle data from GetStorage
  void _loadVehicle(){
    String? storedData = storage.read('vehicle');
    print("storedData is ${storedData}");
    if (storedData != null) {
      List<dynamic> jsonData = jsonDecode(storedData);
      vehicleCache.value =
          jsonData.map((item) => Vehicle.fromJson(item)).toList();
    }
  }

  // Set vehicle data and save to GetStorage
  void setVehicle(List<Vehicle> vehicleData) {
    vehicleCache.value = vehicleData;
    // Convert list of Vehicles to JSON format for storage
    storage.write(
        'vehicle', jsonEncode(vehicleData.map((v) => v.toJson()).toList()));
  }

  //fetch all vehicles data
  Future<void> getAllVehicles() async {
    List<Vehicle> listOfVehicles = [];
    try {
      final response = await dio.get(url.getAllVehicleUrl());
      if (response.statusCode == 200) {
        // Assuming response.data['data'] contains the list of vehicles
        var vehicleData = response.data['data'];

        // Convert the 'data' to a List of Vehicle objects
        listOfVehicles = (vehicleData as List).map((item) {
          return Vehicle.fromJson(item);
        }).toList();

        print("list of vehicles inside getAllvehicles is ${response.data['data']}");
        // Call the setVehicle method to cache the vehicles data
        setVehicle(listOfVehicles);
      } else {
        setVehicle(listOfVehicles);
        print('Failed to load vehicles, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching vehicle data: $e');
    }
  }

  //fetch data based on object id
  Future<DetailedVehicle?> getDetailedData({required String id}) async {
    final getDetailedDataUrl = url.getDetailedVehicleUrl(); // Your base URL

    try {
      // Attempt to fetch data from the API
      final response = await dio.get(
        getDetailedDataUrl,
       data:{
          'veichleId': id},
      );

      if (response.statusCode == 200 && response.data != null) {
        // Parse the response
        final detailedVehicle = DetailedVehicle.fromJson(response.data['data']);
        // Cache the data for offline use
        await cacheDetailedVehicle(response.data['data']);
        return detailedVehicle;
      } else {
        throw Exception('Failed to fetch vehicle details');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      // Attempt to load cached data
      final cachedData = await loadCachedDetailedVehicle();
      if (cachedData != null) {
        return DetailedVehicle.fromJson(cachedData);
      }
      rethrow; // Re-throw if no cache is available
    } catch (error) {
      print('Error: $error');
      return null;
    }
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
    print(data);
    return data != null ? jsonDecode(data) as Map<String, dynamic> : null;
  }

}
