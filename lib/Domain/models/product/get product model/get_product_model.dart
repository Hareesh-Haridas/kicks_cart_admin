class GetProductModel {
  final String id;
  final List<dynamic> images;
  final String name;
  final int price;
  final String description;
  final int stock;
  final String category;

  GetProductModel(
      {required this.id,
      required this.images,
      required this.name,
      required this.price,
      required this.description,
      required this.stock,
      required this.category});
  factory GetProductModel.fromJson(Map<String, dynamic> json) {
    return GetProductModel(
        id: json['id'] ?? "",
        images: json['image'] ?? "",
        name: json['name'] ?? "",
        price: json['price'] ?? 0,
        description: json['description'] ?? "",
        stock: json['stock'] ?? 0,
        category: json['category'] ?? "");
  }
}
