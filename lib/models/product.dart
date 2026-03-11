// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  // هذه الدالة قد تكون مفيدة إذا كنت تحتاج لتحويل المنتج إلى JSON أو من JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'imageUrl': imageUrl, 'price': price};
  }
}
