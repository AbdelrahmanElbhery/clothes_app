import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? shareprefence;
  static init()async{
    shareprefence = await SharedPreferences.getInstance();
  }

  static Future<bool> putbool({
  @required String ?key,
    @required bool ?value
})async{
    return await shareprefence!.setBool(key!, value!);
  }

  static dynamic getdata({
    @required String ?key,
  }){
    return  shareprefence!.get(key!);
  }
  static Future<bool> setdata(
  {@required String ?key,
  @required dynamic value
  })async{
    if(value is String)return await shareprefence!.setString(key!, value);
    if(value is bool)return await shareprefence!.setBool(key!, value);
    if(value is int)return await shareprefence!.setInt(key!, value);
    return await shareprefence!.setDouble(key!, value);
  }

  static Future<bool> removedata({@required String ?key})async{
    return shareprefence!.remove(key!);
  }
}