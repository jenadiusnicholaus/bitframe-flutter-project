import 'dart:convert';
import 'dart:io';
import 'package:ente/constants/custom_exception.dart';
import 'package:ente/constants/app_constants.dart';

import 'package:ente/models/login_models.dart';
import 'package:ente/models/profile_model.dart';
import 'package:ente/models/register_models.dart';
import 'package:ente/models/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

// https://www.instaflutter.com/

Future<LoginResponsePayload> login(LoginRequest loginRequest) async {
  try {
    String _email = loginRequest.email;

    // String _username = body[1];
    var request = http.Request(
        'POST', Uri.parse(Constants.onlineTesturl + '/user_auth/sign_in/'));
    request.bodyFields = {
      'email': '${loginRequest.email}',
      'password': '${loginRequest.password}'
    };
    request.headers.addAll(Constants.headers);

    http.StreamedResponse streamResponse = await request.send();
    var response = await http.Response.fromStream(streamResponse);

    if (response.statusCode == 200) {
      // print(response.statusCode);
      LoginResponsePayload loginResponsePayload =
          LoginResponsePayload.fromJson(json.decode(response.body));
      saveOnShared("token", loginResponsePayload.token);
      saveOnShared("email", _email);
      saveOnShared("username", loginResponsePayload.user.username);

      return loginResponsePayload;
    } else {
      LoginError loginError = LoginError.fromJson(json.decode(response.body));
      throw CustomException(loginError.error);
    }
  } on SocketException {
    throw ('Internet Connection');
  }
}

saveOnShared(String key, String value) async {
  print("Save on Shared Preferences: '$key' -> $value");
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setString(key, value);
}

getFromShared(String key) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  String username = shared.getString(key);

  return username;
}

Future<String> getUsername() async {
  return await getFromShared("username");
}

Future<String> getEmail() async {
  return await getFromShared("email");
}

Future<String> getToken() async {
  return await getFromShared("token");
}

Future<void> signOut() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.remove('token');
  shared.remove('username');
  shared.remove('email');
}

Future<RegisterResponse> register(RegisterRequest registerRequest) async {
  try {
    var request = http.Request(
        'POST', Uri.parse(Constants.onlineTesturl + '/user_auth/sign_up/'));
    request.bodyFields = {
      'username': registerRequest.username,
      'email': registerRequest.email,
      'password': registerRequest.password
    };
    request.headers.addAll(Constants.headers);

    http.StreamedResponse streamResponse = await request.send();
    var response = await http.Response.fromStream(streamResponse);
    Map decodedRes = json.decode(response.body);

    if (response.statusCode == 200 && decodedRes['success']) {
      RegisterResponse registerResponse = RegisterResponse.fromJson(decodedRes);
      return registerResponse;
    } else {
      RegisterError registerError = RegisterError.fromJson(decodedRes);
      throw CustomException(registerError.message);
    }
  } on SocketException {
    throw 'Enternet connection';
  } catch (e) {
    throw e;
  }
}

Future<ProfileResponse> userProfile() async {
  String token = await getToken();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var request = http.Request(
      'GET', Uri.parse(Constants.onlineTesturl + '/user_auth/profile/'));

  request.headers.addAll(headers);

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodedRes = json.decode(response.body);

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    print(decodedRes);
    ProfileResponse profileResponse = ProfileResponse.fromJson(decodedRes);
    print(' from model' + profileResponse.userData.firstName);

    return profileResponse;
  } else {
    print(response.reasonPhrase);
  }
}

Future<void> passwordRest(String token, ChangePassword changePassword) async {
  var headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request(
      'PUT',
      Uri.parse(Constants.localTestUrl +
          '/user_auth/change-password/?old_password=${changePassword.oldPassword}&new_password=${changePassword.newPassword}'));
  request.bodyFields = {
    'old_password': '${changePassword.oldPassword}',
    'new_password': '${changePassword.newPassword}'
  };
  request.headers.addAll(headers);

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodeRes = json.decode(response.body);

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    print(decodeRes);
  } else {
    print(response.reasonPhrase);
  }
}
