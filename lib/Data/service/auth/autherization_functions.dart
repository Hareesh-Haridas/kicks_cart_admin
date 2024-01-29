import 'dart:convert';

import 'package:admin/Application/Presentation/screens/LoginScreen/login_screen.dart';
import 'package:admin/Application/Widgets/BottomNavigationWidget/root_page.dart';
import 'package:admin/Data/service/auth/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String loginMessage = "";
Future<void> loginUser(BuildContext context) async {
  if (emailComtroller.text.isNotEmpty && passwordController.text.isNotEmpty) {
    var regBody = {
      "email": emailComtroller.text,
      "password": passwordController.text
    };
    var response = await http.post(Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    var jsonResponse = jsonDecode(response.body);
    bool statusMessage = jsonResponse['status'] ?? false;
    loginMessage = jsonResponse['message'];
    if (statusMessage) {
      String authToken = jsonResponse['token'];
      saveAuthToken(authToken);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RootPage()));
    } else {
      showSnackBar(context, loginMessage);
    }
    print(jsonResponse);
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<void> saveAuthToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth_token", token);
}

Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token");
}

Future<void> logOut(BuildContext context) async {
  await clearAuthToken();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

Future<void> clearAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth_token");
}
