class RegisterRequest {
  String username;
  String email;
  String password;

  RegisterRequest({
    this.username,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}

class RegisterResponse {
  final bool success;
  final int statusCode;
  final String message;
  final User user;

  RegisterResponse({
    this.success,
    this.statusCode,
    this.message,
    this.user,
  });
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        success: json['sucess'],
        statusCode: json['status_code'],
        message: json['message'],
        user: User.fromJson(json['user']));
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

class RegisterError {
  final bool success;
  final int statusCode;
  final String message;

  RegisterError({this.success, this.statusCode, this.message});

  factory RegisterError.fromJson(Map<String, dynamic> json) {
    return RegisterError(
        success: json['seccess'],
        statusCode: json['status_code'],
        message: json['message']);
  }
}
