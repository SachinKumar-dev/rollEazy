class Vehicle {
  final String coverImage;
  final String id;
  final String category;
  final String vehicleName;
  final String vehicleNumber;
  final int seater;
  final bool availability;
  final int pricePerHour;
  final String gear;
  final String fuel;

  Vehicle({
    required this.coverImage,
    required this.id,
    required this.category,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.seater,
    required this.availability,
    required this.pricePerHour,
    required this.gear,
    required this.fuel,
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
      gear: json['gear'],
      fuel: json['fuel'],
    );
  }

  // Convert Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'cover_image':coverImage,
      '_id': id,
      'category': category,
      'vehicle_name': vehicleName,
      'vehicle_number': vehicleNumber,
      'seater': seater,
      'availability': availability,
      'price_per_hr': pricePerHour,
      'gear': gear,
      'fuel': fuel,
    };
  }
}

//detailed vehicle model

  class DetailedVehicle {
    final int deposit;  // string
    final String currentKm; // 3 KM or just 3 choose one also either String or Int make it common
    final int extraPerHour; // string
    final List<Review> reviews;
    final List<String> demoImages;
    final List<String> nonFunctionalParts;

    DetailedVehicle({
      required this.deposit,
      required this.currentKm,
      required this.extraPerHour,
      required this.reviews,
      required this.demoImages,
      required this.nonFunctionalParts,
    });

    factory DetailedVehicle.fromJson(Map<String, dynamic> json) {
      return DetailedVehicle(
        deposit: json['deposit'],
        currentKm:json['current_km'],
        demoImages: List<String>.from(json['demo_images']),
        extraPerHour: json['extra_per_hr'],
        nonFunctionalParts: List<String>.from(json['non_functional_parts']),
        reviews: (json['reviews'] as List?)!.map((item) => Review.fromJson(item)).toList()
      );
    }
  }

  //reviews model

  class Review {
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int starsCount;
    final String feedback;
    Review({
      required this.createdAt,
      required this.updatedAt,
      required this.starsCount,
      required this.feedback,
    });

    factory Review.fromJson(Map<String, dynamic> json) {
      return Review(
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        starsCount: json['stars_count'],
        feedback: json['feedback'],
      );
    }

    // Convert Review object to JSON
    Map<String, dynamic> toJson() {
      return {
        'createdAt':createdAt,
        'updatedAt':updatedAt,
        'stars_count': starsCount,
        'feedback': feedback,
      };
    }
  }