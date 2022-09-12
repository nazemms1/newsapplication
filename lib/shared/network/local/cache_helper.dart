import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static late SharedPreferences _sharedPreferences;
static init()
async{
  _sharedPreferences=await SharedPreferences.getInstance();
}

static Future<bool> putData({
  required String key,
  required bool value,
})async
{
  return await _sharedPreferences.setBool(key,value);
}

  static dynamic getData({
    required String  key,
  })
  {
    return  _sharedPreferences.get(key );
  }


  static Future<bool> saveData({
    required String key,
    required dynamic value,
  })
  async{
    if(value is String) return   _sharedPreferences.setString(key, value);
    if(value is int) return   _sharedPreferences.setInt(key, value);
    if(value is bool) return   _sharedPreferences.setBool(key, value);
    return   _sharedPreferences.setDouble(key, value);
  }
}