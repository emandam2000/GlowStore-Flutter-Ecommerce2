// ملاحظات حول التغييرات:

// Hero Widget في StatelessHomeScreen.dart:

// تمت إضافة Hero حول Image.network داخل _buildGridProductItem.

// تم إعطاء Hero tag فريدة بناءً على product.id (مثال: 'productImage_p1') لتحديد العنصر الذي سيتم تحريكه.

// عند النقر على المنتج، سيتم الآن إجراء انتقال سلس للصورة من الشاشة الرئيسية إلى صفحة تفاصيل المنتج.

// Hero Widget في LipstickProductPage.dart:

// تمت إضافة Hero حول Image.network داخل PageView.builder في صفحة تفاصيل المنتج.

// تم استخدام نفس tag ('productImage_${widget.product.id}') التي تم تعريفها في الشاشة الرئيسية. هذا يضمن أن Flutter يعرف أن هاتين الصورتين هما نفس العنصر ويقوم بتحريكهما بسلاسة بين الشاشات.

// تم تعديل _mainProductImages في initState لتشمل widget.product.imageUrl كأول صورة، مما يسمح للـ Hero Animation بالعمل مع الصورة التي تم النقر عليها.

// تمت إضافة Hero آخر في _buildGridProductItem داخل صفحة تفاصيل المنتج للمنتجات ذات الصلة، مع tag فريدة ('productImage_${product.id}_related') لتجنب تعارض الـ tags.

// AnimatedContainer في LipstickProductPage.dart:

// تم استخدام AnimatedContainer في مؤشر الصور (نقاط التمرير أسفل الـ PageView).

// عند تغيير الصفحة في PageView، يتم تحديث currentPage، وهذا بدوره يغير width و color لـ AnimatedContainer للنقطة النشطة، مما ينتج عنه تأثير انتقال سلس لنمو النقطة وتغيير لونها.
