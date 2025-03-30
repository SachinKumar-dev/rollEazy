class Vehicle {
  final String coverImage;
  final String id;
  final String category;
  final String vehicleName;
  final String vehicleNumber;
  final int seater;
  final bool availability;
  final int pricePerHour;
  final String state;


  Vehicle({
    required this.state,
    required this.coverImage,
    required this.id,
    required this.category,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.seater,
    required this.availability,
    required this.pricePerHour,

  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      coverImage: json['cover_image'],
      category: json['category'],
      vehicleName: json['vehicle_name'],
      vehicleNumber: json['vehicle_number'],
      seater: json['seater'],
      availability: json['availability'],
      pricePerHour: json['price_per_hr'],
      state: json['state'],
    );
  }

  // Convert Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'cover_image': coverImage,
      '_id': id,
      'category': category,
      'vehicle_name': vehicleName,
      'vehicle_number': vehicleNumber,
      'seater': seater,
      'availability': availability,
      'price_per_hr': pricePerHour,
      'state':state,
    };
  }
}

//Manual Detailed Vehicle model
class VehicleDetails {
  final String currentKm;
  final List<String> demoImages;
  final int deposit;
  final int extraPerHour;
  final String gear;
  final String primaryNum;
  final String secondaryNum;
  final String fuel;
  final String pinCode;
  final String city;
  final List<Review> reviews;
  final List<String> nonFunctionalParts;

  VehicleDetails(
      {required this.currentKm,
        required this.gear,
        required this.primaryNum,
        required this.secondaryNum,
        required this.fuel,
      required this.pinCode,
      required this.city,
      required this.demoImages,
      required this.deposit,
      required this.extraPerHour,
      required this.reviews,

      required this.nonFunctionalParts});

  //fromJson , it calls actual constructor so must ensure all required fields are passed or put if null then what value it should hold
  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
        currentKm: json["current_km"],
        //for type safety that returning one is an array of string only or else null and format error
        demoImages:List<String>.from(json['demo_images']),
        deposit: json["deposit"],
        extraPerHour: json["extra_per_hr"],
        gear: json['gear'],
        fuel: json['fuel'],
        primaryNum: json['primaryNum'],
        secondaryNum: json['secondaryNum'],
        reviews: (json['reviews'] as List?)!
            .map((item) => Review.fromJson(item))
            .toList(),
        nonFunctionalParts: List<String>.from(json['non_functional_parts']), pinCode: json['city'], city: json['pincode']);
  }

  //toJson if need to send back some  data to server or local storage
  //must return object/map/json in {}
  Map<String, dynamic> toJson() {
    return {
      'current_km': currentKm,
      'demo_images': demoImages,
      'deposit': deposit,
      'extra_per_hour': extraPerHour,
      'reviews': reviews,
      'city':city,
      'primaryNum':primaryNum,
      'secondaryNum':secondaryNum,
      'gear': gear,
      'fuel': fuel,
      'pincode':pinCode,
      'non_functional_parts': nonFunctionalParts
    };
  }
}

class Review {
  final DateTime? createdAt;
  final int starsCount;
  final String feedback;

  Review({
    required this.createdAt,
    required this.starsCount,
    required this.feedback,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      //parse String to date time
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      starsCount: json['stars_count'],
      feedback: json['feedback'],
    );
  }

  // Convert Review object to JSON
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'stars_count': starsCount,
      'feedback': feedback,
    };
  }
}
