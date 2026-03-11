// lib/screens/stateless_home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استيراد حزمة GetX
import 'package:untitled1/CartPage.dart';
import 'package:untitled1/LipstickProductPage.dart';
import 'package:untitled1/controllers/cart_controller.dart'; // استيراد CartController الجديد
import 'package:untitled1/models/product.dart';
import 'package:untitled1/screens/cart_page.dart';
import 'package:untitled1/screens/lipstick_product_page.dart';
import 'package:untitled1/screens/state_management_overview_screen.dart';
import 'package:untitled1/state_management_overview_screen.dart';

/// الشاشة الرئيسية الثابتة للتطبيق.
/// هذا الـ Widget هو StatelessWidget لأنه لا يحتاج إلى إدارة حالة داخلية خاصة به.
/// يعرض واجهة مستخدم ثابتة مثل شريط البحث، وقائمة الفئات، وشبكة المنتجات.
/// يتعامل مع التنقل إلى شاشات أخرى ويستخدم GetX للوصول إلى عدد عناصر السلة.
class StatelessHomeScreen extends StatelessWidget {
  const StatelessHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // [استهلاك GetX Controller - الوصول]
    // Get.find() للوصول إلى المثيل الذي تم تهيئته مسبقاً في main.dart.
    // .obs يجعلها تفاعلية، لذا نستخدم Obx (أو GetBuilder) للاستماع للتغييرات.
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('الرئيسية', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          // [زر معلومات إدارة الحالة]
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StateManagementOverviewScreen(),
                ),
              );
            },
          ),
          // [أيقونة السلة]
          // Obx يستمع إلى التغييرات في أي Rx variable داخل دالة البناء الخاصة به ويعيد بناءها.
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {
                    // استخدام Get.to للتنقل بدلاً من Navigator
                    Get.to(() => const CartPage());
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
                        '${cartController.itemCount}', // الوصول إلى itemCount من CartController
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // [شريط البحث]
            _buildSearchBar(),
            const SizedBox(height: 16),
            // [قسم الفئات]
            _buildCategorySection(),
            const SizedBox(height: 24),
            // [عنوان المنتجات الأكثر مبيعًا]
            _buildSectionHeader('المنتجات الأكثر مبيعاً'),
            const SizedBox(height: 16),
            // [شبكة المنتجات الأكثر مبيعًا]
            _buildMostSellingProductsGrid(
              cartController,
            ), // تمرير cartController
            const SizedBox(height: 24),
            // [عنوان المنتجات الجديدة]
            _buildSectionHeader('المنتجات الجديدة'),
            const SizedBox(height: 16),
            // [شبكة المنتجات الجديدة]
            _buildNewProductsGrid(cartController), // تمرير cartController
            const SizedBox(height: 24),
            // [عنوان المنتجات المميزة]
            _buildSectionHeader('المنتجات المميزة'),
            const SizedBox(height: 16),
            // [شبكة المنتجات المميزة]
            _buildFeaturedProductsGrid(cartController), // تمرير cartController
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'البحث عن منتجات...',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('الفئات'),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryItem(
                'مكياج',
                'https://wwd.com/wp-content/uploads/2023/10/she-glam-care-bears-whimsical-care-bears-color-collection-1.jpg?w=1000&h=563&crop=1',
              ),
              const SizedBox(width: 10),
              _buildCategoryItem(
                'عناية بالبشرة',
                'https://saficcoshop.com/cdn/shop/products/16251268982a43bcf3721eeea4a9496bdaceab1416.jpg?v=1695059723&width=1445',
              ),
              const SizedBox(width: 10),
              _buildCategoryItem(
                'شعر',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb-KAt3Z5kkr-vth_NlTiwlhFQqeTQIGlG3SabBqpnEb06fELDjCXDyxkmF1ATC3ZoQ9c&usqp=CAU',
              ),
              const SizedBox(width: 10),
              _buildCategoryItem(
                'الاكثر مبيعا',
                'https://edesire.pk/cdn/shop/files/B0B5FF98-6439-46D1-96C6-37AEADD55CA5.jpg?v=1736928216',
              ),
              const SizedBox(width: 10),
              _buildCategoryItem(
                'ما الجديد ',
                'https://pbs.twimg.com/profile_images/1854422120270589952/mmf6y0QX_400x400.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // [بناء شبكة المنتجات الأكثر مبيعًا]
  Widget _buildMostSellingProductsGrid(CartController cartController) {
    // استلام cartController
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final products = [
          Product(
            id: 'p1',
            name: 'أحمر شفاه كلاسيكي 1',
            imageUrl:
                'https://img.ltwebstatic.com/images3_er/2024/11/04/86/1730704427ba5d89d047b47c9f5e667069994a59d6_thumbnail_1200x.webp',
            price: 6000,
          ),
          Product(
            id: 'p2',
            name: 'أحمر شفاه مطفي 2',
            imageUrl:
                'https://i0.wp.com/internationalmakeup.in/wp-content/uploads/2025/03/Sheglam-Peel-Talk-Lip-Tint-Celeb-Crush.jpg?resize=406%2C406&ssl=1',
            price: 5500,
          ),
          Product(
            id: 'p3',
            name: 'أحمر شفاه سائل 3',
            imageUrl:
                'https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/acfdb167f1334d0684fb89a536cca96b~tplv-dx0w9n1ysr-crop-webp:400:400.webp?dr=10517&t=555f072d&ps=933b5bde&shp=57fff0e0&shcp=0d52deaf&idc=useast5&from=1476391136',
            price: 7000,
          ),
          Product(
            id: 'p4',
            name: 'أحمر شفاه لامع 4',
            imageUrl:
                'https://nirnita.com/storage/171825837353b468fcc6472af1251539044f8e84a8-58046829-718d-4557-ae49-4526b3dc5c77-600x600.png',
            price: 6200,
          ),
        ];
        return GestureDetector(
          onTap: () {
            // استخدام Get.to للتنقل بدلاً من Navigator
            Get.to(
              () => LipstickProductPage(product: products[index]),
            ); // تمرير المنتج
          },
          child: _buildGridProductItem(
            products[index],
            cartController,
          ), // تمرير cartController
        );
      },
    );
  }

  // [بناء شبكة المنتجات الجديدة]
  Widget _buildNewProductsGrid(CartController cartController) {
    // استلام cartController
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final products = [
          Product(
            id: 'p5',
            name: 'احمر خدود ',
            imageUrl:
                'https://www.makeupgallery.pk/cdn/shop/collections/sheglam_makeup_product.webp?v=1729520774',
            price: 6500,
          ),
          Product(
            id: 'p6',
            name: 'كريم اساس مع بوردة خافية عيوب',
            imageUrl:
                'https://medaidco.com/cdn/shop/files/51iqXXlso0L._AC_SL1500.jpg?v=1737991375',
            price: 5800,
          ),
          Product(
            id: 'p7',
            name: 'اضاءة حمراء',
            imageUrl:
                'https://www.cosmostoreegypt.com/wp-content/uploads/2023/09/sheglam-crimson-butterfly-crystal-flutter-glitter-gel-cocoon.jpg',
            price: 7200,
          ),
          Product(
            id: 'p8',
            name: 'كريم ترطيب يومي',
            imageUrl:
                'https://img.ltwebstatic.com/v4/j/pi/2025/04/11/47/1744352518191ede4318359f62f37e15798a93ec0c_thumbnail_405x.webp',
            price: 6900,
          ),
        ];
        return GestureDetector(
          onTap: () {
            Get.to(() => LipstickProductPage(product: products[index]));
          },
          child: _buildGridProductItem(products[index], cartController),
        );
      },
    );
  }

  // [بناء شبكة المنتجات المميزة]
  Widget _buildFeaturedProductsGrid(CartController cartController) {
    // استلام cartController
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final products = [
          Product(
            id: 'p9',
            name: 'بلاشر كريمي',
            imageUrl:
                'https://m.media-amazon.com/images/I/51-U8bl1SeL._AC_UF1000,1000_QL80_.jpg',
            price: 8000,
          ),
          Product(
            id: 'p10',
            name: 'كريم اساس',
            imageUrl:
                'https://medaidco.com/cdn/shop/files/51KtoGiMbEL._AC_SL1500.jpg?v=1737991335',
            price: 7500,
          ),
          Product(
            id: 'p11',
            name: 'مسكارة تطويل رموش',
            imageUrl:
                'https://orisdi.com/cdn/shop/files/Untitleddesign_4281cea9-6db0-4c26-881c-c290d174585e_800x.jpg?v=1698807249',
            price: 8500,
          ),
          Product(
            id: 'p12',
            name: 'محدد شفاف كريمي ',
            imageUrl:
                'https://discountstore.pk/cdn/shop/files/519zusIOymL.jpg?v=1730990574',
            price: 7800,
          ),
        ];
        return GestureDetector(
          onTap: () {
            Get.to(() => LipstickProductPage(product: products[index]));
          },
          child: _buildGridProductItem(products[index], cartController),
        );
      },
    );
  }

  // [بناء عنصر منتج في الشبكة (GridView)]
  Widget _buildGridProductItem(Product product, CartController cartController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        // تغيير إلى Column لاستيعاب زر الإضافة
        children: [
          Expanded(
            // الصورة تأخذ المساحة المتاحة
            child: Hero(
              // [تغيير] إضافة Hero Widget هنا
              tag: 'productImage_${product.id}', // يجب أن تكون الـ tag فريدة
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
                  '${product.price.toStringAsFixed(2)} SAR', // عرض السعر
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      cartController.addProductToCart(
                        product,
                      ); // إضافة المنتج للسلة باستخدام GetX
                      Get.snackbar(
                        'تمت الإضافة إلى السلة',
                        '${product.name} أضيف إلى سلة التسوق.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // لون الزر
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 30), // عرض كامل
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
