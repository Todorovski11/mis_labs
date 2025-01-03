// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joke_app/main.dart'; // Replace joke_app with the actual package name in pubspec.yaml.

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp()); // Ensure MyApp exists in main.dart.

    // Verify that the counter starts at 0.
    expect(find.text('0'), findsOneWidget, reason: 'Initial counter value should be 0');
    expect(find.text('1'), findsNothing, reason: 'Initial counter value should not be 1');

    // Simulate a tap on the "+" button and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the counter increments to 1.
    expect(find.text('0'), findsNothing, reason: 'Counter should no longer display 0');
    expect(find.text('1'), findsOneWidget, reason: 'Counter should increment to 1 after a tap');
  });
}
