import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import '../../models/vehicle_model/vehicle_model.dart';

class VehicleController extends GetxController {
  final url = Get.find<ApiServices>();
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    _loadVehicle();
  }

  final GetStorage storage = GetStorage();

  RxString vehicleId= "".obs;

  // Cache the vehicles data in an RxList
  RxList<Vehicle> vehicleCache = <Vehicle>[].obs;

  //detailed vehicle data
  var detailedVehicle = Rx<DetailedVehicle?>(null);

  // Load cached vehicle data from GetStorage
  void _loadVehicle() {
    String? storedData = storage.read('vehicle');
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
        // Call the setVehicle method to cache the vehicles data
        setVehicle(listOfVehicles);
      } else {
        print('Failed to load vehicles, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching vehicle data: $e');
    }
  }

  //fetch data based on object id
  Future<void> getDetailedData({required String id}) async {
    final getDetailedDatUrl = url.getDetailedVehicleUrl();  // Your base URL
    try {
      // Make the request
      final response = await dio.get(
        getDetailedDatUrl,
        queryParameters: {'vehicleId': id},
      );

      if (response.statusCode == 200) {
        // Parse the response
        final detailedVehicle = DetailedVehicle.fromJson(response.data['data']);

        print("data from detailed data is ${detailedVehicle}");

        // Store the fetched data - assuming you're using GetX for state management
        setDetailedVehicle(detailedVehicle);

        // Optionally, show the data in your UI (GetX will handle the reactive part)
        // If using setState, set the state here
      } else {
        // Handle failure response
        throw Exception('Failed to fetch vehicle details');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (error) {
      print('Error: $error');
    }
  }

  // Method to set the detailed vehicle data
  void setDetailedVehicle(DetailedVehicle vehicle) {
    detailedVehicle.value = vehicle;
    print("detailedVehicle data is from RX${detailedVehicle.value}");
  }


}
