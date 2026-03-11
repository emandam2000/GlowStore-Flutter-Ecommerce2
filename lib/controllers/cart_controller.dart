// lib/controllers/cart_controller.dart
import 'package:get/get.dart'; // استيراد حزمة GetX
import 'package:untitled1/models/product.dart'; // تأكد من وجود هذا الملف
import 'package:untitled1/models/cart_item.dart'; // تأكد من وجود هذا الملف

/// CartController: مسؤول عن إدارة حالة سلة التسوق باستخدام GetX.
/// يرث من GetxController لتمكين إدارة الحالة التفاعلية.
class CartController extends GetxController {
  // 'RxList' يجعل القائمة تفاعلية، أي أن أي تغيير فيها سيؤدي إلى تحديث الـ Widgets التي تستمع.
  final RxList<CartItem> _items = <CartItem>[].obs;

  // توفير وصول للقراءة فقط إلى عناصر السلة.
  List<CartItem> get items => _items.toList();

  // حساب إجمالي عدد العناصر في السلة.
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // حساب إجمالي سعر المنتجات في السلة.
  double get totalPrice => _items.fold(
    0.0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  /// إضافة منتج إلى السلة أو زيادة كميته إذا كان موجودًا بالفعل.
  void addProductToCart(Product product) {
    // التحقق مما إذا كان المنتج موجودًا بالفعل في السلة.
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      // إذا كان المنتج موجودًا، زيادة الكمية.
      _items[index].quantity++;
    } else {
      // إذا لم يكن المنتج موجودًا، إضافة عنصر جديد.
      _items.add(CartItem(product: product, quantity: 1));
    }
    // تحديث الواجهة تلقائياً بفضل RxList.
    // لا حاجة لـ update() هنا لأن RxList يعالج ذلك تلقائياً مع Obx.
  }

  /// إزالة منتج من السلة بالكامل.
  void removeProductFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    // لا حاجة لـ update() هنا لأن RxList يعالج ذلك تلقائياً مع Obx.
  }

  /// زيادة كمية منتج معين في السلة.
  void increaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
      // لا حاجة لـ update() هنا لأن RxList يعالج ذلك تلقائياً مع Obx.
    }
  }

  /// تقليل كمية منتج معين في السلة.
  void decreaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        // إذا كانت الكمية 1، إزالة المنتج تمامًا.
        _items.removeAt(index);
      }
      // لا حاجة لـ update() هنا لأن RxList يعالج ذلك تلقائياً مع Obx.
    }
  }

  /// مسح جميع المنتجات من السلة.
  void clearCart() {
    _items.clear();
    // لا حاجة لـ update() هنا لأن RxList يعالج ذلك تلقائياً مع Obx.
  }
}