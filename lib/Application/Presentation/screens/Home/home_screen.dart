import 'package:admin/Application/Business%20logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/edit_screen.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/kicks_kart_text_widget.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/name_and_logout_widget.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/product_list.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/search_widget.dart';
import 'package:admin/Application/Presentation/screens/product%20detail%20screen/product_detail_screen.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:admin/Data/service/product/config.dart';
import 'package:admin/Data/service/product/product_functions.dart';
import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';
import 'package:admin/Domain/models/product/add%20product%20model/product_model.dart';
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
    products.add(SearchProductsEvent(query: ''));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    products = context.read<ProductBloc>();
    products.add(FetchProductsEvent());
    products.add(SearchProductsEvent(query: ''));
  }

  @override
  Widget build(BuildContext context) {
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
                            String image1 = products[index].images[0];
                            String image2 = products[index].images[1];
                            String image3 = products[index].images[2];
                            String image4 = products[index].images[3];
                            print(imageFileName);
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
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        title: const Text(
                                                            'Delete Product'),
                                                        content: const Text(
                                                            'Are You Sure You Want To Delete This Product?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                print(products[
                                                                        index]
                                                                    .id);
                                                                await deleteProduct(
                                                                        products[index]
                                                                            .id,
                                                                        context)
                                                                    .whenComplete(() => context
                                                                        .read<
                                                                            ProductBloc>()
                                                                        .add(
                                                                            FetchProductsEvent()));
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Delete"))
                                                        ],
                                                      ));
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
                            print(imageFileName);
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
                                          IconButton(
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        title: const Text(
                                                            'Delete Product'),
                                                        content: const Text(
                                                            'Are You Sure You Want To Delete This Product?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                print(searchResults[
                                                                        index]
                                                                    .id);
                                                                await deleteProduct(
                                                                        searchResults[index]
                                                                            .id,
                                                                        context)
                                                                    .whenComplete(() => context
                                                                        .read<
                                                                            ProductBloc>()
                                                                        .add(
                                                                            FetchProductsEvent()));
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Delete"))
                                                        ],
                                                      ));
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
