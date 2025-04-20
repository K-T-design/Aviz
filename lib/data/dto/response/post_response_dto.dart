import 'package:aviz/data/dto/response/user_response_dto.dart';
import 'package:aviz/domain/models/category.dart';

class PostResponseDTO {
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
  UserResponseDto? user;
  Category? category;
  // New
  double? area;
  double? numOfRooms;
  num? floor;
  int? builtYear;
  bool? hasElevator;
  bool? hasParking;
  bool? hasBasement;

  PostResponseDTO(
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
  );

  @override
  String toString() {
    return 'PostResponseDTO{id: $id, title: $title, price: $price, user: $user, numOfRooms: $numOfRooms, floor: $floor}';
  }

  PostResponseDTO.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? UserResponseDto.fromJson(json['user']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    area = json['area'];
    numOfRooms = json['numOfRooms'];
    floor = json['floor'];
    builtYear = json['builtYear'];
    hasElevator = json['hasElevator'];
    hasParking = json['hasParking'];
    hasBasement = json['hasBasement'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'address': address,
      'chatAvailable': chatAvailable,
      'callAvailable': callAvailable,
      'postedDate': postedDate,
      'user': user,
      'category': category,
      'area': area,
      'numOfRooms': numOfRooms,
      'floor': floor,
      'builtYear': builtYear,
      'hasElevator': hasElevator,
      'hasParking': hasParking,
      'hasBasement': hasBasement,
    };
  }
}
