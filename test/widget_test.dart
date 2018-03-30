// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/calculator.dart';

void main() {
  testWidgets('Calculator test', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget(new Calculator());

    /*
    // Check if buttons are on screen
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('ASDF'), findsNothing);
    */
    /*
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.widgetWithText(NumberKey, '2'));
    await tester.tap(find.widgetWithText(OperatorKey, 'x'));
    await tester.tap(find.widgetWithText(NumberKey, '3'));
    await tester.pump();

    // Verify that the operation was successful
    expect(find.text('0'), findsNothing);
    expect(find.text('6'), findsOneWidget);
    */
  });
}
