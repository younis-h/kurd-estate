import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences!.getString(key);
  }

  static Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    return await _preferences!.clear();
  }
}