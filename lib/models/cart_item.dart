// lib/models/cart_item.dart
import 'package:untitled1/models/product.dart';

class CartItem {
  final Product product;
  int quantity; // الكمية قابلة للتغيير

  CartItem({required this.product, this.quantity = 1});
}
