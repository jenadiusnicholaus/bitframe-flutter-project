class CreateFrame {
  String name;
  String capacity;
  String frameType;
  String price;
  String duration;

  CreateFrame({
    this.name,
    this.capacity,
    this.frameType,
    this.duration,
  });

  // String get calcualatePrice {
  //   return price;
  // }
  set calcualatePrice(String price) {
    if (duration == 'monthly') {
      this.price = "2000";
    } else if (duration == 'yearly') {
      int monthlyprice = 2000;
      int yealy = monthlyprice * 12;
      this.price = yealy.toString();
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'capacity': capacity,
      'frameType': frameType,
      'price': price,
      'duration': duration
    };
    return map;
  }
}

//  "id": "84996b3b-c176-4b1e-bf62-e3a8c8edee5f",
//   "image": null,
//         "name": "jenadFrame",
//         "description": null,
//         "location": null,
//         "capacity": 123,
//         "frame_type": "retailer",
//         "price": 24000.0,
//         "created_at": "2021-03-26T13:02:51.545188Z",
//         "updated_at": "2021-03-26T13:02:51.545208Z",
//         "duration": "yearly",
//         "categories": null,
//         "owner": "ec54de06-238b-4f41-92b9-3cda4398a481"

class UserFrame {
  final String uuid;
  final String categories;
  final String images;
  final String description;
  final String location;
  final String name;
  final int capacity;
  final String frameType;
  final num price;
  final String createdAt;
  final String updatedAt;
  final String duration;
  final String owner;

  UserFrame({
    this.uuid,
    this.name,
    this.capacity,
    this.frameType,
    this.price,
    this.createdAt,
    this.duration,
    this.updatedAt,
    this.owner,
    this.categories,
    this.images,
    this.description,
    this.location,
  });

  factory UserFrame.fromJson(dynamic parsedJson) {
    return UserFrame(
        uuid: parsedJson['id'] as String,
        name: parsedJson['name'] as String,
        capacity: parsedJson['capacity'] as int,
        frameType: parsedJson['frame_type'] as String,
        price: parsedJson['price'] as num,
        createdAt: parsedJson['created_at'] as String,
        updatedAt: parsedJson['updated_at'] as String,
        duration: parsedJson['duration'] as String,
        owner: parsedJson['owner'] as String,
        categories: parsedJson['categories'] as String,
        images: parsedJson['image'] as String,
        description: parsedJson['description'] as String,
        location: parsedJson['location'] as String);
  }

  @override
  String toString() {
    return '{ ${this.uuid}, ${this.name},${this.capacity},${this.frameType},${this.price},${this.createdAt},${this.updatedAt},${this.duration}, ${this.owner} }';
  }
}

class FrameListModel {
  final String uuid;
  final String categories;
  final String images;
  final String description;
  final String location;
  final String name;
  final int capacity;
  final String frameType;
  final num price;
  final String createdAt;
  final String updatedAt;
  final String duration;
  final String owner;

  FrameListModel({
    this.uuid,
    this.name,
    this.capacity,
    this.frameType,
    this.price,
    this.createdAt,
    this.duration,
    this.updatedAt,
    this.owner,
    this.categories,
    this.images,
    this.description,
    this.location,
  });

  factory FrameListModel.fromJson(dynamic parsedJson) {
    return FrameListModel(
        uuid: parsedJson['id'] as String,
        name: parsedJson['name'] as String,
        capacity: parsedJson['capacity'] as int,
        frameType: parsedJson['frame_type'] as String,
        price: parsedJson['price'] as num,
        createdAt: parsedJson['created_at'] as String,
        updatedAt: parsedJson['updated_at'] as String,
        duration: parsedJson['duration'] as String,
        owner: parsedJson['owner'] as String,
        categories: parsedJson['categories'] as String,
        images: parsedJson['image'] as String,
        description: parsedJson['description'] as String,
        location: parsedJson['location'] as String);
  }

  @override
  String toString() {
    return '{ ${this.uuid}, ${this.name},${this.capacity},${this.frameType},${this.price},${this.createdAt},${this.updatedAt},${this.duration}, ${this.owner} }';
  }
}
