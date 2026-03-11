// lib/screens/lipstick_product_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استيراد حزمة GetX
import 'package:untitled1/CartPage.dart';
import 'package:untitled1/controllers/cart_controller.dart'; // استيراد CartController
import 'package:untitled1/models/product.dart'; // تأكد من وجود هذا الملف
import 'package:untitled1/screens/cart_page.dart';

/// صفحة تفاصيل المنتج وأكثر.
/// هذا الـ Widget هو StatefulWidget لأنه يدير حالة داخلية خاصة به، وهي:
/// - 'currentPage': لتتبع فهرس الصورة المعروضة حاليًا في PageView.
/// - هو الذي يحتوي على قائمة المنتجات التي سيتم عرضها وإضافتها إلى السلة.
class LipstickProductPage extends StatefulWidget {
  final Product product; // إضافة المنتج كـ argument للصفحة

  const LipstickProductPage({super.key, required this.product});

  @override
  _LipstickProductPageState createState() => _LipstickProductPageState();
}

class _LipstickProductPageState extends State<LipstickProductPage> {
  int currentPage =
      0; // متغير لتتبع فهرس الصفحة الحالية في شريط الصور (PageView).

  // قائمة صور المنتج الرئيسي (لـ PageView).
  // يمكن أن تأتي هذه من Product object إذا كان لديك صور متعددة.
  // [تغيير] استخدام imageURL من المنتج الممرر كصورة أولى
  late final List<String> _mainProductImages;

  @override
  void initState() {
    super.initState();
    // تهيئة قائمة الصور لتشمل صورة المنتج الأساسية
    _mainProductImages = [
      widget.product.imageUrl, // الصورة القادمة من المنتج
      // يمكنك إضافة المزيد من الصور الثابتة هنا إذا أردت
      'https://negativeapparel.com/cdn/shop/files/sheglam-mirror-kiss-high-shine-lipstick-high-gloss-shine-glitter-lipstick-negative-apparel-686109.jpg?v=1728873345&width=1340',
    ];
  }

  // [استهلاك GetX Controller - الوصول]
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name, // عرض اسم المنتج من الـ argument
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Get.back(); // استخدام Get.back للرجوع
          },
        ),
        actions: [
          // أيقونة السلة (مع عداد باستخدام Obx)
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {
                    Get.to(() => const CartPage()); // استخدام Get.to
                  },
                ),
                if (cartController.itemCount > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cartController.itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // [عرض الصور الرئيسية للمنتج]
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: _mainProductImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Hero(
                    // [تغيير] إضافة Hero Widget هنا
                    tag:
                        'productImage_${widget.product.id}', // نفس الـ tag المستخدمة في الشاشة الرئيسية
                    child: Image.network(
                      _mainProductImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // [مؤشر الصور]
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _mainProductImages.length,
                (index) => AnimatedContainer(
                  // [تغيير] استخدام AnimatedContainer
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index ? Colors.pink : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name, // اسم المنتج
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.product.price.toStringAsFixed(2)} SAR', // سعر المنتج
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'الوصف:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'أحمر شفاه كريمي فائق الترطيب يمنح شفتيك لونًا غنيًا ولمسة نهائية تدوم طويلاً. تركيبته غنية بالمكونات الطبيعية التي تحافظ على نعومة وصحة الشفاه. متوفر بمجموعة واسعة من الألوان لتناسب جميع الإطلالات والمناسبات.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  // [زر إضافة إلى السلة]
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        cartController.addProductToCart(
                          widget.product,
                        ); // إضافة المنتج باستخدام GetX
                        Get.snackbar(
                          'تمت الإضافة إلى السلة',
                          '${widget.product.name} أضيف إلى سلة التسوق.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('أضف إلى السلة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'الميزات الرئيسية:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        Chip(label: Text('مكونات طبيعية ونقية')),
                        SizedBox(width: 10),
                        Chip(label: Text('خالٍ من التجارب على الحيوانات')),
                        SizedBox(width: 10),
                        Chip(label: Text('نباتي')),
                        SizedBox(width: 10),
                        Chip(label: Text('ثبات طويل الأمد')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // [عرض المنتجات الأخرى] - يمكن إزالة هذا الجزء أو تعديله ليناسب GetX بشكل أفضل
                  // أو يمكنك الحفاظ عليه كما هو إذا كانت المنتجات الأخرى لا تعتمد على حالة الـ controller
                  // هنا يتم تمرير cartController إلى _buildProductColumn
                  // بما أنك قمت بتعديل _buildGridProductItem في StatelessHomeScreen
                  // سنحتاج إلى التأكد من أن Product يتم تمريره بشكل صحيح.

                  // في هذا الجزء، يمكننا عرض منتجات "ذات صلة" أو "مقترحة".
                  // بما أن هذه الصفحة تركز على منتج واحد، يمكننا تبسيطها.
                  // إذا كنت تريد عرض منتجات أخرى هنا، يجب أن تكون هذه المنتجات أيضًا كائنات Product
                  // مع إمكانية إضافتها للسلة.
                  const Text(
                    'منتجات أخرى قد تعجبك:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // مثال بسيط لعرض بعض المنتجات الأخرى
                  GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // لمنع التمرير المتداخل
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: 2, // عرض منتجين إضافيين على سبيل المثال
                    itemBuilder: (context, index) {
                      final relatedProducts = [
                        Product(
                          id: 'r1',
                          name: 'ملمع شفاة وردي ',
                          imageUrl:
                              'https://www.onehub.pk/cdn/shop/files/SHEGLAM_Mirror_Kiss_High-Shine_Lipstick-Rent_Free_12_Colors_High_Gloss_Shine_Glitter_Lipstick_Moisturizing_Reduce_Lip_Fine_Lines_Lip_Balm_Lip_Makeup__SHEIN_main_0-397405.jpg?v=1717479100',
                          price: 2500,
                        ),
                        Product(
                          id: 'r2',
                          name: 'قلم شفاة متعدد الالوان',
                          imageUrl:
                              'https://i.pinimg.com/736x/0b/56/9b/0b569be211cb1b624dbaf59ffcb8d945.jpg',
                          price: 3000,
                        ),
                      ];
                      return _buildGridProductItem(
                        relatedProducts[index],
                        cartController,
                      ); // إعادة استخدام نفس الـ Widget لبناء العنصر
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // إعادة استخدام _buildGridProductItem من StatelessHomeScreen لتجنب التكرار
  // يمكن نقل هذا إلى ملف SharedWidgets.dart إذا كان يستخدم في أماكن أخرى
  Widget _buildGridProductItem(Product product, CartController cartController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Expanded(
            child: Hero(
              // [تغيير] إضافة Hero Widget هنا أيضًا إذا كنت تريد انتقال Hero من المنتجات المقترحة
              tag:
                  'productImage_${product.id}_related', // tag فريدة للمنتجات المقترحة
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${product.price.toStringAsFixed(2)} SAR',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      cartController.addProductToCart(product);
                      Get.snackbar(
                        'تمت الإضافة إلى السلة',
                        '${product.name} أضيف إلى سلة التسوق.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 30),
                    ),
                    child: const Text('أضف إلى السلة'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
