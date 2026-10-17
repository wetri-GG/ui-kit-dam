import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  // ── A4.1 Pruebas unitarias de nextStepperValue ──────────────────────────
  group('nextStepperValue', () {
    test('sube correctamente dentro del rango', () {
      expect(nextStepperValue(current: 3, delta: 1, min: 0, max: 10), 4);
    });

    test('baja correctamente dentro del rango', () {
      expect(nextStepperValue(current: 5, delta: -1, min: 0, max: 10), 4);
    });

    test('no supera el máximo', () {
      expect(nextStepperValue(current: 10, delta: 1, min: 0, max: 10), 10);
    });

    test('no baja del mínimo', () {
      expect(nextStepperValue(current: 0, delta: -1, min: 0, max: 10), 0);
    });

    test('sube con step de 2', () {
      expect(nextStepperValue(current: 4, delta: 2, min: 0, max: 10), 6);
    });
  });

  // ── A4.2 Pruebas de widget ──────────────────────────────────────────────
  group('QuantityStepper widget', () {
    testWidgets('al pulsar + muestra el valor nuevo y llama onChanged',
        (tester) async {
      int? changed;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantityStepper(
              initialValue: 3,
              onChanged: (v) => changed = v,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('4'), findsOneWidget);
      expect(changed, 4);
    });

    testWidgets('el botón − está desactivado en el mínimo', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuantityStepper(min: 0, initialValue: 0),
          ),
        ),
      );

      final btn = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.remove),
      );
      expect(btn.onPressed, isNull);
    });

    testWidgets('onLimitReached recibe StepperLimit.max', (tester) async {
      StepperLimit? limit;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantityStepper(
              min: 0,
              max: 2,
              initialValue: 1,
              onLimitReached: (l) => limit = l,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(limit, StepperLimit.max);
    });

    testWidgets('al pulsar − baja el valor y llama onChanged', (tester) async {
      int? changed;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantityStepper(
              initialValue: 5,
              onChanged: (v) => changed = v,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('4'), findsOneWidget);
      expect(changed, 4);
    });

    testWidgets('onLimitReached recibe StepperLimit.min', (tester) async {
      StepperLimit? limit;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantityStepper(
              min: 0,
              max: 2,
              initialValue: 1,
              onLimitReached: (l) => limit = l,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(limit, StepperLimit.min);
    });
  });
}
