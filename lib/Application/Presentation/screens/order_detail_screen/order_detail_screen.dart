// import 'package:admin/application/Presentation/utils/colors.dart';
// import 'package:admin/application/Presentation/utils/constants.dart';
// import 'package:admin/Data/service/order/order_functions.dart';
import 'package:admin/application/business_logic/orders/bloc/bloc/orders_bloc.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/application/presentation/utils/constants.dart';
import 'package:admin/data/service/order/order_functions.dart';
import 'package:admin/data/service/product/config.dart';
import 'package:admin/domain/models/order/get_all_orders_model.dart';
import 'package:admin/domain/models/order/get_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailScreen extends StatefulWidget {
  final String id;
  final int index;
  const OrderDetailScreen({super.key, required this.id, required this.index});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrdersBloc ordersBloc;
  OrderService orderService = OrderService();
  List<String> statusOptions = [
    'Pending',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];
  String? selectedStatus;
  @override
  void initState() {
    super.initState();
    // ordersBloc = context.read<OrdersBloc>();
    // ordersBloc.add(FetchOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
            future: orderService.getAllOrders(widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error Fetching orders'));
              } else {
                List<GetAllOrderModel> orders = snapshot.data!;
                print('order length: ${orders.length}');
                String currentStatus = orders[widget.index].currentStatus;
                print('Current Status : $currentStatus');
                return Column(
                  children: [
                    kHeight10,
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        const Text(
                          'Order Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    kHeight30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Current Status: '),
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: kGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // child: Center(
                          //   child: BlocBuilder<OrdersBloc, OrdersState>(
                          //     builder: (context, state) {
                          //       if (state is LoadingOrdersState) {
                          //         return const CircularProgressIndicator();
                          //       } else if (state is LoadedOrderState) {
                          //         List<GetOrderModel> orders = state.orders;
                          //         return Text(
                          //           orders[widget.index].currentStatus,
                          //           style: const TextStyle(color: kWhite),
                          //         );
                          //       } else if (state is ErrorOrderState) {
                          //         return const Text('Error Fetching status');
                          //       } else {
                          //         return const Text('Unknown error');
                          //       }
                          //     },
                          //   ),
                          // ),
                          child: Center(
                            child: Text(
                              currentStatus,
                              style: const TextStyle(color: kWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHeight20,
                    Expanded(
                      child: ListView.builder(
                        itemCount: orders.length - 1,
                        itemBuilder: (context, index) {
                          String imageFileName = orders[index].images[0];

                          String imageUrl = '$productUrl/$imageFileName';
                          return Container(
                            decoration: BoxDecoration(border: Border.all()),
                            height: 150,
                            width: 400,
                            child: Column(
                              children: [
                                kHeight10,
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Image.network(imageUrl),
                                    ),
                                    kWidth10,
                                    SizedBox(
                                      height: 120,
                                      width: 180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(orders[index].productName),

                                          kHeight10,
                                          // Expanded(
                                          //   child: Text(
                                          //       'Payment Method: ${orders[index].paymentMethod}'),
                                          // ),

                                          Text(
                                              'Amount: ₹${orders[index].totalPrice}'),
                                          Text('Size: ${orders[index].size}'),
                                          Text(
                                              'Quanity: ${orders[index].quantity}')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    kHeight10,
                    const Row(
                      children: [Text('Update Status')],
                    ),
                    kHeight10,
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedStatus,
                          items: statusOptions.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          hint: const Text('Select order Status'),
                          onChanged: (String? newValue) async {
                            OrderService orderService = OrderService();
                            await orderService
                                .changeStatus(newValue!, context, widget.id)
                                .whenComplete(() => context
                                    .read<OrdersBloc>()
                                    .add(FetchOrdersEvent()));
                            setState(() {
                              currentStatus = newValue;
                            });
                            // setState(() {
                            //   selectedStatus = newValue;
                            // });
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    // kHeight20,
                    Row(
                      children: [
                        BlocBuilder<OrdersBloc, OrdersState>(
                          builder: (context, state) {
                            if (state is LoadingOrdersState) {
                              return const Text('Loading...');
                            } else if (state is LoadedOrderState) {
                              List<GetOrderModel> orders = state.orders;
                              return Text(
                                  'User Name: ${orders[widget.index].userName}');
                            } else {
                              return const Text('User NaUnknown error');
                            }
                          },
                        ),
                      ],
                    ),
                    // kHeight10,
                    // const Row(
                    //   children: [Text('User Name')],
                    // ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
