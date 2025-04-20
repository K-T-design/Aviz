import 'package:aviz/data/dto/response/user_response_dto.dart';
import 'package:aviz/domain/models/user.dart';

abstract class UserMapper {
  static User fromDto(UserResponseDto dto) {
    return User(
      id: dto.id,
      firstName: dto.firstName,
      lastName: dto.lastName,
      phoneNumber: dto.phoneNumber,
      phoneConfirmed: dto.phoneConfirmed,
    );
  }
}
