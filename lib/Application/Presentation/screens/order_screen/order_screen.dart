// import 'package:admin/application/Presentation/screens/order_screen/widgets/appbar_widget.dart';
import 'package:admin/application/business_logic/orders/bloc/bloc/orders_bloc.dart';
// import 'package:admin/application/Presentation/screens/Order%20Screen/widgets/appbar_widget.dart';
// import 'package:admin/application/Presentation/screens/order_detail_screen/order_detail_screen.dart';
// import 'package:admin/application/Presentation/utils/colors.dart';
// import 'package:admin/application/Presentation/utils/constants.dart';
// import 'package:admin/Data/service/order/order_functions.dart';
// import 'package:admin/Data/service/product/config.dart';
// import 'package:admin/Domain/models/order/get_order_model.dart';
import 'package:admin/application/presentation/screens/order_detail_screen/order_detail_screen.dart';
import 'package:admin/application/presentation/screens/order_screen/widgets/appbar_widget.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/application/presentation/utils/constants.dart';
import 'package:admin/data/service/order/order_functions.dart';
import 'package:admin/data/service/product/config.dart';
import 'package:admin/domain/models/order/get_order_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderService orderService = OrderService();
  late OrdersBloc ordersBloc;

  @override
  void initState() {
    super.initState();
    ordersBloc = context.read<OrdersBloc>();
    ordersBloc.add(FetchOrdersEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ordersBloc = context.read<OrdersBloc>();
    ordersBloc.add(FetchOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: const AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            kHeight30,
            BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state is LoadingOrdersState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedOrderState) {
                  List<GetOrderModel> orders = state.orders;

                  return Expanded(
                    child: ListView.separated(
                      itemCount: orders.length,
                      separatorBuilder: (context, index) => kHeight10,
                      itemBuilder: (context, index) {
                        String imageFileName = orders[index].images[0];
                        String imageUrl = '$productUrl/$imageFileName';
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        id: orders[index].id,
                                        index: index,
                                      ))),
                          child: Container(
                            height: 230,
                            width: 370,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      kWidth10,
                                      SizedBox(
                                        height: 150,
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(orders[index].userName),
                                            kHeight10,
                                            Expanded(
                                              child: Text(orders[index].email),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(orders[index].mobile),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_right_outlined))
                                              ],
                                            ),
                                            Text(orders[index].productName),
                                            kHeight10,
                                            Text(
                                                'TotalPrice: ₹${orders[index].totalPrice}')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  kHeight10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            'payment method: ${orders[index].paymentMethod}'),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: kGreen,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            orders[index].currentStatus,
                                            style:
                                                const TextStyle(color: kWhite),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ErrorOrderState) {
                  return const Center(child: Text('Error Fetching Orders'));
                } else {
                  return const Center(child: Text('Unexpected Error occured'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
