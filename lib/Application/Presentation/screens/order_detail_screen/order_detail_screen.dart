import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/order/order_functions.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<String> statusOptions = [
    'Pending',
    'Shipped',
    'Delivered',
    'Cancelled',
    'Returned'
  ];
  String? selectedStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              kHeight10,
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    'Order Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              kHeight30,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Current Status: '),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        color: kGreen, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Pending',
                        style: TextStyle(color: kWhite),
                      ),
                    ),
                  )
                ],
              ),
              kHeight20,
              Container(
                height: 150,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      kHeight10,
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(border: Border.all()),
                          ),
                          kWidth10,
                          Container(
                            height: 120,
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Product Name'),
                                kHeight10,
                                Text('Quantity: 1'),
                                kHeight10,
                                Text('Payment Method: COD'),
                                kHeight10,
                                Text('Amount: ₹5000')
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              kHeight10,
              Row(
                children: [Text('Update Status')],
              ),
              kHeight10,
              Row(
                children: [
                  DropdownButton<String>(
                      value: selectedStatus,
                      items: statusOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      hint: Text('Select order Status'),
                      onChanged: (String? newValue) async {
                        OrderService orderService = OrderService();
                        orderService.changeStatus(newValue!, context);
                        setState(() {
                          selectedStatus = newValue;
                        });
                      })
                ],
              ),
              Divider(),
              kHeight20,
              Row(
                children: [
                  Text('User Details'),
                ],
              ),
              kHeight10,
              Row(
                children: [Text('User Name')],
              )
            ],
          ),
        ),
      ),
    );
  }
}
