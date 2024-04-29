// import 'package:admin/application/Presentation/utils/colors.dart';
// import 'package:admin/Data/service/auth/autherization_functions.dart';
// import 'package:admin/Data/service/order/config.dart';
// import 'package:admin/Domain/models/order/get_order_model.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/data/service/auth/autherization_functions.dart';
import 'package:admin/data/service/order/config.dart';
import 'package:admin/domain/models/order/get_all_orders_model.dart';
import 'package:admin/domain/models/order/get_order_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderService {
  Future<List<GetOrderModel>> getOrders() async {
    String? orderToken = await getAuthToken();
    try {
      final response = await Dio().get(getOrderUrl,
          options: Options(headers: {'Authorization': '$orderToken'}));

      List<dynamic> responseData = response.data['data'];
      List<GetOrderModel> results = [];
      for (var data in responseData) {
        var id = data["_id"] ?? '';

        String userName = data['userName'] ?? '';
        String email = data['email'] ?? '';
        int totalPrice = data['totalPrice'] ?? 0;
        String paymentMethod = data['paymentMethod'] ?? '';
        String currentStatus = data['curentStatus'] ?? '';
        String mobile = data['mobile'] ?? '';
        if (data.containsKey('products') && data['products'] is List) {
          List<dynamic> productData = data['products'];
          for (var product in productData) {
            GetOrderModel orderModel = GetOrderModel.fromJson(product, userName,
                email, totalPrice, paymentMethod, currentStatus, mobile, id);
            results.add(orderModel);
          }
        }
      }
      return results;
    } catch (e) {
      return [];
    }
  }

  Future<List<GetAllOrderModel>> getAllOrders(String id) async {
    String? orderToken = await getAuthToken();
    try {
      final response = await Dio().get('$getOrderDetailsUrl/$id',
          options: Options(headers: {'Authorization': '$orderToken'}));
      print(response.data);

      List<GetAllOrderModel> orders = (response.data['data'] as List)
          .map((json) => GetAllOrderModel.fromJson(json, id))
          .toList();
      return orders;
    } catch (e) {
      debugPrint('Error Fetching orders $e');
      return [];
    }
  }

  Future<void> changeStatus(
      String status, BuildContext context, String id) async {
    String? orderToken = await getAuthToken();
    var data = {'orderStatus': status, 'id': id};
    try {
      final response = await Dio().post(changeOrderStatusUrl,
          options: Options(headers: {'Authorization': '$orderToken'}),
          data: data);
      String orderMessage = response.data['message'];
      if (context.mounted) {
        orderShowSnackBar(context, orderMessage);
      }
    } catch (e) {
      debugPrint('Error Updating Status $e');
    }
  }
}

void orderShowSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: kWhite),
    ),
  ));
}
