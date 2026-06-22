import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static Future<bool> removeData(String key) async {
    debugPrint('SharedPrefHelper: data with key: $key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    debugPrint('SharedPrefHelper: all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }

  static Future<void> setData(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper: setData with key: $key and value : $value");
    switch (value) {
      case String _:
        await sharedPreferences.setString(key, value);
        break;
      case int _:
        await sharedPreferences.setInt(key, value);
        break;
      case bool _:
        await sharedPreferences.setBool(key, value);
        break;
      case double _:
        await sharedPreferences.setDouble(key, value);
        break;
    }
  }

  static Future<bool?> getBool(String key) async {
    debugPrint('SharedPrefHelper: getBool with key: $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  static Future<double?> getDouble(String key) async {
    debugPrint('SharedPrefHelper: getDouble with key: $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  static Future<int?> getInt(String key) async {
    debugPrint('SharedPrefHelper: getInt with key: $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key);
  }

  static Future<String?> getString(String key) async {
    debugPrint('SharedPrefHelper: getString with key: $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}
