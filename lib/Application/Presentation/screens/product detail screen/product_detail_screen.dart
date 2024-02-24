import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic image1;
  final dynamic image2;
  final dynamic image3;
  final dynamic image4;
  final String name;
  final int price;
  final String description;
  final int stock;
  final String category;
  const ProductDetailScreen(
      {super.key,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      required this.name,
      required this.price,
      required this.description,
      required this.stock,
      required this.category});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

List<dynamic> images = [];

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    images.add(widget.image1);
    images.add(widget.image2);
    images.add(widget.image3);
    images.add(widget.image4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            kHeight50,
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(border: Border.all(color: kGrey)),
                    child: Image.network(images[0]),
                  ),
                  kWidth10,
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(border: Border.all(color: kGrey)),
                    child: Image.network(images[1]),
                  ),
                  kWidth10,
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(border: Border.all(color: kGrey)),
                    child: Image.network(images[2]),
                  ),
                  kWidth10,
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(border: Border.all(color: kGrey)),
                    child: Image.network(images[3]),
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
                    widget.name,
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
                    widget.price.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
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
                      widget.description,
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.stock.toString())
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.category)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
