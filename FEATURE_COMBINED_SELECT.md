# Funcionalidad de Selección Combinada Provincia-Categoría

## Descripción General

Esta funcionalidad implementa un flujo simplificado de publicación que permite a los usuarios seleccionar tanto la provincia como la categoría en un solo paso mediante un único dropdown.

## Cambios Implementados

### 1. Página Principal (HomePage)

**Ubicación**: `lib/main.dart`

La página principal ahora incluye:

- **Dropdown Combinado**: Un `<select>` único con opciones en formato `provincia-categoria`
  - Ejemplo de opciones: `madrid-alquiler`, `barcelona-venta`, etc.
  - Formato de visualización: `MADRID - ALQUILER`, `BARCELONA - VENTA`, etc.

- **Provincias disponibles**:
  - Madrid
  - Barcelona
  - Valencia
  - Sevilla
  - Bilbao
  - Málaga

- **Categorías disponibles**:
  - Alquiler
  - Venta
  - Compartir

- **Total de opciones**: 18 combinaciones (6 provincias × 3 categorías)

### 2. Navegación Automática

Al seleccionar una opción en el dropdown:

1. El sistema parsea automáticamente la selección (formato: `provincia-categoria`)
2. Navega a la página de publicación (`PublicacionPage`)
3. Pasa los parámetros `provincia` y `categoria` a la página de destino

### 3. Página de Publicación (PublicacionPage)

**Ubicación**: `lib/main.dart`

La página de publicación muestra:

- **Información del Filtro**: Muestra claramente la provincia y categoría seleccionadas
- **Formulario Pre-filtrado**: Incluye campos para:
  - Título del inmueble
  - Descripción
  - Precio (en euros)
  - Botón de publicación

### 4. Tests Actualizados

**Ubicación**: `test/widget_test.dart`

Se han actualizado los tests para validar:

1. **HomePage Test**: Verifica que se muestre el mensaje de bienvenida y el dropdown
2. **PublicacionPage Test**: Verifica que la página muestre los filtros correctamente
3. **Navigation Test**: Verifica que la selección en el dropdown navegue correctamente

## Ventajas de la Implementación

1. **Simplicidad**: Los usuarios realizan su selección en un solo paso
2. **Claridad**: El formato de las opciones es claro y fácil de entender
3. **Eficiencia**: Acceso directo al formulario correspondiente sin pasos intermedios
4. **Validación**: Los parámetros se validan automáticamente durante la navegación

## Estructura de Datos

### Formato de Opciones

```dart
{
  'value': 'provincia-categoria',      // madrid-alquiler
  'label': 'PROVINCIA - CATEGORIA',     // MADRID - ALQUILER
  'provincia': 'provincia',             // madrid
  'categoria': 'categoria'              // alquiler
}
```

## Uso

### Para el Usuario Final

1. Abrir la aplicación
2. En la página principal, seleccionar una opción del dropdown
3. El sistema navega automáticamente a la página de publicación
4. Completar el formulario con los datos del inmueble
5. Hacer clic en "Publicar"

### Para Desarrolladores

Para añadir más provincias o categorías:

1. Editar las listas `provincias` o `categorias` en `_HomePageState`
2. Las opciones combinadas se generan automáticamente

```dart
final List<String> provincias = [
  'madrid',
  'barcelona',
  // Añadir más provincias aquí
];

final List<String> categorias = [
  'alquiler',
  'venta',
  // Añadir más categorías aquí
];
```

## Flujo de Usuario

```
┌─────────────────┐
│   HomePage      │
│                 │
│  [Dropdown]     │ ← Usuario selecciona opción
│  ┌───────────┐  │
│  │MADRID -   │  │
│  │ALQUILER   │  │
│  └───────────┘  │
└────────┬────────┘
         │
         │ Navegación automática
         ↓
┌─────────────────────────┐
│  PublicacionPage        │
│                         │
│  Provincia: MADRID      │
│  Categoría: ALQUILER    │
│                         │
│  [Formulario]           │
│  • Título               │
│  • Descripción          │
│  • Precio               │
│                         │
│  [Botón Publicar]       │
└─────────────────────────┘
```

## Notas Técnicas

- El widget `HomePage` es ahora un `StatefulWidget` para manejar el estado del dropdown
- Se utiliza `Navigator.push` para la navegación con parámetros
- Los parámetros se pasan directamente al constructor de `PublicacionPage`
- La UI utiliza Material Design con el tema Indigo

## Próximas Mejoras Potenciales

1. Integración con backend para guardar las publicaciones
2. Validación de campos del formulario
3. Subida de imágenes del inmueble
4. Filtros adicionales (número de habitaciones, m², etc.)
5. Sistema de autenticación de usuarios
