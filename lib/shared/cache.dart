import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static Future<bool> getBool(String getBool) async{
    final shared = await SharedPreferences.getInstance();
    final boolValue = shared.getBool(getBool) ?? false;
    return boolValue;
  }

  static Future<void>setBool(String setBool, bool value) async {
    final shared = await SharedPreferences.getInstance();
    shared.setBool(setBool, value);
  }

}