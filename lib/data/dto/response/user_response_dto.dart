class UserResponseDto {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool? phoneConfirmed;

  UserResponseDto({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.phoneConfirmed,
  });

  UserResponseDto.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    phoneConfirmed = json['phoneConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'phoneConfirmed': phoneConfirmed,
    };
  }
}
