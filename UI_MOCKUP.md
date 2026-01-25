# UI Mockup - Publicar Button Implementation

## Overview
This document provides visual mockups of the Publicar button implementation since Flutter cannot be run in the CI environment.

## Layout Components

### Full Page Layout
```
┌────────────────────────────────────────────────────┐
│  Zoomubik                              [🔓/🔒]     │  ← AppBar
│                                                    │    (Login/Logout toggle)
├────────────────────────────────────────────────────┤
│ ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  │
│ ┃                                              ┃  │
│ ┃              🧭                               ┃  │
│ ┃                                              ┃  │
│ ┃        Bienvenida a Zoomubik                 ┃  │  ← Welcome Section
│ ┃      Tu plataforma de publicación            ┃  │    (indigo background)
│ ┃                                              ┃  │
│ ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  │
│                                                    │
│ ┌──────────────────────────────────────────────┐  │
│ │                                              │  │
│ │       Contenido de ejemplo                   │  │  ← Spacer Content
│ │                                              │  │    (400px height)
│ │  Desplázate hacia abajo para ver el form    │  │
│ │                                              │  │
│ │                                              │  │
│ │                                              │  │
│ └──────────────────────────────────────────────┘  │
│                                                    │
│ ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  │
│ ┃  Formulario de Publicación                   ┃  │
│ ┃  ──────────────────────────                  ┃  │
│ ┃                                              ┃  │  ← Target Form
│ ┃  Título: ┌────────────────────────────┐     ┃  │    (GlobalKey attached)
│ ┃          │                            │     ┃  │    (indigo border)
│ ┃          └────────────────────────────┘     ┃  │
│ ┃                                              ┃  │
│ ┃  Descripción: ┌──────────────────────┐      ┃  │
│ ┃               │                      │      ┃  │
│ ┃               │                      │      ┃  │
│ ┃               │                      │      ┃  │
│ ┃               └──────────────────────┘      ┃  │
│ ┃                                              ┃  │
│ ┃          ┌──────────────┐                    ┃  │
│ ┃          │ 📤 Enviar    │                    ┃  │
│ ┃          └──────────────┘                    ┃  │
│ ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  │
│                                                    │
│                                                    │
│           (scroll space - 100px)                   │
│                                                    │
├────────────────────────────────────────────────────┤
│                                                    │  ← Sticky Footer
│         ┌─────────────────────────────┐           │    (72px height)
│         │  📤  Publicar               │           │    (white with shadow)
│         └─────────────────────────────┘           │
│                                                    │
└────────────────────────────────────────────────────┘
```

## Interaction Flow 1: Logged Out User

### State: User clicks "Publicar" while logged out

```
BEFORE                           AFTER
─────────────────────────────────────────────────────
[Page Content]                   [Page Content]
                                 
                    ───────────→  ┌─────────────────────────┐
                                 │  Iniciar Sesión      [×] │
                                 ├─────────────────────────┤
[Footer]                         │                         │
┌──────────────┐                 │ Usuario:                │
│📤 Publicar   │                 │ ┌────────────────────┐  │
└──────────────┘                 │ │                    │  │
                                 │ └────────────────────┘  │
                                 │                         │
                                 │ Contraseña:             │
                                 │ ┌────────────────────┐  │
                                 │ │ ••••••••••         │  │
                                 │ └────────────────────┘  │
                                 │                         │
                                 │  [Cancelar] [Ingresar]  │
                                 └─────────────────────────┘
                                 
                                 [Footer]
                                 ┌──────────────┐
                                 │📤 Publicar   │
                                 └──────────────┘
```

Console Output:
```
Publicar button pressed
User not logged in - showing login modal
```

### State: User logs in via modal

```
MODAL OPEN                       MODAL CLOSES → AUTO SCROLL
─────────────────────────────────────────────────────────────
┌─────────────────────────┐      
│  Iniciar Sesión      [×] │      [Welcome Section]
├─────────────────────────┤      [Spacer Content]
│ Usuario: admin          │      
│ Contraseña: ••••••      │      ┏━━━━━━━━━━━━━━━━━━━━━━┓
│                         │  →   ┃ Formulario de Pub... ┃ ← Scrolled here!
│  [Cancelar] [Ingresar]  │      ┃ Título: [        ]   ┃   (20px above footer)
└─────────────────────────┘      ┃ Descripción: [...]   ┃
                                 ┗━━━━━━━━━━━━━━━━━━━━━━┛
[Footer]                         
┌──────────────┐                 [Footer] ← 72px height
│📤 Publicar   │                 ┌──────────────┐
└──────────────┘                 │📤 Publicar   │
                                 └──────────────┘
                                 
                                 ┌──────────────────┐
                                 │ Listo para pub..│ ← SnackBar
                                 └──────────────────┘
```

Console Output:
```
User logged in successfully
Target widget found - calculating scroll position
Target position: 824.0
Target height: 280.0
Footer height: 72.0
Current scroll: 0.0
Target scroll position: 732.0
Scroll completed successfully
Simulating interaction with target content
```

## Interaction Flow 2: Logged In User

### State: User clicks "Publicar" while logged in

```
BEFORE SCROLL                    DURING ANIMATION              AFTER SCROLL
─────────────────────────────────────────────────────────────────────────────
[Welcome Section] ← viewing     [Welcome Section]              [Welcome Section]
                                ↓ scrolling...                 (scrolled past)
[Spacer Content]                [Spacer Content]               
                                ↓ 500ms                        [Spacer Content]
                                [Spacer Content]               (scrolled past)
[Form - hidden below]           
                    ──────────→ [Form - coming up]  ────────→  ┏━━━━━━━━━━━━━┓
                                                               ┃ Formulario  ┃
[Footer]                        [Footer]                       ┃ Título: [ ] ┃
┌──────────────┐                ┌──────────────┐              ┗━━━━━━━━━━━━━┛
│📤 Publicar   │ ← clicked      │📤 Publicar   │              ┃ 20px gap    ┃
└──────────────┘                └──────────────┘              ├─────────────┤
                                                               │📤 Publicar  │
                                                               └─────────────┘
```

## Scroll Offset Calculation Diagram

```
                    Screen Viewport
    ┌───────────────────────────────────────┐
    │                                       │
    │  Current View (before scroll)         │
    │                                       │
    │                                       │
    └───────────────────────────────────────┘
                     │
                     │  User clicks "Publicar"
                     ↓
    Calculation:
    ┌───────────────────────────────────────┐
    │ targetPosition.dy = 824px             │ ← Widget position from top
    │ - footerHeight = 72px                 │ ← Subtract footer
    │ - scrollPadding = 20px                │ ← Subtract padding
    │ + currentScroll = 0px                 │ ← Add current offset
    │ ──────────────────────────────────────│
    │ = targetScrollPosition = 732px        │ ← Final scroll position
    └───────────────────────────────────────┘
                     │
                     │  Animated scroll (500ms)
                     ↓
    ┌───────────────────────────────────────┐
    │                                       │
    │  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ │ ← Form at perfect position
    │  ┃ Formulario                      ┃ │
    │  ┃ Título: [                    ] ┃ │
    │  ┃ Descripción: [                ] │
    │  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ │
    │  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ ← 20px padding (visible)
    ├───────────────────────────────────────┤
    │  [📤 Publicar]                        │ ← Footer (doesn't overlap!)
    └───────────────────────────────────────┘
```

## Component Details

### Sticky Footer (bottomNavigationBar)
```dart
Container(
  height: 72.0,                    // footerHeight constant
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [                   // Elevation effect
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, -2),     // Shadow upward
      ),
    ],
  ),
  child: ElevatedButton.icon(
    onPressed: _handlePublicarPress,
    icon: Icon(Icons.publish),
    label: Text('Publicar'),
  ),
)
```

Visual appearance:
```
┌────────────────────────────────────────────┐
│                                            │ ← 12px padding top
│    ┌────────────────────────────────┐     │
│    │  📤  Publicar                  │     │ ← Indigo button
│    └────────────────────────────────┘     │
│                                            │ ← 12px padding bottom
└────────────────────────────────────────────┘
     ↑ shadow                              ↑
     (8px blur, 2px up)        Total: 72px height
```

### Login Modal (AlertDialog)
```
┌─────────────────────────────────────────┐
│  Iniciar Sesión                    [×]  │ ← Title bar
├─────────────────────────────────────────┤
│                                         │
│  Usuario:                               │
│  ┌────────────────────────────────┐    │
│  │ [input text here]              │    │ ← TextField
│  └────────────────────────────────┘    │
│                                         │
│  Contraseña:                            │
│  ┌────────────────────────────────┐    │
│  │ •••••••••••••••                │    │ ← TextField (obscured)
│  └────────────────────────────────┘    │
│                                         │
├─────────────────────────────────────────┤
│              [Cancelar]  [Ingresar]     │ ← Action buttons
└─────────────────────────────────────────┘
```

### Target Form (with GlobalKey)
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                          ┃ ← Indigo border (2px)
┃  Formulario de Publicación               ┃ ← Title (20px, bold)
┃  ────────────────────────────            ┃
┃                                          ┃
┃  Título:                                 ┃
┃  ┌────────────────────────────────────┐ ┃
┃  │                                    │ ┃ ← TextField
┃  └────────────────────────────────────┘ ┃
┃                                          ┃
┃  Descripción:                            ┃
┃  ┌────────────────────────────────────┐ ┃
┃  │                                    │ ┃
┃  │                                    │ ┃ ← TextField (4 lines)
┃  │                                    │ ┃
┃  └────────────────────────────────────┘ ┃
┃                                          ┃
┃       ┌────────────────┐                 ┃
┃       │  📤  Enviar    │                 ┃ ← ElevatedButton
┃       └────────────────┘                 ┃
┃                                          ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## Color Scheme
```
Primary Color:    Indigo (Colors.indigo)
                  RGB: 63, 81, 181
                  
Background:       White
                  RGB: 255, 255, 255
                  
Welcome Section:  Indigo[50] (light indigo)
                  RGB: 232, 234, 246
                  
Spacer Content:   Grey[100]
                  RGB: 245, 245, 245
                  
Text Primary:     Black87
Text Secondary:   Grey[700]

Shadow:           Black26 (26% opacity)
```

## Responsive Behavior

### Mobile Portrait (360x640)
```
┌──────────────────┐
│ Zoomubik    [🔓] │
├──────────────────┤
│   Welcome        │
│   Section        │
├──────────────────┤
│   Spacer         │
│   Content        │
│   (scrollable)   │
├──────────────────┤
│   Form           │
│   [Título]       │
│   [Descripción]  │
│   [Enviar]       │
├──────────────────┤
│  [📤 Publicar]   │
└──────────────────┘
```

### Tablet/Desktop (1024x768)
```
┌───────────────────────────────────────┐
│ Zoomubik                         [🔓] │
├───────────────────────────────────────┤
│                                       │
│     ┏━━━━━━━━━━━━━━━━━━━━━━━━┓      │
│     ┃    Welcome Section     ┃      │
│     ┗━━━━━━━━━━━━━━━━━━━━━━━━┛      │
│                                       │
│     ┌────────────────────────┐       │
│     │   Spacer Content       │       │
│     └────────────────────────┘       │
│                                       │
│     ┏━━━━━━━━━━━━━━━━━━━━━━━━┓      │
│     ┃  Form                  ┃      │
│     ┃  [Título]              ┃      │
│     ┃  [Descripción]         ┃      │
│     ┗━━━━━━━━━━━━━━━━━━━━━━━━┛      │
│                                       │
├───────────────────────────────────────┤
│        [📤 Publicar]                  │
└───────────────────────────────────────┘
```

## State Indicators

### AppBar Icon States
```
Logged Out:  🔓 (login icon)     → Click to toggle state
Logged In:   🔒 (logout icon)    → Click to toggle state
```

### Button States
```
Default:     [📤 Publicar]        (Indigo, enabled)
Pressed:     [📤 Publicar]        (Darker indigo)
Disabled:    [📤 Publicar]        (Grey - not used)
```

### SnackBar Messages
```
After scroll:        "Listo para publicar"      (2 seconds)
After form submit:   "Formulario enviado"       (default duration)
```

## Animation Timings
```
Scroll Animation:     500ms (Curves.easeInOut)
Modal Appear:         Default (Material Design)
Modal Disappear:      Default (Material Design)
Login to Scroll:      300ms delay (loginToScrollDelayMs)
SnackBar Duration:    2000ms
```

## Accessibility

### Semantic Labels (should be added for production)
```
AppBar Login Icon:    "Iniciar sesión" / "Cerrar sesión"
Publicar Button:      "Publicar contenido"
Form Title Field:     "Título de la publicación"
Form Desc Field:      "Descripción de la publicación"
Form Submit Button:   "Enviar formulario"
```

### Keyboard Navigation (for web/desktop)
```
Tab order:
1. AppBar login icon
2. (scroll content - not focusable)
3. Publicar button (footer)
4. Form title field
5. Form description field
6. Form submit button
```

## Notes for Designers/Reviewers

✅ **Implemented:**
- Proper button element (not anchor link)
- Smooth scroll animation
- Footer height offset calculation
- Target validation
- User state handling
- Console logging
- Error handling

⚠️ **Demo Only:**
- Authentication is simulated
- No actual backend integration
- No form validation
- No data persistence

🎨 **Styling:**
- Material Design components
- Indigo color scheme
- Proper shadows and elevation
- Responsive padding and spacing

🔧 **Technical:**
- Flutter StatefulWidget
- ScrollController for programmatic scrolling
- GlobalKey for widget positioning
- RenderBox for position calculation
