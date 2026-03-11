// تقرير: فهم وتطبيق الرسوم المتحركة (Animations) في Flutter
// 1. ما هي الرسوم المتحركة (Animations) في Flutter؟
// الرسوم المتحركة في Flutter هي طريقة لجعل واجهة المستخدم (UI) تتحرك وتتفاعل بطريقة سلسة وجذابة، مما يحسن تجربة المستخدم ويجعل التطبيق أكثر حيوية وتفاعلية. بدلاً من مجرد تغيير الحالة بشكل فوري، تسمح الرسوم المتحركة بانتقال تدريجي بين الحالات المختلفة، مثل تغيير الحجم، اللون، الموضع، الشفافية، أو حتى الشكل.

// في Flutter، يتم بناء الرسوم المتحركة على مفهوم بسيط وقوي: الـ Widgets. هذا يعني أنك تقوم بتحريك الـ Widgets نفسها، أو الخصائص التي تؤثر على مظهرها وموقعها. تعتمد الرسوم المتحركة في Flutter على نظام الـ "Ticker" الذي يقوم بإبلاغ الـ AnimationController عند كل إطار جديد، مما يسمح بتحديث قيم الرسوم المتحركة وإعادة بناء الـ Widgets المتأثرة.

// المكونات الأساسية للرسوم المتحركة في Flutter تشمل:

// Animation: قيمة تتغير بمرور الوقت. يمكن أن تكون هذه القيمة رقمًا (مثل double للشفافية أو الحجم)، أو لونًا (Color)، أو إزاحة (Offset)، أو أي نوع بيانات آخر. الـ Animation لا تقوم بالرسم بنفسها، بل تخبر الـ Widgets بالقيم الجديدة.

// AnimationController: هو المحرك الرئيسي للرسوم المتحركة. يدير الـ Animation (بدء، إيقاف، تكرار، عكس). يتطلب TickerProvider لتلقي الإشارات عند كل إطار.

// Tween: يحدد نطاق القيم للـ Animation. على سبيل المثال، Tween<double>(begin: 0.0, end: 1.0) يولد قيمًا تتدرج من 0.0 إلى 1.0.

// CurvedAnimation: يطبق منحنى (مثل Curves.easeIn أو Curves.bounceOut) على الـ Animation لضبط سرعة التغيير وجعله يبدو أكثر طبيعية.

// AnimatedBuilder: Widget يستخدم لإعادة بناء جزء من الشجرة (Subtree) في كل خطوة من الرسوم المتحركة، مما يمنع إعادة بناء الشجرة بأكملها ويحسن الأداء.

// 2. أنواع الرسوم المتحركة (Animations) في Flutter
// يمكن تصنيف الرسوم المتحركة في Flutter إلى عدة أنواع رئيسية، بناءً على كيفية التعامل معها وتعريفها:

// أ. الرسوم المتحركة الصريحة (Explicit Animations)
// هذه هي الرسوم المتحركة التي تتطلب تحكمًا مباشرًا باستخدام AnimationController. توفر هذه الطريقة مرونة كبيرة وتمكن من إنشاء رسوم متحركة معقدة ومخصصة.

// المكونات الرئيسية المستخدمة:

// AnimationController: لإدارة دورة حياة الرسوم المتحركة (بداية، نهاية، تكرار، عكس).

// Tween: لتحديد نطاق القيم التي ستتغير الرسوم المتحركة بينها.

// CurvedAnimation: لتطبيق منحنيات حركة مختلفة (مثل التسارع والتباطؤ).

// AnimatedBuilder / AnimatedWidget: Widgets لإعادة بناء جزء من واجهة المستخدم عندما تتغير قيمة الـ Animation.

// مثال على الاستخدام: الرسوم المتحركة المتسلسلة (Staggered Animations)، والانتقال بين الشاشات، وتأثيرات التحميل المخصصة.

// ب. الرسوم المتحركة الضمنية (Implicit Animations)
// هذه هي الرسوم المتحركة الأبسط والأسهل في الاستخدام. لا تتطلب AnimationController يدويًا. بدلاً من ذلك، تقوم بتغيير خاصية معينة لـ Widget (مثل opacity أو padding أو alignment)، ويقوم Flutter تلقائيًا بتحريك التغيير إلى الحالة الجديدة خلال مدة زمنية محددة.

// المكونات الرئيسية المستخدمة:

// AnimatedContainer, AnimatedOpacity, AnimatedAlign, AnimatedCrossFade، وغيرها من الـ Widgets التي تبدأ بكلمة Animated.

// خاصية duration لتحديد مدة الرسوم المتحركة.

// خاصية curve (اختيارية) لتحديد منحنى الحركة.

// مثال على الاستخدام: تغيير لون زر عند الضغط عليه، توسيع أو تصغير حجم صورة، إظهار أو إخفاء نص.

// ج. الرسوم المتحركة المتسلسلة (Staggered Animations)
// الرسوم المتحركة المتسلسلة هي نوع فرعي من الرسوم المتحركة الصريحة. إنها مجموعات من الرسوم المتحركة التي تعمل في تسلسل أو مع تداخل. على سبيل المثال، يمكن أن يظهر عنصر ثم يتبع بظهور عنصر آخر بعد فترة قصيرة، ثم عنصر ثالث، وهكذا. هذا يخلق تأثيرًا ديناميكيًا وجذابًا حيث تظهر العناصر "ببطء" وتتبع بعضها البعض.

// المكونات الرئيسية المستخدمة:

// AnimationController واحد: يدير دورة حياة جميع الرسوم المتحركة الفرعية.

// Interval: يستخدم ضمن CurvedAnimation لتحديد جزء من مدة الـ AnimationController التي يجب أن تعمل فيها كل Animation فرعية. هذا هو المفتاح لإنشاء التأخيرات والتداخلات الزمنية.

// Tween & CurvedAnimation: لكل جزء من الرسوم المتحركة المتسلسلة.

// د. أمثلة أخرى على الرسوم المتحركة
// Hero Animations: لإنشاء انتقال سلس لعنصر مرئي بين شاشتين مختلفتين.

// Physics-based Animations: رسوم متحركة تحاكي قوانين الفيزياء (مثل الجاذبية أو الزنبرك)، مما يعطيها شعورًا أكثر واقعية. يتم استخدامها عادةً مع حزمة flutter/physics.

// Lottie Animations: لدمج الرسوم المتحركة المعقدة المصممة بواسطة مصممين (بصيغة JSON) في التطبيق.

// 3. تطبيق عملي: Staggered Animations في StatelessHomeScreen.dart
// لقد قمنا بتطبيق الرسوم المتحركة المتسلسلة (Staggered Animations) في شاشة StatelessHomeScreen.dart لجعل عناصر شبكة المنتجات تظهر بشكل تدريجي وجذاب عند تحميل الشاشة. هذا يمثل مثالًا ممتازًا على كيفية استخدام AnimationController و Tween و Interval معًا لإنشاء تأثير بصري متطور.

// كيف تم تطبيقها:

// تحويل StatelessHomeScreen إلى StatefulWidget مع SingleTickerProviderStateMixin:

// هذا سمح لنا باستخدام AnimationController والتحكم في دورة حياة الرسوم المتحركة.

// Dart

// class StatelessHomeScreen extends StatefulWidget {
//   // ...
// }

// class _StatelessHomeScreenState extends State<StatelessHomeScreen>
//     with SingleTickerProviderStateMixin { // <--- هنا التغيير الأساسي
//   // ...
// }
// تهيئة AnimationController وقائمة الـ Animations في initState:

// تم إنشاء _animationController بمدة إجمالية (مثلاً 1.5 ثانية).

// لكل منتج في الشبكة، تم إنشاء Animation<double> منفصلة باستخدام Tween<double>(begin: 0.0, end: 1.0) (للشفافية) و CurvedAnimation.

// الأهم هو استخدام Interval داخل CurvedAnimation لكل منتج. Interval(begin, end) تحدد جزءًا من مدة الـ _animationController الذي يجب أن تعمل فيه هذه الـ Animation المحددة. على سبيل المثال، المنتج الأول قد يعمل في الفترة 0.0 إلى 0.3 من المدة الكلية، والثاني من 0.1 إلى 0.4، وهكذا. هذا يخلق التأثير المتتابع.

// Dart

// late AnimationController _animationController;
// late List<Animation<double>> _productAnimations; // قائمة الرسوم المتحركة للمنتجات

// @override
// void initState() {
//   super.initState();
//   _animationController = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 1500),
//   );

//   final List<Product> allProducts = [ /* ... قائمة المنتجات ... */ ];

//   _productAnimations = List.generate(
//     allProducts.length,
//     (index) {
//       // حساب الفاصل الزمني لكل منتج لخلق التأخير
//       final intervalStart = index * (1.0 / allProducts.length) * 0.7;
//       final intervalEnd = (index + 1) * (1.0 / allProducts.length) * 0.7 + 0.3;

//       return Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//           parent: _animationController,
//           curve: Interval(
//             intervalStart,
//             intervalEnd > 1.0 ? 1.0 : intervalEnd,
//             curve: Curves.easeOut,
//           ),
//         ),
//       );
//     },
//   );

//   _animationController.forward(); // بدء الرسوم المتحركة
// }
// التخلص من AnimationController في dispose:

// لضمان تحرير الموارد، تم استدعاء _animationController.dispose() عند إغلاق الشاشة.

// Dart

// @override
// void dispose() {
//   _animationController.dispose();
//   super.dispose();
// }
// استخدام AnimatedBuilder في _buildProductsGrid:

// داخل GridView.builder، تم لف كل _buildGridProductItem بـ AnimatedBuilder.

// AnimatedBuilder يستمع إلى الـ Animation المخصصة لكل منتج (_productAnimations[index]).

// عند كل تحديث من الـ Animation، يتم إعادة بناء عنصر المنتج مع تطبيق قيم الشفافية (Opacity) وقيم التحويل (Transform.translate) من الـ Animation، مما يعطي تأثير الظهور المتتابع مع الحركة من الأسفل للأعلى.

// Dart

// Widget _buildProductsGrid( /* ... */ ) {
//   return GridView.builder(
//     // ...
//     itemBuilder: (context, index) {
//       return AnimatedBuilder( // <--- هنا يتم تطبيق الرسوم المتحركة لكل عنصر
//         animation: animations[index], // الـ Animation الفردية للمنتج
//         builder: (context, child) {
//           return Opacity(
//             opacity: animations[index].value,
//             child: Transform.translate(
//               offset: Offset(0, 50 * (1 - animations[index].value)), // حركة من الأسفل للأعلى
//               child: GestureDetector(
//                 onTap: () { /* ... */ },
//                 child: _buildGridProductItem(products[index], cartController),
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
// هذا التطبيق يوضح كيف يمكن استخدام المكونات الأساسية للرسوم المتحركة في Flutter لإنشاء تأثيرات بصرية معقدة وجذابة تحسن من تجربة المستخدم داخل التطبيق.
