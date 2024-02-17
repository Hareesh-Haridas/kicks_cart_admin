import 'package:admin/Application/Business%20logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/edit_screen.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/kicks_kart_text_widget.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/name_and_logout_widget.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/product_list.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/search_widget.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:admin/Data/service/product/config.dart';
import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';
import 'package:admin/Domain/models/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductBloc products;
  @override
  void initState() {
    super.initState();
    products = context.read<ProductBloc>();
    products.add(FetchProductsEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    products = context.read<ProductBloc>();
    products.add(FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight30,
              const NameAndLogoutButton(),
              kHeight20,
              const SearchWidget(),
              kHeight20,
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is LoadingProductState) {
                    return const CircularProgressIndicator();
                  } else if (state is LoadededProductState) {
                    List<GetProductModel>? products = state.products;
                    if (products.isEmpty) {
                      return const Text('No Products Available');
                    } else {
                      return GridView.builder(
                        itemCount: products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.75),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          print(products[index].images[0]);
                                        },
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EditProductScreen()));
                                          },
                                          icon: const Icon(Icons.edit))
                                    ],
                                  ),
                                  Image.network(
                                    'http://192.168.137.1:3000/admin/17077948160521000133183.jpg',
                                    fit: BoxFit.cover,
                                    height: 90,
                                    width: 150,
                                  ),
                                  Text(
                                    products[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18),
                                  ),
                                  kHeight10,
                                  Text(
                                    products[index].price.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else if (state is ErrorProductState) {
                    return Text('Error ${state.error}');
                  } else {
                    return const Text('Unknown Error');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
// GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemCount: productData.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, childAspectRatio: 0.75),
//                 itemBuilder: (_, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 300,
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.delete_outlined,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const EditProductScreen()));
//                                   },
//                                   icon: const Icon(Icons.edit))
//                             ],
//                           ),
//                           Image.asset(
//                             productData[index]['image']!,
//                             fit: BoxFit.cover,
//                             height: 90,
//                             width: 150,
//                           ),
//                           Text(
//                             productData[index]['name']!,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w300, fontSize: 18),
//                           ),
//                           kHeight10,
//                           Row(
//                             children: [
//                               kWidth10,
//                               Text(
//                                 productData[index]['price']!,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )