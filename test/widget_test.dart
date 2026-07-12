import 'package:flutter_test/flutter_test.dart';
import 'package:sada/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const EchoApp());

    expect(find.byType(EchoApp), findsOneWidget);
  });
}