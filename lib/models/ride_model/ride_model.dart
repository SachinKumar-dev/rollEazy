class RideModel {
  String id;
  String from;
  String to;
  String vehicleName;
  String vehicleNumber;
  double currentDistance;
  double distanceCovered;
  double distanceEndAt;
  String mobileNo;
  String startTime;
  String endTime;
  String riderName;
  int    personCount;
  String startDate;
  String endDate;
  String transactionID;
  double amountPaid;
  double penaltyPaid;
  String rideID;
  String penaltyReason;
  bool journeyStatus;
  double customerRating;

  // Constructor
  RideModel({
    required this.id,
    required this.penaltyReason,
    required this.from,
    required this.to,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.currentDistance,
    required this.distanceCovered,
    required this.distanceEndAt,
    required this.mobileNo,
    required this.startTime,
    required this.endTime,
    required this.riderName,
    required this.personCount,
    required this.startDate,
    required this.endDate,
    required this.transactionID,
    required this.amountPaid,
    required this.penaltyPaid,
     required this.rideID,
    required this.journeyStatus,
    required this.customerRating,
  });

  // fromJson method to map the API response to this model
  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'] ?? "",
      from: json['From'] ?? "",
      to: json['To'] ?? "",
      vehicleName: json['VehicelName'] ?? "",
      vehicleNumber: json['VehicleNumber'] ?? "",
      currentDistance: json['CurrentDistance']?.toDouble() ?? 0.0,
      distanceCovered: json['DistanceCovered']?.toDouble() ?? 0.0,
      distanceEndAt: json['Distance_end_at']?.toDouble() ?? 0.0,
      mobileNo: json['Mobile_no'] ?? "",
      startTime: json['StartTime'] ?? "",
      endTime: json['EndTime'] ?? "",
      riderName: json['RiderName'] ?? "",
      personCount: json['Personcount'] ?? 0,
      startDate: json['StartDate'] ?? "",
      endDate: json['EndDate'] ?? "",
      transactionID: json['TransactionID'] ?? "",
      amountPaid: json['Amount_paid']?.toDouble() ?? 0.0,
      penaltyPaid: json['penalty_paid']?.toDouble() ?? 0.0,
      rideID: json['RideID'] ?? "",
      journeyStatus: json['JourneyStatus'] ?? false,
      customerRating: json['customer_rating']?.toDouble() ?? 0.0, penaltyReason: json['penalty_reason'],
    );
  }

  // toJson method to convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'penalty_reason':penaltyReason,
      '_id': id,
      'From': from,
      'To': to,
      'VehicelName': vehicleName,
      'VehicleNumber': vehicleNumber,
      'CurrentDistance': currentDistance,
      'DistanceCovered': distanceCovered,
      'Distance_end_at': distanceEndAt,
      'Mobile_no': mobileNo,
      'StartTime': startTime,
      'EndTime': endTime,
      'RiderName': riderName,
      'Personcount': personCount,
      'StartDate': startDate,
      'EndDate': endDate,
      'TransactionID': transactionID,
      'Amount_paid': amountPaid,
      'penalty_paid': penaltyPaid,
        'RideID': rideID,
      'JourneyStatus': journeyStatus,
      'customer_rating': customerRating,
    };
  }
}
