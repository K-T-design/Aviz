class Attributes {
  int? id;
  String? title;
  String? valueType;

  Attributes({this.id, this.title, this.valueType});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    valueType = json['valueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['valueType'] = valueType;
    return data;
  }
}
