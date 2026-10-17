import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  // A4.3 Prueba golden con valor 5
  testWidgets('golden QuantityStepper con valor 5', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: QuantityStepper(
              min: 0,
              max: 10,
              initialValue: 5,
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(QuantityStepper),
      matchesGoldenFile('golden/quantity_stepper_value5.png'),
    );
  });
}
