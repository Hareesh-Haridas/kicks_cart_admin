import 'dart:convert';

import 'package:admin/Application/Presentation/screens/LoginScreen/login_screen.dart';
import 'package:admin/Application/Widgets/BottomNavigationWidget/root_page.dart';
import 'package:admin/Data/service/auth/config.dart';
import 'package:admin/Domain/models/login%20response%20model/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String globalToken = "";
String loginMessage = "";
Future<void> loginUser(BuildContext context) async {
  try {
    if (emailComtroller.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailComtroller.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(loginUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse);
        // bool statusMessage = jsonResponse['status'] ?? false;
        print(loginResponse.status);
        print(loginResponse.message);
        // loginMessage = jsonResponse['message'] ?? "";
        // print(loginMessage);
        if (loginResponse.status) {
          String? authToken = loginResponse.token;
          saveAuthToken(authToken!);
          globalToken = (await getAuthToken())!;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RootPage()));
        } else {
          showSnackBar(context, loginResponse.message);
        }
        // print(jsonResponse);
      } else {
        print('HTTP Status Code: ${response.statusCode}');
        showSnackBar(
            context, 'An error occurred during login. Please try again.');
      }
    }
  } catch (error) {
    print('Error during login: $error');
    showSnackBar(context, 'An unexpected error occurred during login');
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
