class User {
  final String? id;
  final String? userName;
  final String? email;
  final String? mobileNumber;
  final String? gender;
  final String? dob;
  final String? drivingLicense;
  final String? profileImage;

  User({
    this.id,
    this.userName,
    this.email,
    this.mobileNumber,
    this.gender,
    this.dob,
    this.drivingLicense,
    this.profileImage,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
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
