import 'package:flutter_test/flutter_test.dart';
import 'package:velmora/velmora_app.dart';

void main() {
  testWidgets('VelmoraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VelmoraApp());
    expect(find.text('Guided Posture Stretch'), findsWidgets);
    expect(find.text('START STRETCH'), findsOneWidget);
  });
}
