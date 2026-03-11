// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استيراد حزمة GetX
import 'package:untitled1/StatelessHomeScreen.dart';
import 'screens/stateless_home_screen.dart';
import 'controllers/cart_controller.dart'; // استيراد CartController الجديد

/// نقطة الدخول الرئيسية لتطبيق Flutter.
/// يتم هنا تهيئة التطبيق وتوفير CartController لجميع الـ Widgets.
void main() {
  // استخدام Get.put لتهيئة CartController وجعله متاحًا في جميع أنحاء التطبيق.
  // سيتم إنشاء المثيل مرة واحدة وسيكون متاحًا للاستخدام.
  Get.put(CartController());
  runApp(const MyApp());
}

/// الـ Widget الجذري (root widget) لتطبيقنا.
/// هو StatelessWidget لأنه لا يحتاج إلى إدارة حالة داخلية خاصة به.
/// وظيفته الأساسية هي إرجاع MaterialApp الذي يحدد الإعدادات العامة للتطبيق.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp يوفر وظائف GetX مثل التوجيه (routing) وإدارة الحالة.
    return GetMaterialApp(
      // استخدام GetMaterialApp بدلاً من MaterialApp
      debugShowCheckedModeBanner: false, // لإزالة شارة "DEBUG"
      title: 'متجر مستحضرات التجميل',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StatelessHomeScreen(), // تحديد الشاشة الرئيسية للتطبيق
    );
  }
}
