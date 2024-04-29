class GetOrderModel {
  final List<dynamic> images;
  final String productName;
  final String id;
  final String userName;
  final String email;
  final int totalPrice;
  final String paymentMethod;
  final String currentStatus;
  final String mobile;

  GetOrderModel(
      {required this.images,
      required this.productName,
      required this.id,
      required this.currentStatus,
      required this.email,
      required this.paymentMethod,
      required this.totalPrice,
      required this.userName,
      required this.mobile});
  factory GetOrderModel.fromJson(
      Map<String, dynamic> json,
      String userName,
      String email,
      int totalPrice,
      String paymentMethod,
      String currentStatus,
      String mobile,
      String id) {
    return GetOrderModel(
        images: json['image'] != null ? List.from(json['image']) : [],
        productName: json['name'] ?? "",
        id: id,
        userName: userName,
        email: email,
        totalPrice: totalPrice,
        paymentMethod: paymentMethod,
        currentStatus: currentStatus,
        mobile: mobile);
  }
}

// class GetOrderProductModel {
//   final String userName;
//   final String email;
//   final int totalPrice;
//   final String paymentMethod;
//   final String currentStatus;

//   GetOrderProductModel(
//       {required this.userName,
//       required this.email,
//       required this.totalPrice,
//       required this.paymentMethod,
//       required this.currentStatus});
//   factory GetOrderProductModel.fromJson(Map<String, dynamic> json) {
//     return GetOrderProductModel(
//         userName: json['userName'] ?? "",
//         email: json['email'] ?? "",
//         totalPrice: json['totalPrice'] ?? 0,
//         paymentMethod: json['paymentMethod'] ?? "",
//         currentStatus: json['curentStatus'] ?? "");
//   }
// }
