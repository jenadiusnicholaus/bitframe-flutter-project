class LoginRequest {
  String email;
  String password;

  LoginRequest({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim()
    };
    return map;
  }
}

class User {
  final String username;
  final String email;

  User({
    this.username,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username'], email: json['email']);
  }
}

class LoginResponsePayload {
  bool success;
  int statusCode;
  dynamic message;
  String token;
  String expiry;
  User user;
  LoginResponsePayload({
    this.success,
    this.message,
    this.statusCode,
    this.token,
    this.expiry,
    this.user,
  });

  factory LoginResponsePayload.fromJson(Map<String, dynamic> json) {
    return LoginResponsePayload(
        success: json['success'],
        message: json['message'],
        statusCode: json['status code'],
        token: json['token'],
        expiry: json['exp'],
        user: User.fromJson(json['user']));
  }
}
// {"success":false,"status code":400,"message":{"non_field_errors":["A user with this email and password is not found."]}}

class LoginError {
  bool success;
  int statusCode;
  String error;
  LoginError({this.success, this.statusCode, this.error});

  factory LoginError.fromJson(Map<String, dynamic> json) {
    return LoginError(
        success: json['success'],
        statusCode: json['status code'],
        error: json['error']);
  }
}
