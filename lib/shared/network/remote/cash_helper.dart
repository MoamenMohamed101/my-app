import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;
  static inti() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>? putdata(String? key, bool? value) async {
    return await sharedPreferences!.setBool(key!, value!);
  }

  static dynamic getdata({String? key}) {
    return sharedPreferences!.get(key!);
  }

  static Future<bool> removedata({String? key}) async {
    return await sharedPreferences!.remove(key!);
  }

  static Future<bool>? savedata({String? key, dynamic value}) async {
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is bool) return await sharedPreferences!.setBool(key!, value);
    return await sharedPreferences!.setDouble(key!, value);
  }
}
