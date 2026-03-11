// lib/screens/cart_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استيراد حزمة GetX
import 'package:untitled1/controllers/cart_controller.dart'; // استيراد CartController

/// صفحة سلة التسوق.
/// هذا الـ Widget هو StatelessWidget لأنه لا يدير حالته الخاصة.
/// بدلاً من ذلك، يستمع إلى التغييرات في CartController ويعيد بناء نفسه عندما تتغير حالة السلة.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // [استهلاك GetX Controller]
    // Get.find() للوصول إلى مثيل CartController الذي تم تهيئته.
    // Obx يستمع إلى التغييرات في RxList داخل CartController.
    final CartController cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة التسوق', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Get.back(); // استخدام Get.back للرجوع
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Obx هنا يستمع إلى التغييرات في _items (RxList) داخل CartController
            // ويعيد بناء قائمة المنتجات في السلة عند إضافتها أو إزالتها أو تغيير كميتها.
            child: Obx(() {
              if (cart.itemCount == 0) {
                return const Center(
                  child: Text(
                    'سلة التسوق فارغة!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final cartItem = cart.items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            cartItem.product.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${cartItem.product.price.toStringAsFixed(2)} SAR',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              // زر زيادة الكمية
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  cart.increaseQuantity(cartItem.product);
                                },
                              ),
                              Text('${cartItem.quantity}'),
                              // زر تقليل الكمية/الإزالة
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  cart.decreaseQuantity(cartItem.product);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          // [ملخص السلة]
          Obx(
            () => Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الإجمالي:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${cart.totalPrice.toStringAsFixed(2)} SAR', // الوصول إلى totalPrice من CartController
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (cart.itemCount > 0) {
                          cart.clearCart();
                          Get.snackbar(
                            'تم إتمام الطلب',
                            'شكراً لطلبك! تم مسح السلة.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.snackbar(
                            'سلة فارغة',
                            'لا يوجد منتجات لإتمام الطلب.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'إتمام الطلب',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
