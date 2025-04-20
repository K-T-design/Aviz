import 'package:aviz/data/dto/response/category_response_dto.dart';
import 'package:aviz/domain/models/category.dart';

abstract class CategoryMapper {
  static Category fromDto(CategoryResponseDto dto) {
    return Category(
      id: dto.id,
      title: dto.title,
      iOrder: dto.order,
    );
  }
}
