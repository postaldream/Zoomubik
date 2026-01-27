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
  testWidgets('HomePage displays welcome message and dropdown', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ZoomubikApp());

    // Verify that welcome message is displayed
    expect(find.text('Bienvenido/a a Zoomubik'), findsOneWidget);
    
    // Verify that the instruction text is displayed
    expect(find.text('Selecciona tu provincia y categoría:'), findsOneWidget);
    
    // Verify that the dropdown hint is displayed
    expect(find.text('Seleccionar provincia y categoría'), findsOneWidget);
  });

  testWidgets('PublicacionPage displays filtered form', (WidgetTester tester) async {
    // Build the PublicacionPage with test parameters
    await tester.pumpWidget(
      MaterialApp(
        home: PublicacionPage(
          provincia: 'madrid',
          categoria: 'alquiler',
        ),
      ),
    );

    // Verify that the page displays the provincia and categoria
    expect(find.text('Provincia: MADRID'), findsOneWidget);
    expect(find.text('Categoría: ALQUILER'), findsOneWidget);
    
    // Verify that form fields are present
    expect(find.text('Datos del Inmueble'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Título'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Descripción'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Precio (€)'), findsOneWidget);
    
    // Verify that submit button is present
    expect(find.text('Publicar'), findsOneWidget);
  });

  testWidgets('Dropdown selection navigates to PublicacionPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ZoomubikApp());

    // Find and tap the dropdown
    await tester.tap(find.text('Seleccionar provincia y categoría'));
    await tester.pumpAndSettle();

    // Find and tap the first option (madrid-alquiler)
    await tester.tap(find.text('MADRID - ALQUILER').last);
    await tester.pumpAndSettle();

    // Verify that we navigated to the PublicacionPage
    expect(find.text('Publicar Inmueble'), findsOneWidget);
    expect(find.text('Provincia: MADRID'), findsOneWidget);
    expect(find.text('Categoría: ALQUILER'), findsOneWidget);
  });
}
