// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zoomubik/main.dart';

void main() {
  testWidgets('HomePage displays welcome message and footer', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ZoomubikApp());

    // Verify that the welcome message is displayed.
    expect(find.text('Bienvenida a Zoomubik'), findsOneWidget);

    // Verify that footer links are present.
    expect(find.text('¿Cómo funciona Zoomubik?'), findsOneWidget);
    expect(find.text('RGPD'), findsOneWidget);
    expect(find.text('Blog'), findsOneWidget);
  });
}
