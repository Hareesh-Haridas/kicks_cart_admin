import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/product/config.dart';
import 'package:admin/Data/service/product/product_functions.dart';
import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  // final dynamic image1;
  // final dynamic image2;
  // final dynamic image3;
  // final dynamic image4;
  // final String name;
  // final int price;
  // final String description;
  // final int stock;
  // final String category;
  final String productId;
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

late Future<GetProductModel> productDetailFuture;
List<dynamic> images = [];
late GetProductModel fetchDetails;

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    ProductService productService = ProductService();
    productDetailFuture = productService.fetchProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: FutureBuilder(
          future: productDetailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              GetProductModel productModel = snapshot.data!;
              return Column(
                children: [
                  kHeight50,
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15)),
                        Container(
                          height: 100,
                          width: 300,
                          decoration:
                              BoxDecoration(border: Border.all(color: kGrey)),
                          child: Image.network(
                              '$productUrl/${productModel.images[0]}'),
                        ),
                        kWidth10,
                        Container(
                          height: 100,
                          width: 300,
                          decoration:
                              BoxDecoration(border: Border.all(color: kGrey)),
                          child: Image.network(
                              '$productUrl/${productModel.images[1]}'),
                        ),
                        kWidth10,
                        Container(
                          height: 100,
                          width: 300,
                          decoration:
                              BoxDecoration(border: Border.all(color: kGrey)),
                          child: Image.network(
                              '$productUrl/${productModel.images[2]}'),
                        ),
                        kWidth10,
                        Container(
                          height: 100,
                          width: 300,
                          decoration:
                              BoxDecoration(border: Border.all(color: kGrey)),
                          child: Image.network(
                              '$productUrl/${productModel.images[3]}'),
                        )
                      ],
                    ),
                  ),
                  kHeight30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        kWidth30,
                        Text(
                          productModel.name,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                  kHeight30,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        kWidth30,
                        Text(
                          productModel.price.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  kHeight20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        kWidth30,
                        Text(
                          'Product Description',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                  kHeight20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        kWidth30,
                        Expanded(
                          child: Text(
                            productModel.description,
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  kHeight20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        kWidth30,
                        Text(
                          'Stock :',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(productModel.stock.toString())
                      ],
                    ),
                  ),
                  kHeight20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        kWidth30,
                        Text(
                          'Category :',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(productModel.category)
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
