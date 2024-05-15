class GetAllOrderModel {
  final List<dynamic> images;
  final String productName;
  final String id;
  final String userName;
  final String email;
  final int totalPrice;
  final String paymentMethod;
  final String currentStatus;
  final String mobile;
  final String size;
  final int quantity;
  GetAllOrderModel(
      {required this.images,
      required this.productName,
      required this.id,
      required this.userName,
      required this.email,
      required this.totalPrice,
      required this.paymentMethod,
      required this.currentStatus,
      required this.mobile,
      required this.size,
      required this.quantity});
  factory GetAllOrderModel.fromJson(Map<String, dynamic> json, String id) {
    return GetAllOrderModel(
        images: json['image'] != null ? List.from(json['image']) : [],
        productName: json['name'] ?? "",
        id: id,
        userName: json['userName'] ?? '',
        email: json['email'] ?? '',
        totalPrice: json['price'] ?? 0,
        paymentMethod: json['paymentMethod'] ?? '',
        currentStatus: json['status'] ?? '',
        mobile: json['mobile'] ?? '',
        size: json['size'] ?? '',
        quantity: json['quantity'] ?? 0);
  }
}
