// import 'package:admin/Application/Business%20logic/product/bloc/bloc/product_bloc.dart';

// import 'package:admin/application/Presentation/screens/Home/widgets/name_and_logout_widget.dart';

// import 'package:admin/application/Presentation/screens/Home/widgets/search_widget.dart';
// import 'package:admin/application/Presentation/screens/product_detail_screen/product_detail_screen.dart';
// import 'package:admin/application/Presentation/utils/colors.dart';
// import 'package:admin/application/Presentation/utils/constants.dart';

// import 'package:admin/Data/service/product/config.dart';
import 'package:admin/application/business_logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/edit_screen.dart';
import 'package:admin/application/presentation/screens/home/widgets/name_and_logout_widget.dart';
import 'package:admin/application/presentation/screens/home/widgets/search_widget.dart';
import 'package:admin/application/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/application/presentation/utils/constants.dart';
import 'package:admin/data/service/product/config.dart';
import 'package:admin/data/service/product/product_functions.dart';
import 'package:admin/domain/models/product/get_product_model/get_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../business_logic/product/bloc/bloc/product_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductService productService = ProductService();
  late ProductBloc products;
  @override
  void initState() {
    super.initState();
    products = context.read<ProductBloc>();
    products.add(FetchProductsEvent());
    // products.add(SearchProductsEvent(query: ''));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    products = context.read<ProductBloc>();
    products.add(FetchProductsEvent());
    // products.add(SearchProductsEvent(query: ''));
  }

  @override
  Widget build(BuildContext context) {
    // products.add(FetchProductsEvent());
    // products.add(SearchProductsEvent(query: ''));
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                kHeight30,
                const NameAndLogoutButton(),
                kHeight20,
                SearchWidget(
                    onSearch: (query) {
                      products.add(SearchProductsEvent(query: query));
                    },
                    context: context),
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
                            String imageFileName = products[index].images[0];

                            String imageUrl = '$productUrl/$imageFileName';

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                            productId: products[index].id,
                                          )));
                                },
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => AlertDialog(
                                                          title: const Text(
                                                              'Block/Unblocl Product'),
                                                          content: const Text(
                                                              'Are you sure you want to update product status?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    'Cancel')),
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await productService
                                                                      .changeProductStatus(
                                                                          products[index]
                                                                              .id,
                                                                          context)
                                                                      .whenComplete(
                                                                          () {
                                                                    context
                                                                        .read<
                                                                            ProductBloc>()
                                                                        .add(
                                                                            FetchProductsEvent());
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    'Update'))
                                                          ],
                                                        ));
                                              },
                                              child: products[index].blocked ==
                                                      true
                                                  ? const Text(
                                                      'Unblock',
                                                      style: TextStyle(
                                                          color: kGreen),
                                                    )
                                                  : const Text(
                                                      'Block',
                                                      style: TextStyle(
                                                          color: kRed),
                                                    )),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProductScreen(
                                                              category:
                                                                  products[
                                                                          index]
                                                                      .category,
                                                              description:
                                                                  products[
                                                                          index]
                                                                      .description,
                                                              name: products[
                                                                      index]
                                                                  .name,
                                                              price: products[
                                                                      index]
                                                                  .price,
                                                              stock: products[
                                                                      index]
                                                                  .stock,
                                                              image1:
                                                                  '$productUrl/${products[index].images[0]}',
                                                              image2:
                                                                  '$productUrl/${products[index].images[1]}',
                                                              image3:
                                                                  '$productUrl/${products[index].images[2]}',
                                                              image4:
                                                                  '$productUrl/${products[index].images[3]}',
                                                              id: products[
                                                                      index]
                                                                  .id,
                                                            )));
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: kBlue,
                                              ))
                                        ],
                                      ),
                                      Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        height: 90,
                                        width: 150,
                                      ),
                                      Expanded(
                                        child: Text(
                                          products[index].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15),
                                        ),
                                      ),
                                      // kHeight10,
                                      Expanded(
                                        child: Text(
                                          '₹${products[index].price.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is SearchProductsState) {
                      List<GetProductModel>? searchResults =
                          state.searchResults;
                      if (searchResults == null || searchResults.isEmpty) {
                        return const Text('No Search Results');
                      } else {
                        return GridView.builder(
                          itemCount: searchResults.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.75),
                          itemBuilder: (context, index) {
                            String imageFileName =
                                searchResults[index].images[0];
                            String image1 = searchResults[index].images[0];
                            String image2 = searchResults[index].images[1];
                            String image3 = searchResults[index].images[2];
                            String image4 = searchResults[index].images[3];

                            String imageUrl = '$productUrl/$imageFileName';
                            String firstImage = '$productUrl/$image1';
                            String secondImage = '$productUrl/$image2';
                            String thirdImage = '$productUrl/$image3';
                            String fourthImage = '$productUrl/$image4';
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                            productId: searchResults[index].id,
                                          )));
                                },
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // IconButton(
                                          //   onPressed: () async {
                                          //     showDialog(
                                          //         context: context,
                                          //         builder: (_) => AlertDialog(
                                          //               title: const Text(
                                          //                   'Delete Product'),
                                          //               content: const Text(
                                          //                   'Are You Sure You Want To Delete This Product?'),
                                          //               actions: [
                                          //                 TextButton(
                                          //                   onPressed: () {
                                          //                     Navigator.of(
                                          //                             context)
                                          //                         .pop();
                                          //                   },
                                          //                   child: const Text(
                                          //                       'Cancel'),
                                          //                 ),
                                          //                 TextButton(
                                          //                     onPressed:
                                          //                         () async {
                                          //                       ProductService
                                          //                           productService =
                                          //                           ProductService();
                                          //                       await productService
                                          //                           .deleteProduct(
                                          //                               searchResults[index]
                                          //                                   .id,
                                          //                               context)
                                          //                           .whenComplete(() => context
                                          //                               .read<
                                          //                                   ProductBloc>()
                                          //                               .add(
                                          //                                   FetchProductsEvent()));
                                          //                       if (context
                                          //                           .mounted) {
                                          //                         Navigator.of(
                                          //                                 context)
                                          //                             .pop();
                                          //                       }
                                          //                     },
                                          //                     child: const Text(
                                          //                         "Delete"))
                                          //               ],
                                          //             ));
                                          //   },
                                          //   icon: const Icon(
                                          //     Icons.delete_outlined,
                                          //     color: Colors.red,
                                          //   ),
                                          // ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProductScreen(
                                                              category:
                                                                  searchResults[
                                                                          index]
                                                                      .category,
                                                              description:
                                                                  searchResults[
                                                                          index]
                                                                      .description,
                                                              name:
                                                                  searchResults[
                                                                          index]
                                                                      .name,
                                                              price:
                                                                  searchResults[
                                                                          index]
                                                                      .price,
                                                              stock:
                                                                  searchResults[
                                                                          index]
                                                                      .stock,
                                                              image1:
                                                                  firstImage,
                                                              image2:
                                                                  secondImage,
                                                              image3:
                                                                  thirdImage,
                                                              image4:
                                                                  fourthImage,
                                                              id: searchResults[
                                                                      index]
                                                                  .id,
                                                            )));
                                              },
                                              icon: const Icon(Icons.edit))
                                        ],
                                      ),
                                      Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        height: 90,
                                        width: 150,
                                      ),
                                      Text(
                                        searchResults[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18),
                                      ),
                                      kHeight10,
                                      Text(
                                        searchResults[index].price.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is ErrorSearchProductState) {
                      return const Text('Failed to search products');
                    } else if (state is ErrorProductState) {
                      return const Text('Failed to Fetch products');
                    } else {
                      return const Text('Unknown Error');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
