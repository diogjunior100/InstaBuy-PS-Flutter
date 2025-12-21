class ProductModel {
  final String name;
  final double price;
  final String? imageUrl;

  const ProductModel({
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'],
    );
  } 
}

