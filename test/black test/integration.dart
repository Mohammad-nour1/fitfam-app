/*import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fitfam2/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("تسجيل الدخول يعرض الصفحة الرئيسية", (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'البريد الإلكتروني'), 'test@test.com');
    await tester.enterText(find.widgetWithText(TextField, 'كلمة المرور'), '12345678');

    await tester.tap(find.text('تسجيل الدخول'));
    await tester.pumpAndSettle();

    expect(find.text('تحدي اليوم'), findsOneWidget);
  });
}
*/