import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putDark({bool? isDark}) async {
    if (isDark != null) {
      print("Saving Dark : $isDark");
      return await sharedPreferences!.setBool('isDark', isDark);
    }
    return false;
  }
  static bool getDark()
  {
    bool? sharedPrefDarkMode  = sharedPreferences!.getBool('isDark');
    if(sharedPrefDarkMode != null)
      {
        return sharedPrefDarkMode;
      }
    return false;
  }
}
