class LoginResponseDto {
  String token;

  LoginResponseDto({required this.token});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      LoginResponseDto(
        token: json["token"],
      );
}
