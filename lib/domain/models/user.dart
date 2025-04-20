class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool? phoneConfirmed;
  bool? isFirstEntry;

  String get fullName => "$firstName $lastName";

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.phoneConfirmed,
    this.isFirstEntry,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? phoneConfirmed,
    bool? isFirstEntry,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneConfirmed: phoneConfirmed ?? this.phoneConfirmed,
      isFirstEntry: isFirstEntry ?? this.isFirstEntry,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'phoneConfirmed': phoneConfirmed,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      phoneConfirmed:
          map['phoneConfirmed'] != null ? map['phoneConfirmed'] as bool : null,
    );
  }
}
