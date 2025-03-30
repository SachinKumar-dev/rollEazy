import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/models/ride_model/ride_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/refund_model/refund_model.dart';
import '../../services/api_services/api_services.dart';

class RideController extends GetxController{
  final url = Get.find<ApiServices>();
  final dio = Dio();

  //get ended rides
  Future<List<RideModel>?> getEndedRides({required String rideId}) async {

    try {
      //print"here");
      final response = await dio.post(url.getEndedRides(),data: {'RideID':rideId});
      if (response.statusCode == 200) {
        // Assuming response.data['data'] contains the list of vehicles
        var vehicleData = response.data['data'];
        //print"here");
        // Convert the 'data' to a List of Vehicle objects
        List<RideModel> listOfEndedRides = (vehicleData as List).map((item) {
          return RideModel.fromJson(item);
        }).toList();

        //print"List of ended rides inside getEndedRides: $listOfEndedRides");

        if(listOfEndedRides.isNotEmpty){
          //print"here");
          return listOfEndedRides;
        }

      } else {
        //print'Failed to load vehicles, status code: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      //print'Error fetching vehicle data: $e');
    } catch (e) {
      //print'Unexpected error: $e');
    }
    return null;
  }

  //fun to get refunded data
  Future<Refund?> getRefundDetailedData({required String riderId}) async {
    final getRefundDataUrl = url.getRefundDataUrl();
    try {
      final response = await dio.post(getRefundDataUrl, data: {
        "rideId": riderId,
      });
      if (response.statusCode == 200) {
        //print"success got the data");
        return Refund.fromJson(response.data['data']);
      }
    } on DioException catch (e) {
      //printe);
    } catch (e) {
      //printe);
    }
    return null;
  }

  //need another controller to get all refund data with userId as List
  Future<List<Refund>?> getRefundData({required String userId}) async {
    final getRefundDetailedDataUrl = url.getRefundDetailedDataUrl();
    try {
      final response = await dio.post(getRefundDetailedDataUrl, data: {
        "userId": userId,
      });
      if (response.statusCode == 200) {
        //print"success got the data");
        //map every file as list and return it...
        final List<dynamic> dataList = response.data['data'] ?? [];
        //print"heres the refund data ${dataList[0]}");
        return dataList.map((item) => Refund.fromJson(item)).toList();
      }
    } on DioException catch (e) {
      //printe);
    } catch (e) {
      //printe);
    }
    return null;
  }

  //getEndedRideUrlAsPerRideId
  Future<RideModel?> getEndedRideUrlAsPerRideId(
      {required String rideId}) async {
    //print"ended ride fun call nhi ho rha kya ");
    final getEndedRideAsPerRideIdUrl = url.getEndedRideUrlAsPerRideId();
    final response = await dio.post(getEndedRideAsPerRideIdUrl, data: {'_id': rideId});
    try {
      if (response.statusCode == 200) {
        //print"200");
        //assign to model and return
        final data = RideModel.fromJson(response.data['data']);
        return data;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 500) {
          //print'something went wrong');
        } else {
          //print"404 error");
        }
      }
      return null;
    } catch (error) {
      //printerror);
      return null;
    }
    return null;
  }

  //url launcher for opening the dialer
  Future<void> launchCallerApp(String phoneNumber) async {
    final Uri phoneUrl = Uri(scheme: 'tel',path: phoneNumber);
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      //print"Could not launch phone app.");
    }
  }


}