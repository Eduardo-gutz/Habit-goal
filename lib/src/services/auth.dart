import 'dart:async';
import 'dart:convert';
import 'package:habit_goal/src/models/auth_models.dart';
import 'package:habit_goal/src/services/hg_http.dart';

class AuthService {
  HttpAPI http = HGHttp(suffix: 'auth');

  Future<UserAuth?> login(String username, String pass) async {
    try {
      dynamic response = await http.post('/login', body: {
        'username': username,
        'password': pass,
      });
      return UserAuth(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserAuth?> singupWithPass(NewUserDTO newUser, String lang) async {
    try {
      dynamic response = await http.post('/signup?lang=$lang',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(newUser.toMap()));
      return UserAuth(response);
    } catch (e) {
      rethrow;
    }
  }
}
