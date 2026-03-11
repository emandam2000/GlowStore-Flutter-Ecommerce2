// lib/screens/state_management_overview_screen.dart
import 'package:flutter/material.dart';

/// صفحة لعرض مقارنة بين تقنيات إدارة الحالة: Provider, BLoC, و GetX.
/// هذه الصفحة هي StatelessWidget لأنها لا تدير أي حالة داخلية خاصة بها.
/// وظيفتها هي فقط عرض المعلومات الثابتة حول كل تقنية.
class StateManagementOverviewScreen extends StatelessWidget {
  const StateManagementOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تقنيات إدارة الحالة في Flutter',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- قسم Provider ---
            _buildSectionTitle('1. Provider (المزود)'),
            _buildInfoCard(
              title: 'الوصف:',
              content:
                  'Provider هو غلاف حول InheritedWidget يجعل إدارة الحالة أسهل وأكثر كفاءة. إنه حل بسيط وقوي وقابل للتطوير لإدارة حالة التطبيق. يسمح لك بتوفير البيانات أو الكائنات إلى أجزاء متعددة من شجرة الواجهة (Widget Tree) بحيث يمكن للـ Widgets الوصول إليها والاستماع إلى التغييرات وإعادة بناء نفسها تلقائيًا عند تحديث تلك البيانات.',
            ),
            _buildInfoCard(
              title: 'المميزات:',
              content:
                  '- بسيط وسهل التعلم.\n- يقلل الكود المتكرر (Boilerplate).\n- أداء جيد (يعيد بناء فقط الـ Widgets التي تستمع).\n- مرن ويمكن استخدامه لأي نوع من الحالة.',
            ),
            _buildInfoCard(
              title: 'متى يكون مناسبًا للاستخدام؟',
              content:
                  '- للمشاريع الصغيرة والمتوسطة التي لا تتطلب منطق عمل معقدًا جدًا.\n- للتطوير السريع والنمذجة الأولية.\n- عندما تكون البساطة وسهولة الصيانة أولوية.',
              color:
                  Colors
                      .grey[200], // تغيير اللون للإشارة إلى أنه ليس الخيار المختار الآن
            ),
            const SizedBox(height: 24),

            // --- قسم BLoC ---
            _buildSectionTitle('2. BLoC (Business Logic Component)'),
            _buildInfoCard(
              title: 'الوصف:',
              content:
                  'BLoC هو نمط لإدارة الحالة يهدف إلى فصل منطق الأعمال عن واجهة المستخدم بشكل صارم. يعتمد على مفهوم "التدفقات" (Streams) حيث يتم إرسال "الأحداث" (Events) إلى BLoC، ويقوم BLoC بمعالجتها ثم إرسال "حالات" (States) جديدة إلى واجهة المستخدم التي تستمع إليها وتحدث نفسها بناءً عليها. هذا يضمن أن واجهة المستخدم لا تتأثر مباشرة بمنطق الأعمال.',
            ),
            _buildInfoCard(
              title: 'المميزات:',
              content:
                  '- فصل صارم للمخاوف (UI عن منطق الأعمال).\n- قابلية عالية للاختبار (Testability).\n- قابلية جيدة للتوسع (Scalability).\n- سلوك يمكن التنبؤ به (Predictable).',
            ),
            _buildInfoCard(
              title: 'متى يكون مناسبًا للاستخدام؟',
              content:
                  '- لتطبيقات المؤسسات الكبيرة والمعقدة ذات قواعد العمل المعقدة.\n- عندما يكون الفصل الواضح بين الطبقات وقابلية الاختبار أولوية قصوى.\n- في الفرق الكبيرة التي تحتاج إلى بنية موحدة.',
              color:
                  Colors
                      .grey[200], // تغيير اللون للإشارة إلى أنه ليس الخيار المختار الآن
            ),
            const SizedBox(height: 24),

            // --- قسم GetX ---
            _buildSectionTitle('3. GetX'),
            _buildInfoCard(
              title: 'الوصف:',
              content:
                  'GetX هو إطار عمل مصغر يجمع بين إدارة الحالة، وحقن التبعية (Dependency Injection)، وإدارة التوجيه (Route Management) في حزمة واحدة عالية الأداء. يهدف إلى توفير نهج برمجة تفاعلي بأقل قدر من الكود المتكرر، وغالبًا دون الحاجة إلى ChangeNotifier أو StreamBuilder.',
            ),
            _buildInfoCard(
              title: 'المميزات:',
              content:
                  '- أداء عالي وكود أقل (Less Boilerplate).\n- سهولة الاستخدام للميزات الشائعة.\n- حل شامل (All-in-one) لإدارة الحالة والتوجيه والتبعيات.\n- نهج برمجة تفاعلي.',
            ),
            _buildInfoCard(
              title: 'متى يكون مناسبًا للاستخدام؟',
              content:
                  '- عندما تكون السرعة والكفاءة (أداء عالي وكود قليل) أولوية قصوى.\n- للمشاريع من أي حجم، من الصغيرة إلى الكبيرة.\n- إذا كنت تفضل نهجًا تفاعليًا لإدارة الحالة لا يعتمد على التدفقات بشكل كبير.\n\n:لماذا هو مناسب لمشروعي الحالي:) تم اختيار GetX لمشروعك (متجر مستحضرات تجميل) لأنه يوفر طريقة سريعة وفعالة لإدارة حالة سلة التسوق (إضافة، حذف، تحديث الكمية) وعرض التغييرات فورًا على واجهة المستخدم باستخدام `Obx`. كما أنه يبسط التنقل بين الصفحات وإظهار الإشعارات (Snackbars) بأقل كود ممكن، مما يجعله مثاليًا لتطبيق يتطلب تفاعلات سريعة وواجهة مستخدم ديناميكية دون تعقيد كبير في الهيكلة.',
              color: Colors.green[50], // لون فاتح لتمييز الخيار المختار لمشروعك
            ),
            const SizedBox(height: 24),

            // --- قسم MobX ---
            _buildSectionTitle('4. MobX'),
            _buildInfoCard(
              title: 'الوصف:',
              content:
                  'MobX هي مكتبة لإدارة الحالة تعتمد على مبدأ "البرمجة التفاعلية الوظيفية" (Functional Reactive Programming). تتيح لك تعريف "ملاحظات" (Observables) للحالة التي تتغير، ثم استخدام "تفاعلات" (Reactions) للرد على هذه التغييرات، و"إجراءات" (Actions) لتعديل الحالة. يتم تتبع التبعيات تلقائيًا، مما يؤدي إلى إعادة بناء الواجهة فقط عند الضرورة.',
            ),
            _buildInfoCard(
              title: 'المميزات:',
              content:
                  '- برمجة تفاعلية قوية مع تتبع تلقائي للتبعيات.\n- فصل واضح بين منطق الأعمال وواجهة المستخدم.\n- كود موجز ومفهوم.\n- قابلية جيدة للاختبار.\n- أداء فعال حيث يتم إعادة بناء الجزء المتأثر فقط.',
            ),
            _buildInfoCard(
              title: 'متى يكون مناسبًا للاستخدام؟',
              content:
                  '- للتطبيقات ذات منطق الأعمال المعقد والتفاعلات الديناميكية.\n- عندما تفضل نهجًا يعتمد على الملاحظة التفاعلية وتتبع التبعيات التلقائي.\n- للمشاريع التي تحتاج إلى مزيج من البساطة والقوة في إدارة الحالة.',
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    Color? color,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
