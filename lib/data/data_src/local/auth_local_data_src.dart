import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSrc {
  final SharedPreferences prefs;

  AuthLocalDataSrc({required this.prefs});

  Future<bool> saveToken(String token) async =>
      await prefs.setString('token', token);

  String? getToken() => prefs.getString('token');

  Future<bool> removeToken() async => await prefs.remove('token');

  Future<bool> setFirstEntry(bool value) async =>
      await prefs.setBool('isFirstEntry', value);

  bool isFirstEntry() => prefs.getBool('isFirstEntry') ?? true;
}
