class Category {
  int? id;
  String? title;
  int? iOrder;
  List<Category>? subCategories;

  Category({this.id, this.title, this.iOrder, this.subCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    iOrder = json['_order'];
    subCategories = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['_order'] = iOrder;
    return data;
  }
}
