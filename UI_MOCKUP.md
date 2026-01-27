# UI Mockup - Combined Province-Category Select

## HomePage Screen

```
┌────────────────────────────────────────────────────┐
│ ◀ Zoomubik                                         │ ← AppBar (Indigo)
├────────────────────────────────────────────────────┤
│                                                    │
│                                                    │
│                                                    │
│              Bienvenido/a a Zoomubik               │ ← Title (Bold, 24px)
│                                                    │
│                                                    │
│         Selecciona tu provincia y categoría:       │ ← Instruction (16px)
│                                                    │
│   ┌──────────────────────────────────────────┐    │
│   │ Seleccionar provincia y categoría    ▼  │    │ ← Dropdown (Indigo Border)
│   └──────────────────────────────────────────┘    │
│                                                    │
│                                                    │
│                                                    │
│                                                    │
│                                                    │
│                                                    │
│                                                    │
└────────────────────────────────────────────────────┘

WHEN USER CLICKS DROPDOWN:
┌────────────────────────────────────────────────────┐
│   ┌──────────────────────────────────────────┐    │
│   │ MADRID - ALQUILER                        │    │
│   │ MADRID - VENTA                           │    │
│   │ MADRID - COMPARTIR                       │    │
│   │ BARCELONA - ALQUILER                     │    │
│   │ BARCELONA - VENTA                        │    │
│   │ BARCELONA - COMPARTIR                    │    │
│   │ VALENCIA - ALQUILER                      │    │
│   │ VALENCIA - VENTA                         │    │
│   │ VALENCIA - COMPARTIR                     │    │
│   │ ... (18 options total)                   │    │
│   └──────────────────────────────────────────┘    │
└────────────────────────────────────────────────────┘
```

## PublicacionPage Screen (After Selection)

### Example: User selected "MADRID - ALQUILER"

```
┌────────────────────────────────────────────────────┐
│ ◀ Publicar Inmueble                                │ ← AppBar (Indigo)
├────────────────────────────────────────────────────┤
│                                                    │
│   ╔════════════════════════════════════════════╗  │
│   ║ Formulario Filtrado                        ║  │ ← Info Card (Light Blue)
│   ║                                            ║  │
│   ║ Provincia: MADRID                          ║  │
│   ║ Categoría: ALQUILER                        ║  │
│   ╚════════════════════════════════════════════╝  │
│                                                    │
│   Datos del Inmueble                               │ ← Section Header (Bold)
│                                                    │
│   ┌──────────────────────────────────────────┐    │
│   │ Título                                   │    │ ← Text Input
│   └──────────────────────────────────────────┘    │
│                                                    │
│   ┌──────────────────────────────────────────┐    │
│   │ Descripción                              │    │ ← Multiline Text Input
│   │                                          │    │   (4 lines)
│   │                                          │    │
│   │                                          │    │
│   └──────────────────────────────────────────┘    │
│                                                    │
│   ┌──────────────────────────────────────────┐    │
│   │ Precio (€)                               │    │ ← Numeric Input
│   └──────────────────────────────────────────┘    │
│                                                    │
│   ╔════════════════════════════════════════════╗  │
│   ║            PUBLICAR                        ║  │ ← Submit Button (Indigo)
│   ╚════════════════════════════════════════════╝  │
│                                                    │
└────────────────────────────────────────────────────┘

AFTER CLICKING "PUBLICAR":
┌────────────────────────────────────────────────────┐
│                                                    │
│                                                    │
│   ╔════════════════════════════════════════════╗  │
│   ║ ✓ Publicación creada en MADRID para       ║  │ ← SnackBar Confirmation
│   ║   ALQUILER                                 ║  │   (Appears at bottom)
│   ╚════════════════════════════════════════════╝  │
└────────────────────────────────────────────────────┘
```

## Color Scheme

```
Primary Color: Indigo (Colors.indigo)
- AppBar background
- Button background
- Dropdown border

Accent Colors:
- Light Blue (Colors.indigo.shade50) - Info card background
- White - Screen background
- Black - Text color

Text Sizes:
- Title: 24px, Bold
- Instructions: 16px, Regular
- Section Headers: 18px, Bold
- Form Labels: 16px, Regular
- Button Text: 16px, Regular
```

## User Interaction Flow

```
Step 1: HomePage Initial State
┌─────────────┐
│   Screen    │
│             │
│  Welcome    │
│  Dropdown   │ ← User sees this
│  (empty)    │
└─────────────┘

Step 2: User Taps Dropdown
┌─────────────┐
│   Screen    │
│             │
│  Welcome    │
│  Dropdown   │ ← Opens with 18 options
│  ┌────────┐ │
│  │ Option │ │
│  │ Option │ │
│  │ ...    │ │
│  └────────┘ │
└─────────────┘

Step 3: User Selects Option (e.g., "MADRID - ALQUILER")
┌─────────────┐
│   Screen    │
│             │
│  Welcome    │
│  Dropdown   │ ← Shows selected value
│  [MADRID -  │
│   ALQUILER] │
└─────────────┘
       ↓
    Navigation happens automatically
       ↓
┌─────────────┐
│   Screen    │
│   (new)     │
│  ╔════════╗ │
│  ║ Filters║ │ ← Shows MADRID, ALQUILER
│  ╚════════╝ │
│             │
│  Form       │
│  Fields     │
│             │
│  [PUBLICAR] │
└─────────────┘

Step 4: User Fills Form and Clicks "PUBLICAR"
┌─────────────┐
│   Screen    │
│             │
│  Form       │
│  (filled)   │
│             │
│  [PUBLICAR] │ ← User clicks
│             │
│  ╔════════╗ │
│  ║Success ║ │ ← SnackBar appears
│  ╚════════╝ │
└─────────────┘
```

## Responsive Design Notes

The layout is responsive and will adapt to different screen sizes:

- **Mobile Portrait**: Single column layout (as shown above)
- **Mobile Landscape**: Same layout, scrollable
- **Tablet**: Wider padding, larger form elements
- **Desktop**: Centered content with max-width constraint

All Material Design components follow Flutter's responsive guidelines automatically.

## Accessibility Features

1. **Semantic Labels**: All form fields have clear labels
2. **Large Touch Targets**: Dropdown and buttons are easily tappable (48dp minimum)
3. **Color Contrast**: Indigo on white provides good contrast
4. **Keyboard Navigation**: Works with keyboard on desktop/web
5. **Screen Reader Support**: Material widgets are screen-reader compatible

## Animation & Transitions

- **Dropdown Open/Close**: Default Material fade animation
- **Page Transition**: Default Material slide animation (right to left)
- **SnackBar**: Slides up from bottom with fade-in
- **Button Press**: Material ripple effect

## Error States (Future Enhancement)

```
┌────────────────────────────────────────────────────┐
│ ◀ Publicar Inmueble                                │
├────────────────────────────────────────────────────┤
│                                                    │
│   ┌──────────────────────────────────────────┐    │
│   │ Título                 ⚠ Campo requerido │    │ ← Error state
│   └──────────────────────────────────────────┘    │
│                                                    │
└────────────────────────────────────────────────────┘
```

This could be added in future iterations with form validation.
