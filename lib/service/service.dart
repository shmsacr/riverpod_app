import 'dart:convert';

import 'package:riverpod_app/model/model.dart';
import 'package:http/http.dart' as http;

class Service{
  static Future<UserModel?> fetch()async{
    var url = Uri.parse("https://reqres.in/api/users?page=2");
    var response;
    try{
      response = await http.get(url);
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else
        return null;
    }catch(e){
      print(e);
      return null;
    }
  }
}