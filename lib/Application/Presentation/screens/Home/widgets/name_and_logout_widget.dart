// import 'package:admin/application/Presentation/screens/Home/widgets/kicks_kart_text_widget.dart';
// import 'package:admin/Data/service/auth/autherization_functions.dart';
// import 'package:admin/application/presentation/screens/home/widgets/kicks_kart_text_widget.dart';
import 'package:admin/application/presentation/screens/home/widgets/kicks_kart_text_widget.dart';
import 'package:admin/data/service/auth/autherization_functions.dart';
import 'package:flutter/material.dart';

class NameAndLogoutButton extends StatelessWidget {
  const NameAndLogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const KicksCartText(),
          IconButton(
              onPressed: () {
                AuthService authService = AuthService();
                authService.logOut(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
