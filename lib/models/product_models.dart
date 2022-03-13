import 'package:ente/models/login_models.dart';

class Catgories {
  final int id;
  final String imageUrl;
  final name;

  Catgories({this.id, this.imageUrl, this.name});
}

class ProductModel {
  final String id;
  final String imageUrls;
  final String createdAt;
  final String updatedAt;
  final String productCategories;
  final String frame;
  final String name;
  final num price;
  final String description;
  final String createdBy;

  ProductModel(
      {this.id,
      this.name,
      this.imageUrls,
      this.createdAt,
      this.updatedAt,
      this.productCategories,
      this.frame,
      this.price,
      this.description,
      this.createdBy});

  factory ProductModel.fromJson(dynamic json) {
    return ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrls: json['image'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
        productCategories: json['product_categories'] as String,
        frame: json['frame'] as String,
        price: json['price'] as num,
        description: json['description'] as String,
        createdBy: json['created_by'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name},${this.imageUrls},${this.createdAt},${this.price},${this.updatedAt},${this.productCategories},${this.frame}, ${this.createdBy}, ${this.description} ';
  }
}

class Order {
  final String id;
  final String productId;
  final String productName;
  final String image;
  final int price;
  final String total;
  final int quantity;
  final int totalOrder;

  Order({
    this.id,
    this.productId,
    this.productName,
    this.image,
    this.price,
    this.total,
    this.totalOrder,
    this.quantity,
  });

  factory Order.fromJson(dynamic json) {
    return Order(
      id: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      image: json['image'] as String,
      price: json['price'] as int,
      total: json['total'] as String,
      totalOrder: json['total_order'] as int,
      quantity: json['quantity'],
    );
  }
}

class ProductCategories {
  final String uid;
  final String name;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;
  final String createdBy;

  ProductCategories(
      {this.uid,
      this.name,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  factory ProductCategories.fromJson(dynamic json) {
    return ProductCategories(
        uid: json['id'],
        name: json['name'],
        imageUrl: json['image'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        createdBy: json['create_by']);
  }
  @override
  String toString() {
    return '{ ${this.uid}, ${this.name},${this.imageUrl},${this.createdAt},${this.updatedAt},, ${this.createdBy}';
  }
}

class AddressType {
  final int id;
  final String type;

  AddressType({this.id, this.type});
}

class Address {
  final int id;
  final AddressType addresstype;
  final num phonenumber;

  Address({this.id, this.addresstype, this.phonenumber});
}

class Provider {
  final int id;
  final providerName;

  Provider(this.id, this.providerName);
}

class Payment {
  final int uid;
  final num amount;
  final String description;
  final String createdOn;

  Payment({this.uid, this.amount, this.description, this.createdOn});
}
