import 'dart:convert';
import 'dart:io';

import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/constants/app_constants.dart';
import 'package:ente/models/framemodel.dart';
import 'package:http/http.dart' as http;

Future<void> addFrame(String token, CreateFrame createFrame) async {
  var headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request(
      'POST', Uri.parse(Constants.onlineTesturl + '/frame/registration/'));
  request.bodyFields = {
    'name': '${createFrame.name}',
    'capacity': '${createFrame.capacity}',
    'frame_type': '${createFrame.frameType}',
    'price': '${createFrame.price}',
    'duration': '${createFrame.duration}'
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

Future<List<UserFrame>> getFrameByUser() async {
  String token = await getToken();
  var headers = {'Authorization': 'Bearer $token'};
  var request = http.Request(
      'GET', Uri.parse(Constants.onlineTesturl + '/frame_by_auth/'));
  request.bodyFields = {};
  request.headers.addAll(headers);

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);

  if (response.statusCode == 200) {
    // var frame = (json.decode(response.body) as List)
    //     .map((i) => FrameByLoggedInUser.fromJson(i))
    // //     .toList();
    var frameObjsJson = json.decode(response.body) as List;
    List<UserFrame> frameObjs =
        frameObjsJson.map((tagJson) => UserFrame.fromJson(tagJson)).toList();

    print(frameObjs.length);
    print(frameObjs[1].capacity);

    // print(response.body);

    // print(response.statusCode);
    // print(frameObjsJson);
    return frameObjs;
  } else {
    print(response.body);
    print(response.reasonPhrase);
  }
}

Future<List<FrameListModel>> frameList() async {
  var request =
      http.Request('GET', Uri.parse(Constants.onlineTesturl + '/framesList/'));

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodeRes = json.decode(response.body);

  if (response.statusCode == 200) {
    var frameObjsJson = decodeRes as List;
    List<FrameListModel> frameList = frameObjsJson
        .map((tagJson) => FrameListModel.fromJson(tagJson))
        .toList();
    // print('___________________decoded____________________');
    // print(decodeRes);
    // print('___________________from model____________________');
    // print(frameList);

    return frameList;
  } else {
    print(decodeRes);
    print(response.reasonPhrase);
  }
}
