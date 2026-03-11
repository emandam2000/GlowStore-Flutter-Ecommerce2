// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart';
// import 'package:get/get.dart'; // لاستخدام Get.back()

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   List<CameraDescription>? _cameras;
//   Future<void>? _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     // 1. الحصول على الكاميرات المتاحة
//     _cameras = await availableCameras();

//     if (_cameras == null || _cameras!.isEmpty) {
//       Get.snackbar('خطأ', 'لا توجد كاميرات متاحة.');
//       return;
//     }

//     // 2. اختيار الكاميرا الأمامية أو الخلفية
//     final frontCamera = _cameras!.firstWhereOrNull(
//       (camera) => camera.lensDirection == CameraLensDirection.front,
//     );
//     final selectedCamera =
//         frontCamera ??
//         _cameras!.first; // استخدم الأمامية إذا وجدت وإلا استخدم الأولى

//     // 3. تهيئة المتحكم
//     _controller = CameraController(
//       selectedCamera,
//       ResolutionPreset.medium, // يمكنك تغيير الدقة هنا
//     );

//     // 4. تهيئة المتحكم وبدء البث
//     _initializeControllerFuture = _controller!
//         .initialize()
//         .then((_) {
//           if (!mounted) {
//             return;
//           }
//           setState(() {}); // إعادة بناء الواجهة بعد التهيئة
//         })
//         .catchError((Object e) {
//           if (e is CameraException) {
//             switch (e.code) {
//               case 'CameraAccessDenied':
//                 Get.snackbar(
//                   'خطأ',
//                   'تم رفض الوصول إلى الكاميرا. يرجى منح الإذن في الإعدادات.',
//                 );
//                 break;
//               default:
//                 Get.snackbar(
//                   'خطأ',
//                   'حدث خطأ غير معروف في الكاميرا: ${e.description}',
//                 );
//                 break;
//             }
//           } else {
//             Get.snackbar('خطأ', 'حدث خطأ: $e');
//           }
//           Get.back(); // العودة إذا كان هناك خطأ
//         });
//   }

//   @override
//   void dispose() {
//     _controller?.dispose(); // التخلص من المتحكم عند إغلاق الشاشة
//     super.dispose();
//   }

//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture; // تأكد أن الكاميرا مهيأة

//       // إنشاء مسار لحفظ الصورة
//       final path = join(
//         (await getTemporaryDirectory()).path,
//         '${DateTime.now()}.png',
//       );

//       // التقاط الصورة وحفظها
//       final XFile picture = await _controller!.takePicture();
//       await picture.saveTo(path);

//       Get.snackbar(
//         'نجاح',
//         'تم التقاط الصورة وحفظها في: $path',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );

//       // يمكنك هنا عرض الصورة الملتقطة أو إرسالها إلى شاشة أخرى
//       // مثال: Get.to(() => DisplayPictureScreen(imagePath: path));
//     } catch (e) {
//       Get.snackbar(
//         'خطأ في التقاط الصورة',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('الكاميرا', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
//           onPressed: () {
//             Get.back(); // العودة للصفحة السابقة
//           },
//         ),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // إذا تمت التهيئة، اعرض معاينة الكاميرا
//             if (_controller != null && _controller!.value.isInitialized) {
//               return Stack(
//                 children: [
//                   Positioned.fill(
//                     child: AspectRatio(
//                       aspectRatio: _controller!.value.aspectRatio,
//                       child: CameraPreview(_controller!),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 30.0),
//                       child: FloatingActionButton(
//                         onPressed: _takePicture,
//                         child: const Icon(Icons.camera_alt),
//                         backgroundColor: Colors.pink,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               // إذا لم يتم تهيئة المتحكم أو كانت هناك مشكلة
//               return const Center(child: Text('فشل تهيئة الكاميرا.'));
//             }
//           } else {
//             // اعرض مؤشر تحميل أثناء تهيئة الكاميرا
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
