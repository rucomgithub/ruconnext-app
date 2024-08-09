import 'package:shared_preferences/shared_preferences.dart';

class AuthenStorage {
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getAccessToken() async {
    final prefs = await _getPrefs();
    return prefs.getString('accessToken');
  }

  static Future<void> setAccessToken(String token) async {
    final prefs = await _getPrefs();
    await prefs.setString('accessToken', token);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await _getPrefs();
    return prefs.getString('refreshToken');
  }

  static Future<void> setRefreshToken(String token) async {
    final prefs = await _getPrefs();
    await prefs.setString('refreshToken', token);
  }

  static Future<void> clearTokens() async {
    final prefs = await _getPrefs();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
