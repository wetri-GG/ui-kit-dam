## 1.1.0

- Añadido `QuantityStepper`: widget StatefulWidget con botones + y − para seleccionar cantidades enteras.
- Propiedades: `min`, `max`, `step`, `initialValue`, `onChanged`, `onLimitReached`, `semanticLabel`, `decrementTooltip`, `incrementTooltip`.
- Enum `StepperLimit` y typedef `LimitReached` para gestionar eventos de límite.
- Función pura `nextStepperValue` para facilitar los tests unitarios.
- Tests unitarios, de widget y golden incluidos.
- Documentación generada con `dart doc`.

## 1.0.0

- Versión inicial del paquete.
