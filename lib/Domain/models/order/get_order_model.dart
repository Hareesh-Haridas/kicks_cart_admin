class GetOrderModel {
  final List<dynamic> images;
  final String productName;

  GetOrderModel({
    required this.images,
    required this.productName,
  });
  factory GetOrderModel.fromJson(Map<String, dynamic> json) {
    return GetOrderModel(
      images: json['image'] != null ? List.from(json['image']) : [],
      productName: json['name'] ?? "",
    );
  }
}

class GetOrderProductModel {
  final String userName;
  final String email;
  final int totalPrice;
  final String paymentMethod;
  final String currentStatus;

  GetOrderProductModel(
      {required this.userName,
      required this.email,
      required this.totalPrice,
      required this.paymentMethod,
      required this.currentStatus});
  factory GetOrderProductModel.fromJson(Map<String, dynamic> json) {
    return GetOrderProductModel(
        userName: json['userName'] ?? "",
        email: json['email'] ?? "",
        totalPrice: json['totalPrice'] ?? 0,
        paymentMethod: json['paymentMethod'] ?? "",
        currentStatus: json['curentStatus'] ?? "");
  }
}
