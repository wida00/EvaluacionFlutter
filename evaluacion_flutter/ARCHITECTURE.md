# Clean Architecture with Riverpod - Evaluación Flutter

## Estructura del Proyecto

Este proyecto implementa Clean Architecture con Riverpod para Flutter, siguiendo las mejores prácticas de desarrollo.

### Estructura de Carpetas

```
lib/
├── core/                           # Funcionalidades compartidas
│   ├── constants/                  # Constantes de la aplicación
│   ├── error/                      # Manejo de errores y excepciones
│   ├── network/                    # Información de conectividad
│   ├── providers/                  # Providers centrales de Riverpod
│   ├── usecase/                    # Clase base para casos de uso
│   └── utils/                      # Utilidades y typedefs
├── features/                       # Características de la aplicación
│   ├── auth/                       # Autenticación
│   │   ├── data/                   # Capa de datos
│   │   │   ├── datasources/        # Fuentes de datos (API, local)
│   │   │   ├── models/             # Modelos de datos
│   │   │   └── repositories/       # Implementación de repositorios
│   │   ├── domain/                 # Capa de dominio
│   │   │   ├── entities/           # Entidades de negocio
│   │   │   ├── repositories/       # Contratos de repositorios
│   │   │   └── usecases/           # Casos de uso
│   │   └── presentation/           # Capa de presentación
│   │       ├── pages/              # Páginas/Pantallas
│   │       ├── providers/          # Providers de Riverpod
│   │       └── widgets/            # Widgets reutilizables
│   └── persons/                    # Gestión de personas
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart                       # Punto de entrada de la aplicación
```

## Capas de la Arquitectura

### 1. Domain Layer (Capa de Dominio)
- **Entities**: Objetos de negocio puros sin dependencias externas
- **Repositories**: Contratos/interfaces para acceso a datos
- **Use Cases**: Lógica de negocio específica

### 2. Data Layer (Capa de Datos)
- **Models**: Extensiones de entidades con serialización
- **Data Sources**: Implementaciones para API y almacenamiento local
- **Repository Implementations**: Implementaciones concretas de los contratos

### 3. Presentation Layer (Capa de Presentación)
- **Pages**: Pantallas de la aplicación
- **Providers**: Gestión de estado con Riverpod
- **Widgets**: Componentes de UI reutilizables

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo
- **Riverpod**: Gestión de estado y dependencias
- **Dartz**: Programación funcional (Either para manejo de errores)
- **Equatable**: Comparación de objetos

## Próximos Pasos

1. Implementar las llamadas a la API en los data sources
2. Crear los state notifiers para gestión de estado
3. Implementar las pantallas de login y gestión de personas
4. Agregar validaciones y manejo de errores
5. Implementar almacenamiento local (SharedPreferences/Hive)
6. Agregar navegación con go_router
7. Implementar tests unitarios y de integración

## Comandos Útiles

```bash
# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run

# Generar código (cuando se agreguen anotaciones)
flutter packages pub run build_runner build

# Ejecutar tests
flutter test
```

## Notas de Implementación

- Los data sources actualmente tienen implementaciones vacías (UnimplementedError)
- Los providers están configurados pero necesitan state notifiers
- La estructura está preparada para escalabilidad y mantenibilidad
- Se siguen los principios SOLID y Clean Architecture
