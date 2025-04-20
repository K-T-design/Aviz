class CategoryResponseDto {
  CategoryResponseDto({
    this.id,
    this.title,
    this.order,
  });

  CategoryResponseDto.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    order = json['_order'];
  }
  int? id;
  String? title;
  int? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['_order'] = order;
    return map;
  }
}
