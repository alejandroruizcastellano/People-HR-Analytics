# 📐 Medidas y cálculos DAX

Medidas principales creadas en Power BI para el análisis de RR. HH.

## Cálculo de antigüedad (columna)
```dax
Antigüedad =
 IF(empleados[estado_cargo] = "alta",
    DATEDIFF(empleados[fecha_contrato], TODAY(), DAY),
    DATEDIFF(empleados[fecha_contrato], empleados[cargo_hasta], DAY))
 / 365
```
Para empleados activos cuenta hasta hoy; para los de baja, hasta su fecha de salida.

## Tasa de rotación
> Empleados de baja / empleados totales.

```dax
Rotación =
    DIVIDE(
        CALCULATE(
            COUNTROWS(empleados),
            empleados[cargo_hasta] < TODAY(),
            NOT(ISBLANK(empleados[cargo_hasta]))
        ),
        COUNTROWS(empleados)
    )
```

## Profesionalización
> Empleados activos con grado académico superior a *Middle school* / empleados activos.

```dax
Profesionalización =
    CALCULATE([Empleados Activos],
        empleados[grado_academico_numerico] > 3)

Tasa de profesionalización =
    DIVIDE([Profesionalización], [Empleados Activos])
```

## Bajas (con relación inactiva al calendario)
```dax
Bajas =
    CALCULATE(
        [Contrataciones],
        USERELATIONSHIP(Calendario[Date], empleados[cargo_hasta]),
        empleados[estado_cargo] = "baja"
    )
-- USERELATIONSHIP activa la relación inactiva Calendario[Date] ↔ empleados[cargo_hasta]
```

## Otras medidas del modelo
- **Empleados Activos** — recuento de empleados con `estado_cargo = "alta"`.
- **Contrataciones** — recuento por `fecha_contrato` (relación con el calendario).
- **Promedio de salario** por departamento y por cargo.
- **Promedio de días entre aumentos salariales** por cargo y departamento.
- **Promedio de evaluación** por departamento, cargo y año.
