// import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/data/service/auth/autherization_functions.dart';
// import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailComtroller = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.none,
                  controller: emailComtroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'e-mail'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains("@") ||
                        !value.contains('gmail.com')) {
                      return 'Please enter a valid e-mail';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey[900]),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  AuthService authService = AuthService();
                                  await authService
                                      .loginUser(context)
                                      .whenComplete(() {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
