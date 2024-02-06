import 'package:admin/Application/Business%20logic/Bottom%20Nav/bloc/bottom_navigation_bloc.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/product_add_screen.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/edit_screen.dart';
import 'package:admin/Application/Presentation/screens/Home/home_screen.dart';
import 'package:admin/Application/Presentation/screens/LoginScreen/login_screen.dart';
import 'package:admin/Application/Presentation/screens/add%20category%20screen/add_category_screen.dart';
import 'package:admin/Application/Widgets/BottomNavigationWidget/root_page.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? authToken = await getAuthToken();
  Widget initialScreen =
      authToken != null ? const RootPage() : const LoginScreen();
  runApp(MyApp(
    initialScreen: initialScreen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialScreen});
  final Widget initialScreen;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavigationBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme:
                  GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
          home: initialScreen,
        ));
  }
}
