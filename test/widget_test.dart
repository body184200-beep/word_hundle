import 'package:flutter_test/flutter_test.dart';
import 'package:word_hundle/main.dart';

void main() {
  testWidgets('Word Hurdle smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Word Hurdle'), findsOneWidget);
  });
}
