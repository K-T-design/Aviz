import 'package:aviz/data/dto/response/post_response_dto.dart';
import 'package:aviz/domain/mappers/user_mapper.dart';
import 'package:aviz/domain/models/post.dart';

abstract class PostMapper {
  static Post fromDto(PostResponseDTO dto) {
    return Post(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      price: dto.price,
      latitude: dto.latitude,
      longitude: dto.longitude,
      imageUrl: dto.imageUrl,
      address: dto.address,
      chatAvailable: dto.chatAvailable,
      callAvailable: dto.callAvailable,
      postedDate: dto.postedDate,
      user: dto.user != null ? UserMapper.fromDto(dto.user!) : null,
      category: dto.category,
      builtYear: dto.builtYear,
      floor: dto.floor,
      numOfRooms: dto.numOfRooms,
      area: dto.area,
      hasElevator: dto.hasElevator,
      hasBasement: dto.hasBasement,
      hasParking: dto.hasParking,
      // dto.category != null ? CategoryMapper.fromDto(dto.category!) : null,
    );
  }
}
