import 'dart:convert';

import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/constants/app_constants.dart';
import 'package:ente/models/product_models.dart';
import 'package:http/http.dart' as http;

Future<List<ProductModel>> productList() async {
  var request =
      http.Request('GET', Uri.parse(Constants.onlineTesturl + '/products/'));

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodedRes = json.decode(response.body);

  if (response.statusCode == 200) {
    var productJsonObject = decodedRes as List;

    List<ProductModel> productList = productJsonObject
        .map((tagJson) => ProductModel.fromJson(tagJson))
        .toList();
    print('___________ from model __________');
    print(productList);
    return productList;
  } else {
    print(response.reasonPhrase);
  }
}

Future<List<ProductCategories>> productCategories() async {
  var request = http.Request(
      'GET', Uri.parse(Constants.onlineTesturl + '/product_categories/'));

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodedRes = json.decode(response.body);

  if (response.statusCode == 200) {
    var productJsonObject = decodedRes as List;

    List<ProductCategories> productCategories = productJsonObject
        .map((tagJson) => ProductCategories.fromJson(tagJson))
        .toList();
    print(response);
    return productCategories;
  } else {
    print(response.reasonPhrase);
  }
}

Future<void> addToCart(String productId) async {
  String token = await getToken();
  var headers = {'Authorization': 'Bearer $token'};
  var request = http.Request('POST',
      Uri.parse(Constants.onlineTesturl + '/product/add_to_cart/$productId/'));

  request.headers.addAll(headers);

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodedRes = json.decode(response.body);

  if (response.statusCode == 200) {
    print(decodedRes);
  } else {
    print(response.reasonPhrase);
  }
}

Future<List<Order>> getCartlist() async {
  String token = await getToken();
  var headers = {'Authorization': 'Bearer $token'};
  var request = http.Request(
      'GET', Uri.parse(Constants.onlineTesturl + '/product/orders/'));

  request.headers.addAll(headers);

  http.StreamedResponse streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);
  var decodedRes = json.decode(response.body);

  if (response.statusCode == 200) {
    print(response);
    var productJsonObject = decodedRes as List;

    List<Order> order =
        productJsonObject.map((tagJson) => Order.fromJson(tagJson)).toList();
    return order;
  } else {
    print(response.reasonPhrase);
  }
}
