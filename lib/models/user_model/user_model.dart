class User {
  final String? id;
  final String? userName;
  final String? email;
  final String? mobileNumber;
  final String? gender;
  final String? dob;
  final int? totalTrips;
  final String? drivingLicense;
  final String? profileImage;

  User({
    this.totalTrips,
    this.id,
    this.userName,
    this.email,
    this.mobileNumber,
    this.gender,
    this.dob,
    this.drivingLicense,
    this.profileImage,
  });

  //making a json file for  caching
  Map<String, dynamic> toJson() => {
    '_id': id,
    'total_trips':totalTrips,
    'userName': userName,
    'email': email,
    'mobileNumber': mobileNumber,
    'gender': gender,
    'dob': dob,
    'drivingLicense': drivingLicense,
    'profileImage':profileImage
  };

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      totalTrips: json['total_trips'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      profileImage: json['profileImage'] ?? '',
      drivingLicense: json['drivingLicense'] ?? '',
    );
  }
}
