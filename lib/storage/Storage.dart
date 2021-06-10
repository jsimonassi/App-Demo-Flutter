import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage{

  static Future<void> save(String key, Map<String, dynamic> values) async {
    try{
      String jsonObject = jsonEncode(values);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, jsonObject);
      print("Objeto guardado! $jsonObject");
    }catch(e){

    }
  }

  static Future<String> retrieve(String key) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    }catch(e){

    }
  }

  static Future<bool> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}