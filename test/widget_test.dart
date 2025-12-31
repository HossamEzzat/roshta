// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:roshta/features/scan/logic/history_service.dart';
import 'package:roshta/main.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final historyService = HistoryService();
    // In a real test we might want to mock init(), but for now just passing instance
    await tester.pumpWidget(RoshtaApp(historyService: historyService));

    // Verify that the app title is present.
    expect(find.text('روشتة'), findsOneWidget);
  });
}
