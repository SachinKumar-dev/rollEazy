class Refund {
  String id;
  String userId;
  String rideId;
  String refundAmount;
  String? refundReason;
  String refundedDate;
  String transactionId;
  bool isCreated;

  Refund({
    required this.isCreated,
    required this.id,
    required this.userId,
    required this.rideId,
    required this.refundAmount,
    this.refundReason,
    required this.refundedDate,
    required this.transactionId,
  });

  //Factory constructor to create an instance from JSON
  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      userId: json['userId'],
      refundAmount: json['refundAmount'],
      refundReason: json['refundReason'] ?? "N/A",
      refundedDate: json['refundedDate'],
      transactionId: json['transactionId'],
      rideId: json['rideId'],
      id: json['_id'],
      isCreated: json['isCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'rideId': rideId,
      'refundAmount': refundAmount,
      'refundedDate': refundedDate,
      'refundReason': refundReason,
      'transactionId': transactionId,
      '_id': id,
      'isCreated': isCreated,
    };
  }
}


