# zoomubik

Zoomubik es una aplicación móvil creada con Flutter. Aquí encontrarás instrucciones para arrancar el proyecto, estructura mínima y cómo contribuir.

## 🆕 Nueva Funcionalidad: Selección Combinada Provincia-Categoría

Esta aplicación ahora incluye un sistema simplificado de publicación de inmuebles que permite a los usuarios seleccionar provincia y categoría en un solo paso.

### Características Principales

- **Dropdown Combinado**: Selecciona provincia y categoría simultáneamente (18 opciones disponibles)
- **Navegación Automática**: Redirección automática al formulario al seleccionar una opción
- **Formulario Pre-filtrado**: El formulario muestra claramente los filtros seleccionados
- **Provincias**: Madrid, Barcelona, Valencia, Sevilla, Bilbao, Málaga
- **Categorías**: Alquiler, Venta, Compartir

### Documentación Completa

- 📘 [Guía de la Funcionalidad](FEATURE_COMBINED_SELECT.md) - Descripción detallada
- 🏗️ [Arquitectura](ARCHITECTURE_DIAGRAM.md) - Diagramas de componentes y flujo de datos
- 📋 [Resumen de Implementación](IMPLEMENTATION_SUMMARY.md) - Estado y métricas
- 🎨 [Mockup de UI](UI_MOCKUP.md) - Visualización de la interfaz

## Estado

- Estado actual: desarrollo
- Tecnologías: Flutter (Dart)

## Requisitos previos (solo para editar/correr localmente)

- Flutter SDK (stable) — para compilar localmente
- Android Studio / Xcode (solo si quieres emular / compilar nativo)
- git (opcional si subes por la web)

## Instalación y ejecución local

1. Clonar el repositorio
   ```bash
   git clone https://github.com/<tu-usuario>/zoomubik.git
   ```

2. Entrar al directorio
   ```bash
   cd zoomubik
   ```

3. Instalar dependencias
   ```bash
   flutter pub get
   ```

4. Ejecutar en emulador o dispositivo
   ```bash
   flutter run
   ```

5. Ejecutar tests
   ```bash
   flutter test
   ```

## Estructura del Proyecto

```
zoomubik/
├── lib/
│   └── main.dart              # Aplicación principal con HomePage y PublicacionPage
├── test/
│   └── widget_test.dart       # Tests de widgets
├── web/                       # Archivos para deployment web
├── pubspec.yaml               # Dependencias y metadatos
├── README.md                  # Este archivo
├── FEATURE_COMBINED_SELECT.md # Documentación de la funcionalidad
├── ARCHITECTURE_DIAGRAM.md    # Diagramas de arquitectura
├── IMPLEMENTATION_SUMMARY.md  # Resumen de implementación
└── UI_MOCKUP.md              # Mockups de UI
```

## Uso de la Aplicación

1. **Inicio**: La aplicación muestra un dropdown en la página principal
2. **Selección**: Elige una combinación de provincia y categoría
3. **Formulario**: El sistema te lleva automáticamente al formulario pre-filtrado
4. **Publicación**: Completa los datos y haz clic en "Publicar"

## Subir / colaborar

- Puedes crear issues para reportar bugs o pedir features.
- Crear pull requests a la rama `main`.

## Tests

La aplicación incluye tests comprehensivos:

- Test de HomePage: Verifica el dropdown y mensajes
- Test de PublicacionPage: Verifica el formulario filtrado
- Test de navegación: Verifica el flujo completo

Ejecutar tests:
```bash
flutter test
```

## Notas

- Si no quieres compilar localmente, puedo añadir un workflow de GitHub Actions para generar APKs en la nube.
- La aplicación usa Material Design con tema Indigo
- Implementada con null safety para máxima robustez

