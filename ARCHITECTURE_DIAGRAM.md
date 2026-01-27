# Diagrama de Arquitectura - Selección Combinada

## Estructura de Componentes

```
┌─────────────────────────────────────────────────────────────────┐
│                        ZoomubikApp                               │
│                     (MaterialApp)                                │
│                                                                  │
│  Theme: Indigo                                                   │
│  Home: HomePage                                                  │
└──────────────────────────────┬───────────────────────────────────┘
                               │
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│                         HomePage                                 │
│                    (StatefulWidget)                              │
│                                                                  │
│  State: _HomePageState                                           │
│  ┌────────────────────────────────────────────────────────┐     │
│  │ Data:                                                  │     │
│  │ • provincias: [madrid, barcelona, valencia, ...]      │     │
│  │ • categorias: [alquiler, venta, compartir]            │     │
│  │ • selectedOption: String?                             │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐     │
│  │ UI Components:                                         │     │
│  │                                                        │     │
│  │  AppBar: "Zoomubik"                                    │     │
│  │                                                        │     │
│  │  Body:                                                 │     │
│  │    • Text: "Bienvenido/a a Zoomubik"                   │     │
│  │    • Text: "Selecciona tu provincia y categoría:"      │     │
│  │    • Container (bordered)                              │     │
│  │        └─ DropdownButton<String>                       │     │
│  │             • hint: "Seleccionar provincia y..."       │     │
│  │             • items: 18 combined options               │     │
│  │             • onChanged: navigate to PublicacionPage   │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
│  Methods:                                                        │
│  • getCombinedOptions() → List<Map<String, String>>             │
│  • navigateToPublicacion(String?) → void                        │
└───────────────────────────┬──────────────────────────────────────┘
                            │
                            │ Navigator.push
                            │ (provincia, categoria)
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│                      PublicacionPage                             │
│                    (StatelessWidget)                             │
│                                                                  │
│  Parameters:                                                     │
│  • provincia: String? (e.g., "madrid")                           │
│  • categoria: String? (e.g., "alquiler")                         │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐     │
│  │ UI Components:                                         │     │
│  │                                                        │     │
│  │  AppBar: "Publicar Inmueble"                           │     │
│  │                                                        │     │
│  │  Body:                                                 │     │
│  │    • Card (if provincia && categoria not null)         │     │
│  │        ├─ Text: "Formulario Filtrado"                  │     │
│  │        ├─ Text: "Provincia: MADRID"                    │     │
│  │        └─ Text: "Categoría: ALQUILER"                  │     │
│  │                                                        │     │
│  │    • Text: "Datos del Inmueble"                        │     │
│  │                                                        │     │
│  │    • TextField: "Título"                               │     │
│  │    • TextField: "Descripción" (multiline)              │     │
│  │    • TextField: "Precio (€)" (numeric)                 │     │
│  │                                                        │     │
│  │    • ElevatedButton: "Publicar"                        │     │
│  │        • enabled if provincia && categoria not null    │     │
│  │        • shows SnackBar on success                     │     │
│  └────────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────┘
```

## Flujo de Datos

```
┌──────────────┐
│ User Action  │
└──────┬───────┘
       │
       ↓
┌─────────────────────────┐
│ Select dropdown option  │
│ "MADRID - ALQUILER"     │
└──────┬──────────────────┘
       │
       ↓
┌──────────────────────────────────┐
│ Parse selected value             │
│ "madrid-alquiler"                │
│   ↓                              │
│ Split by "-"                     │
│   ↓                              │
│ provincia = "madrid"             │
│ categoria = "alquiler"           │
└──────┬───────────────────────────┘
       │
       ↓
┌─────────────────────────────────┐
│ Navigate to PublicacionPage     │
│ with parameters:                │
│ • provincia: "madrid"            │
│ • categoria: "alquiler"          │
└──────┬──────────────────────────┘
       │
       ↓
┌─────────────────────────────────┐
│ PublicacionPage renders         │
│ • Shows selected filters        │
│ • Displays form fields          │
│ • Enables submit button         │
└─────────────────────────────────┘
```

## Opciones del Dropdown (18 combinaciones)

```
┌─────────────┬──────────┬─────────────────────────┐
│ Provincia   │ Categoría│ Display Label           │
├─────────────┼──────────┼─────────────────────────┤
│ madrid      │ alquiler │ MADRID - ALQUILER       │
│ madrid      │ venta    │ MADRID - VENTA          │
│ madrid      │ compartir│ MADRID - COMPARTIR      │
├─────────────┼──────────┼─────────────────────────┤
│ barcelona   │ alquiler │ BARCELONA - ALQUILER    │
│ barcelona   │ venta    │ BARCELONA - VENTA       │
│ barcelona   │ compartir│ BARCELONA - COMPARTIR   │
├─────────────┼──────────┼─────────────────────────┤
│ valencia    │ alquiler │ VALENCIA - ALQUILER     │
│ valencia    │ venta    │ VALENCIA - VENTA        │
│ valencia    │ compartir│ VALENCIA - COMPARTIR    │
├─────────────┼──────────┼─────────────────────────┤
│ sevilla     │ alquiler │ SEVILLA - ALQUILER      │
│ sevilla     │ venta    │ SEVILLA - VENTA         │
│ sevilla     │ compartir│ SEVILLA - COMPARTIR     │
├─────────────┼──────────┼─────────────────────────┤
│ bilbao      │ alquiler │ BILBAO - ALQUILER       │
│ bilbao      │ venta    │ BILBAO - VENTA          │
│ bilbao      │ compartir│ BILBAO - COMPARTIR      │
├─────────────┼──────────┼─────────────────────────┤
│ malaga      │ alquiler │ MALAGA - ALQUILER       │
│ malaga      │ venta    │ MALAGA - VENTA          │
│ malaga      │ compartir│ MALAGA - COMPARTIR      │
└─────────────┴──────────┴─────────────────────────┘
```

## Estados del Componente

### HomePage States

```
┌────────────────────┐
│ Initial State      │
│ selectedOption: null│
└─────────┬──────────┘
          │
          ↓
┌─────────────────────────┐
│ Option Selected         │
│ selectedOption: "madrid-│
│                 alquiler"│
└─────────┬───────────────┘
          │
          ↓
┌─────────────────────────┐
│ Navigation Triggered    │
│ (State resets after     │
│  user returns)          │
└─────────────────────────┘
```

### PublicacionPage States

```
┌──────────────────────────┐
│ Valid State              │
│ provincia: "madrid"      │
│ categoria: "alquiler"    │
│ → Button: ENABLED        │
└──────────────────────────┘

┌──────────────────────────┐
│ Invalid State            │
│ provincia: null          │
│ categoria: null          │
│ → Button: DISABLED       │
└──────────────────────────┘
```

## Gestión de Null Safety

```dart
// En PublicacionPage

// 1. Verificación condicional para mostrar Card
if (provincia != null && categoria != null) {
  // Mostrar información del filtro
}

// 2. Verificación para habilitar botón
ElevatedButton(
  onPressed: provincia != null && categoria != null
      ? () { /* handler */ }
      : null,  // Button disabled
)

// 3. Uso seguro con null assertion (!)
// Solo se usa después de verificar que no es null
Text('Provincia: ${provincia!.toUpperCase()}')
```
