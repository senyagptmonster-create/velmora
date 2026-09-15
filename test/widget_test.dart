import 'package:flutter_test/flutter_test.dart';
import 'package:velmora/velmora_app.dart';

void main() {
  testWidgets('VelmoraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VelmoraApp());
    await tester.pump();
    expect(find.text('Guided Poses'), findsWidgets);
  });
}
