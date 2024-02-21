class EditProductModel {
  final String id;
  final List<dynamic> images;
  final String name;
  final int price;
  final String description;
  final int stock;
  final String category;

  EditProductModel(
      {required this.id,
      required this.images,
      required this.name,
      required this.price,
      required this.description,
      required this.stock,
      required this.category});
  factory EditProductModel.fromJson(Map<String, dynamic> json) {
    return EditProductModel(
        id: json['_id'] != null ? json['_id'].toString() : "",
        images: json['image'] != null ? List.from(json['image']) : [],
        name: json['name'] ?? "",
        price: json['price'] ?? 0,
        description: json['description'] ?? "",
        stock: json['stock'] ?? 0,
        category: json['category'] ?? "");
  }
}
