class ProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final UserData userData;

  ProfileResponse({
    this.success,
    this.statusCode,
    this.message,
    this.userData,
  });
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      userData: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String firstName;
  final String secondName;
  final String phoneNumber;
  final int age;
  final String gender;
  final String imageUrl;

  UserData(
      {this.id,
      this.firstName,
      this.secondName,
      this.phoneNumber,
      this.age,
      this.gender,
      this.imageUrl});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json["id"],
        firstName: json["first_name"],
        secondName: json['last_name'],
        phoneNumber: json['phone_number'],
        age: json['age'],
        gender: json['gender'],
        imageUrl: json['image_url']);
  }
}
