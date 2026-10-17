import 'package:flutter/material.dart';

/// Indica si el límite alcanzado es el mínimo o el máximo.
enum StepperLimit {
  /// El valor llegó al mínimo permitido.
  min,

  /// El valor llegó al máximo permitido.
  max,
}

/// Llamado cuando el valor llega a un límite.
typedef LimitReached = void Function(StepperLimit limit);

/// Widget que permite aumentar o disminuir un valor entero dentro de un rango.
///
/// Muestra dos botones (− y +) con el valor actual en medio.
/// El valor nunca sale del rango [[QuantityStepper.min], [QuantityStepper.max]].
///
/// Ejemplo de uso:
/// ```dart
/// QuantityStepper(
///   min: 1,
///   max: 8,
///   initialValue: 1,
///   onChanged: (v) => print('Valor: $v'),
/// )
/// ```
class QuantityStepper extends StatefulWidget {
  /// Valor mínimo permitido. Por defecto 0.
  final int min;

  /// Valor máximo permitido. Por defecto 10.
  final int max;

  /// Cuánto sube o baja cada pulsación. Por defecto 1.
  final int step;

  /// Valor inicial. Por defecto igual a [min].
  final int? initialValue;

  /// Callback que se llama cada vez que el valor cambia.
  final ValueChanged<int>? onChanged;

  /// Callback que se llama cuando el valor llega a un límite.
  final LimitReached? onLimitReached;

  /// Etiqueta semántica para accesibilidad. Por defecto 'Cantidad'.
  final String semanticLabel;

  /// Tooltip del botón de restar. Por defecto 'Restar'.
  final String decrementTooltip;

  /// Tooltip del botón de sumar. Por defecto 'Sumar'.
  final String incrementTooltip;

  /// Crea un [QuantityStepper].
  const QuantityStepper({
    super.key,
    this.min = 0,
    this.max = 10,
    this.step = 1,
    this.initialValue,
    this.onChanged,
    this.onLimitReached,
    this.semanticLabel = 'Cantidad',
    this.decrementTooltip = 'Restar',
    this.incrementTooltip = 'Sumar',
  })  : assert(min < max, 'min debe ser menor que max'),
        assert(step > 0, 'step debe ser mayor que 0');

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late int _value;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue ?? widget.min;
    assert(
      initial >= widget.min && initial <= widget.max,
      'initialValue debe estar entre min y max',
    );
    _value = initial;
  }

  void _decrement() {
    final next = nextStepperValue(
      current: _value,
      delta: -widget.step,
      min: widget.min,
      max: widget.max,
    );
    if (next == _value) return;
    setState(() => _value = next);
    widget.onChanged?.call(_value);
    if (_value == widget.min) {
      widget.onLimitReached?.call(StepperLimit.min);
    }
  }

  void _increment() {
    final next = nextStepperValue(
      current: _value,
      delta: widget.step,
      min: widget.min,
      max: widget.max,
    );
    if (next == _value) return;
    setState(() => _value = next);
    widget.onChanged?.call(_value);
    if (_value == widget.max) {
      widget.onLimitReached?.call(StepperLimit.max);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: widget.decrementTooltip,
            icon: const Icon(Icons.remove),
            onPressed: _value <= widget.min ? null : _decrement,
          ),
          Text(
            '$_value',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            tooltip: widget.incrementTooltip,
            icon: const Icon(Icons.add),
            onPressed: _value >= widget.max ? null : _increment,
          ),
        ],
      ),
    );
  }
}

/// Calcula el siguiente valor del stepper sin salirse del rango.
///
/// - [current] valor actual
/// - [delta] cuánto se suma (positivo o negativo)
/// - [min] límite inferior
/// - [max] límite superior
int nextStepperValue({
  required int current,
  required int delta,
  required int min,
  required int max,
}) {
  final next = current + delta;
  if (next < min) return min;
  if (next > max) return max;
  return next;
}
