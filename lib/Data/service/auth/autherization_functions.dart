import 'dart:convert';

// import 'package:admin/application/Presentation/screens/LoginScreen/login_screen.dart';
// import 'package:admin/application/Widgets/BottomNavigationWidget/root_page.dart';
// import 'package:admin/Data/service/auth/config.dart';
import 'package:admin/data/service/auth/config.dart';
import 'package:admin/domain/models/login_response_model/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../application/presentation/screens/login_screen/login_screen.dart';
import '../../../application/widgets/bottom_navigation_widget/root_page.dart';

String globalToken = "";
String loginMessage = "";

class AuthService {
  Future<void> loginUser(BuildContext context) async {
    try {
      if (emailComtroller.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
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

          if (loginResponse.status) {
            String? authToken = loginResponse.token;
            saveAuthToken(authToken!);
            globalToken = (await getAuthToken())!;
            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const RootPage()));
            }
          } else {
            if (context.mounted) {
              showSnackBar(context, loginResponse.message);
            }
          }
        } else {
          if (context.mounted) {
            showSnackBar(
                context, 'An error occurred during login. Please try again.');
          }
        }
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, 'An unexpected error occurred during login');
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    await clearAuthToken();
    if (context.mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
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

Future<void> clearAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth_token");
}
