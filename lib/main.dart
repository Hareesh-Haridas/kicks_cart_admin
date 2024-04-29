// import 'package:admin/Application/business_logic/bottom_nav/bloc/bottom_navigation_bloc.dart';
// import 'package:admin/Application/business_logic/category/bloc/bloc/category_bloc.dart';
// import 'package:admin/Application/business_logic/product/bloc/bloc/product_bloc.dart';
// import 'package:admin/Application/business_logic/orders/bloc/bloc/orders_bloc.dart';
// import 'package:admin/Application/business_logic/order_product/bloc/order_product_bloc.dart';
// import 'package:admin/Application/Presentation/screens/login_screen/login_screen.dart';
// import 'package:admin/Application/Presentation/screens/add_category_screen/add_category_screen.dart';
import 'package:admin/application/business_logic/bottom_nav/bloc/bottom_navigation_bloc.dart';
import 'package:admin/application/business_logic/category/bloc/bloc/category_bloc.dart';
import 'package:admin/application/business_logic/orders/bloc/bloc/orders_bloc.dart';
import 'package:admin/application/business_logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/application/presentation/screens/add_category_screen/add_category_screen.dart';
import 'package:admin/application/presentation/screens/login_screen/login_screen.dart';
import 'package:admin/application/widgets/bottom_navigation_widget/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationBloc>(
              create: (context) => BottomNavigationBloc()),
          BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
          BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
          BlocProvider<OrdersBloc>(create: (context) => OrdersBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme:
                  GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
          home: initialScreen,
        ));
  }
}
