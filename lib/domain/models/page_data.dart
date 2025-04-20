class PageData<T> {
  final int currentPage;
  final int totalPages;
  final int totalElements;
  final List<T> content;

  PageData({
    required this.currentPage,
    required this.totalPages,
    required this.totalElements,
    required this.content,
  });

  PageData<U> map<U>(U Function(T) mapper) {
    return PageData<U>(
      currentPage: currentPage,
      totalPages: totalPages,
      totalElements: totalElements,
      content: content.map(mapper).toList(),
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T) toJsonT) {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalElements': totalElements,
      'content': content.map((item) => toJsonT(item)).toList(),
    };
  }

  factory PageData.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return PageData(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      content:
          (json['content'] as List).map((item) => fromJsonT(item)).toList(),
    );
  }

  @override
  String toString() {
    return 'PageData{currentPage: $currentPage, totalPages: $totalPages, totalElements: $totalElements, content: $content}';
  }
}
