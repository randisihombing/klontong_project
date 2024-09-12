import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('authToken', token);
}

Future<void> saveSecureToken(String token) async {
  await storage.write(key: 'authToken', value: token);
}

Future<String?> getSecureToken() async {
  return await storage.read(key: 'authToken');
}
