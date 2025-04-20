import 'package:aviz/data/dto/response/user_response_dto.dart';
import 'package:aviz/domain/models/category.dart';
import 'package:aviz/domain/models/user.dart';

class Post {
  int? id;
  String? title;
  String? description;
  num? price;
  double? latitude;
  double? longitude;
  String? imageUrl;
  String? address;
  bool? chatAvailable;
  bool? callAvailable;
  String? postedDate;
  User? user;
  Category? category;

  // New
  double? area;
  double? numOfRooms;
  num? floor;
  int? builtYear;
  bool? hasElevator;
  bool? hasParking;
  bool? hasBasement;

  Post({
    this.id,
    this.title,
    this.description,
    this.price,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.address,
    this.chatAvailable,
    this.callAvailable,
    this.postedDate,
    this.user,
    this.category,
    this.area,
    this.numOfRooms,
    this.floor,
    this.builtYear,
    this.hasElevator,
    this.hasParking,
    this.hasBasement,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    chatAvailable = json['chatAvailable'];
    callAvailable = json['callAvailable'];
    postedDate = json['postedDate'];
    user = json['user'] != null
        ? User.fromJson((json['user'] as UserResponseDto).toJson())
        : null;
    category = json['category'];
    area = json['area'];
    numOfRooms = json['numOfRooms'];
    floor = json['floor'];
    builtYear = json['builtYear'];
    hasElevator = json['hasElevator'] ?? false;
    hasParking = json['hasParking'] ?? false;
    hasBasement = json['hasBasement'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['imageUrl'] = imageUrl;
    data['address'] = address;
    data['chatAvailable'] = chatAvailable;
    data['callAvailable'] = callAvailable;
    data['postedDate'] = postedDate;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }

    data['area'] = area;
    data['numOfRooms'] = numOfRooms;
    data['floor'] = floor;
    data['builtYear'] = builtYear;
    data['hasElevator'] = hasElevator;
    data['hasParking'] = hasParking;
    data['hasBasement'] = hasBasement;

    return data;
  }

  Post copyWith({
    int? id,
    String? title,
    String? description,
    num? price,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? address,
    bool? chatAvailable,
    bool? callAvailable,
    String? postedDate,
    User? user,
    Category? category,
    double? area,
    double? numOfRooms,
    num? floor,
    int? builtYear,
    bool? hasElevator,
    bool? hasParking,
    bool? hasBasement,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      chatAvailable: chatAvailable ?? this.chatAvailable,
      callAvailable: callAvailable ?? this.callAvailable,
      postedDate: postedDate ?? this.postedDate,
      user: user ?? this.user,
      category: category ?? this.category,
      area: area ?? this.area,
      numOfRooms: numOfRooms ?? this.numOfRooms,
      floor: floor ?? this.floor,
      builtYear: builtYear ?? this.builtYear,
      hasElevator: hasElevator ?? this.hasElevator,
      hasParking: hasParking ?? this.hasParking,
      hasBasement: hasBasement ?? this.hasBasement,
    );
  }

  @override
  String toString() {
    return 'Post{id: $id, title: $title, description: $description, price: $price, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, address: $address, chatAvailable: $chatAvailable, callAvailable: $callAvailable, postedDate: $postedDate, user: $user, category: $category, area: $area, numOfRooms: $numOfRooms, floor: $floor, builtYear: $builtYear, hasElevator: $hasElevator, hasParking: $hasParking, hasBasement: $hasBasement}';
  }
}
