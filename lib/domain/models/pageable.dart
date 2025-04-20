class Pageable {
  final int page;
  final int size;
  final List<String>? sort;

  Pageable({
    this.page = 0,
    this.size = 5,
    this.sort,
  });

  Pageable nextPage() {
    return copyWith(page: page + 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
      'sort': sort,
    };
  }

  Pageable copyWith({
    int? page,
    int? size,
    List<String>? sort,
  }) {
    return Pageable(
      page: page ?? this.page,
      size: size ?? this.size,
      sort: sort ?? this.sort,
    );
  }
}
