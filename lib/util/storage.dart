import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as JSON;

/// 数据存储
void storeSetItem(String key, value) async {
  final prefs = await SharedPreferences.getInstance();

  if (value is Map || value is List) {
    await prefs.setString(key, JSON.jsonEncode(value));
    return;
  }

  String type = value.runtimeType.toString();
  switch (type) {
    case 'bool':
      await prefs.setBool(key, value);
      break;
    case 'int':
      await prefs.setInt(key, value);
      break;
    case 'double':
      await prefs.setDouble(key, value);
      break;
    default:
      await prefs.setString(key, value);
  }
}

/// 获取数据
Future storeGetItem(String key, {bool special = false}) async {
  final prefs = await SharedPreferences.getInstance();

  print(prefs);

  print(prefs.getString(key));

  if (special) {
    final result = prefs.getString(key);

    if (result == null) return result;

    return JSON.jsonDecode(prefs.getString(key) ?? '');
  }

  return prefs.get(key);
}
