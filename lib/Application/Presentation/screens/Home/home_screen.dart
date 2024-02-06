import 'package:admin/Application/Presentation/screens/Edit%20screen/edit_screen.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/kicks_kart_text_widget.dart';
import 'package:admin/Application/Presentation/screens/Home/widgets/product_list.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight30,
              Row(
                children: [
                  const KicksCartText(),
                  const SizedBox(
                    width: 150,
                  ),
                  IconButton(
                      onPressed: () {
                        logOut(context);
                      },
                      icon: const Icon(Icons.logout)),
                ],
              ),
              kHeight20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(115),
                    ),
                    hintText: 'Search Product',
                  ),
                ),
              ),
              kHeight20,
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: productData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.75),
                  itemBuilder: (_, int index) {
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
                                  onPressed: () {},
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
                            Image.asset(
                              productData[index]['image']!,
                              fit: BoxFit.cover,
                              height: 90,
                              width: 150,
                            ),
                            Text(
                              productData[index]['name']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 18),
                            ),
                            kHeight10,
                            Row(
                              children: [
                                kWidth10,
                                Text(
                                  productData[index]['price']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
