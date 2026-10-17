# ui_kit_dam

Paquete de componentes UI para la asignatura DAM.

## Componentes

### QuantityStepper

Widget para seleccionar una cantidad entera con botones + y −.

```dart
QuantityStepper(
  min: 1,
  max: 8,
  step: 1,
  initialValue: 1,
  onChanged: (valor) {
    print('Nuevo valor: $valor');
  },
  onLimitReached: (limite) {
    if (limite == StepperLimit.max) {
      print('Has llegado al máximo');
    }
  },
)
```

**Propiedades:**

| Propiedad | Tipo | Por defecto | Descripción |
|---|---|---|---|
| `min` | `int` | `0` | Valor mínimo |
| `max` | `int` | `10` | Valor máximo |
| `step` | `int` | `1` | Incremento por pulsación |
| `initialValue` | `int?` | igual a `min` | Valor inicial |
| `onChanged` | `ValueChanged<int>?` | — | Se llama al cambiar el valor |
| `onLimitReached` | `LimitReached?` | — | Se llama al llegar a un límite |
| `semanticLabel` | `String` | `'Cantidad'` | Etiqueta de accesibilidad |
| `decrementTooltip` | `String` | `'Restar'` | Tooltip del botón − |
| `incrementTooltip` | `String` | `'Sumar'` | Tooltip del botón + |

## Ejecutar tests

```bash
flutter test --coverage
```
