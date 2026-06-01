# Checklist global — Sports League Management System

> Repositorio base: `kaimg/Sports-League-Management-System`
> Este checklist unifica los requerimientos de ambos cursos eliminando tareas duplicadas.
> Cada tarea indica entre corchetes el curso al que pertenece: **[SIG]** Sistemas de Información Geográfica · **[ACA]** Aplicaciones de Código Abierto · **[AMBOS]** compartida por los dos cursos.

---

## Módulo 1 — Configuración del entorno y gestión del proyecto

### Repositorio y entorno base

- [ ] `1.1` Hacer fork del repositorio kaimg/Sports-League-Management-System `[AMBOS]`
- [x] `1.2` Clonar el fork y revisar la estructura completa del proyecto (modelos, rutas, templates) `[AMBOS]`
- [x] `1.3` Configurar el entorno local: Python, Flask, PostgreSQL y dependencias del proyecto `[AMBOS]`
- [x] `1.4` Levantar el sistema base localmente y verificar que funciona correctamente `[AMBOS]`
- [ ] `1.5` Definir la estrategia de ramas en GitHub: una rama por módulo (backend, frontend, BD) `[ACA]`

### Base de datos base

- [ ] `1.6` Instalar y habilitar la extensión PostGIS en la base de datos PostgreSQL `[SIG]`
- [ ] `1.7` Verificar que PostGIS responde correctamente con una query de prueba `[SIG]`

### GitHub Actions (CI)

- [ ] `1.8` Crear un workflow de GitHub Actions que se ejecute en cada push a ramas principales `[ACA]`
- [ ] `1.9` Configurar el workflow para instalar dependencias y ejecutar validaciones básicas del proyecto `[ACA]`
- [ ] `1.10` Verificar que el pipeline corre correctamente en al menos una ejecución de prueba `[ACA]`

### Gestión con GitHub Issues / Projects

- [ ] `1.11` Crear un tablero en GitHub Projects para el seguimiento del avance del equipo `[ACA]`
- [ ] `1.12` Crear issues en GitHub para cada módulo o tarea relevante del proyecto `[ACA]`
- [ ] `1.13` Asignar issues a los integrantes según sus roles definidos `[ACA]`

---

## Módulo 2 — Modelo de datos geoespacial

### Tabla Stadiums / Venues

- [x] `2.1` Diseñar la tabla Stadiums con campos: name, city, country, capacity, latitude, longitude `[SIG]`
- [x] `2.2` Agregar columna de geometría PostGIS (POINT, SRID 4326) a la tabla Stadiums `[SIG]`
- [x] `2.3` Crear trigger o función SQL que pueble la columna geometry desde latitude/longitude automáticamente `[SIG]`
- [x] `2.4` Escribir y ejecutar la migración SQL (o Alembic) para la tabla Stadiums `[SIG]`

### Relación Teams ↔ Stadiums

- [x] `2.5` Agregar la FK `stadium_id` a la tabla Teams para vincular cada equipo con su estadio `[SIG]`
- [x] `2.6` Agregar el campo `team_region` a Teams para referencia territorial `[SIG]`
- [x] `2.7` Escribir y ejecutar la migración SQL para los cambios en la tabla Teams `[SIG]`

### Datos de prueba geoespaciales

- [x] `2.8` Cargar al menos 10 estadios reales con coordenadas precisas (lat/lng) en la BD `[SIG]`
- [x] `2.9` Vincular los equipos de prueba existentes con sus estadios correspondientes `[SIG]`

---

## Módulo 3 — Modelo de datos para seguimientos y notificaciones

### Tabla de favoritos

- [x] `3.1` Diseñar la tabla `user_favorites` con campos: user_id (FK), entity_type (equipo/liga), entity_id `[ACA]`
- [x] `3.2` Definir restricciones: un usuario no puede marcar el mismo equipo/liga como favorito dos veces `[ACA]`
- [x] `3.3` Escribir y ejecutar la migración SQL (o Alembic) para la tabla `user_favorites` `[ACA]`

### Tabla de notificaciones

- [x] `3.4` Diseñar la tabla `notifications` con campos: user_id (FK), type, message, related_match_id, is_read, created_at `[ACA]`
- [x] `3.5` Definir los tipos de notificación posibles: próximo partido, cambio de marcador, resultado final `[ACA]`
- [x] `3.6` Escribir y ejecutar la migración SQL (o Alembic) para la tabla `notifications` `[ACA]`

### Datos de prueba

- [ ] `3.7` Crear usuarios de prueba con favoritos asignados para validar la lógica posterior `[ACA]`
- [ ] `3.8` Insertar notificaciones de prueba de distintos tipos para los usuarios de prueba `[ACA]`

---

## Módulo 4 — API REST geoespacial (backend)

### Endpoints de estadios

- [x] `4.1` Crear `GET /api/stadiums` → retorna todos los estadios en formato GeoJSON `[SIG]`
- [x] `4.2` Agregar parámetros de filtro al endpoint: `?league=`, `?country=`, `?city=` `[SIG]`
- [ ] `4.3` Crear `GET /api/stadiums/<id>` → retorna detalle de un estadio específico `[SIG]`
- [ ] `4.4` Crear `POST /api/stadiums` → permite registrar un nuevo estadio con validación de datos `[SIG]`

### Endpoints de partidos

- [ ] `4.5` Crear `GET /api/match/<id>/location` → retorna coordenadas y datos del estadio de un partido `[SIG]`

### Geocodificación

- [ ] `4.6` Integrar Nominatim (OpenStreetMap) para obtener coordenadas a partir del nombre/dirección de un estadio `[SIG]`
- [ ] `4.7` Usar geocodificación automáticamente al crear un nuevo estadio si no se proveen coordenadas `[SIG]`
- [ ] `4.8` Usar geocodificación para validar coordenadas de estadios existentes `[SIG]`

---

## Módulo 5 — Backend: favoritos

### Endpoints de favoritos

- [x] `5.1` Crear `POST /api/favorites` → permite a un usuario marcar un equipo o liga como favorito `[ACA]`
- [x] `5.2` Crear `DELETE /api/favorites/<id>` → permite eliminar un favorito `[ACA]`
- [x] `5.3` Crear `GET /api/favorites` → retorna la lista de favoritos del usuario autenticado `[ACA]`
- [x] `5.4` Validar que el usuario no pueda agregar duplicados y manejar el error adecuadamente `[ACA]`
- [x] `5.5` Proteger los endpoints con autenticación (solo el usuario dueño puede gestionar sus favoritos) `[ACA]`

---

## Módulo 6 — Backend: notificaciones y detección de eventos

### Lógica de detección de eventos

- [x] `6.1` Desarrollar la función que detecta partidos próximos (ej. dentro de las próximas 24 horas) para los equipos/ligas seguidos por cada usuario `[ACA]`
- [x] `6.2` Desarrollar la función que detecta cambios de marcador en partidos en curso `[ACA]`
- [x] `6.3` Desarrollar la función que detecta resultados finales de partidos `[ACA]`

### Generación de notificaciones

- [x] `6.4` Al detectar un evento, generar un registro en la tabla `notifications` para cada usuario seguidor afectado `[ACA]`
- [x] `6.5` Evitar duplicación: no generar la misma notificación dos veces para el mismo usuario y partido `[ACA]`

### Endpoints de notificaciones

- [x] `6.6` Crear `GET /api/notifications` → retorna las notificaciones del usuario autenticado (más recientes primero) `[ACA]`
- [x] `6.7` Crear `PATCH /api/notifications/<id>/read` → marca una notificación como leída `[ACA]`
- [x] `6.8` Crear `PATCH /api/notifications/read-all` → marca todas las notificaciones del usuario como leídas `[ACA]`
- [x] `6.9` Crear `GET /api/notifications/history` → retorna el historial completo de notificaciones del usuario `[ACA]`

---

## Módulo 7 — Mapa interactivo (frontend)

### Integración de Leaflet.js

- [x] `7.1` Agregar Leaflet.js a los templates base del proyecto (CSS y JS) `[SIG]`
- [x] `7.2` Crear la vista `/map` con un mapa base de OpenStreetMap `[SIG]`
- [x] `7.3` Agregar un enlace a la sección de mapa en la navegación principal del sistema `[SIG]`

### Marcadores y popups de estadios

- [x] `7.4` Cargar los marcadores de estadios consumiendo el endpoint `GET /api/stadiums` `[SIG]`
- [x] `7.5` Diseñar íconos personalizados para los marcadores en el mapa `[SIG]`
- [x] `7.6` Implementar popup por marcador con: nombre del estadio, ciudad, equipo local y capacidad `[SIG]`
- [x] `7.7` Agregar un enlace dentro del popup al detalle del equipo o del estadio `[SIG]`

---

## Módulo 8 — Filtros geoespaciales y vistas integradas

### Filtros en el mapa

- [x] `8.1` Implementar panel de filtros en la vista del mapa: por liga, por país y por ciudad `[SIG]`
- [x] `8.2` Hacer que los filtros actualicen los marcadores dinámicamente (sin recargar la página) `[SIG]`
- [x] `8.3` Poblar los dropdowns de filtro con los datos reales disponibles en la BD `[SIG]`

### Vista de partido en mapa

- [x] `8.4` En la vista de detalle de un partido (`/match/<id>`), embeber un mapa centrado en el estadio correspondiente `[SIG]`
- [x] `8.5` Mostrar popup del partido sobre el marcador: equipos, fecha, resultado `[SIG]`

### Vista de equipo en mapa

- [x] `8.6` En la vista de detalle de un equipo (`/team/<id>`), mostrar un mapa con la ubicación de su estadio `[SIG]`
- [x] `8.7` El marcador del equipo debe mostrar nombre del estadio, ciudad y equipo local en popup `[SIG]`

---

## Módulo 9 — Frontend: panel de seguimientos personalizados

### Feed de usuario (Mis Seguimientos)

- [x] `9.1` Crear la página `/my-feed` accesible desde la navegación principal `[ACA]`
- [x] `9.2` Mostrar en el panel los equipos y ligas que el usuario sigue actualmente `[ACA]`
- [x] `9.3` Mostrar los próximos partidos de los equipos/ligas seguidos por el usuario `[ACA]`
- [x] `9.4` Mostrar los resultados recientes de los equipos/ligas seguidos `[ACA]`

### Gestión de favoritos desde la UI

- [x] `9.5` Añadir un botón "Seguir" / "Dejar de seguir" en la página del perfil del equipo `[ACA]`
- [x] `9.6` Añadir un botón "Seguir" / "Dejar de seguir" en la página del perfil de la liga `[ACA]`
- [x] `9.7` El botón debe reflejar el estado actual del seguimiento sin recargar la página `[ACA]`

### Centro de notificaciones

- [x] `9.8` Agregar un ícono de notificaciones en el header con contador de notificaciones no leídas `[ACA]`
- [x] `9.9` Implementar un panel desplegable o vista `/notifications` que liste las notificaciones del usuario `[ACA]`
- [x] `9.10` Mostrar tipo, mensaje y fecha de cada notificación; diferenciar visualmente las leídas de las no leídas `[ACA]`
- [x] `9.11` Al hacer clic en una notificación, marcarla como leída y redirigir al partido o evento relacionado `[ACA]`
- [x] `9.12` Implementar la vista `/notifications/history` con el historial completo del usuario `[ACA]`

---

## Módulo 10 — Pruebas, documentación y entrega

### Pruebas funcionales

- [ ] `10.1` Probar todos los endpoints de la API SIG (respuesta, filtros, GeoJSON válido) `[SIG]`
- [ ] `10.2` Probar el mapa con distintos filtros activos y verificar que los marcadores cambian correctamente `[SIG]`
- [ ] `10.3` Probar la vista de partido y la vista de equipo con su mapa embebido `[SIG]`
- [ ] `10.4` Cargar datos reales de al menos 2 ligas distintas y validar que todo funciona `[SIG]`
- [ ] `10.5` Probar el flujo completo de favoritos: agregar, listar y eliminar desde la UI y la API `[ACA]`
- [ ] `10.6` Probar la generación de notificaciones para los tres tipos de evento `[ACA]`
- [ ] `10.7` Probar que el centro de notificaciones muestra correctamente el estado leído/no leído `[ACA]`
- [ ] `10.8` Probar el panel "Mis seguimientos" con usuarios que tienen distintas combinaciones de favoritos `[ACA]`
- [ ] `10.9` Ejecutar el pipeline de GitHub Actions y verificar que pasa sin errores `[ACA]`
- [ ] `10.10` Corregir errores y ajustes de UX detectados durante las pruebas `[AMBOS]`

### Documentación

- [ ] `10.11` Documentar el proceso de configuración de PostGIS en el README del fork `[SIG]`
- [ ] `10.12` Documentar todos los endpoints SIG: ruta, parámetros, ejemplo de respuesta `[SIG]`
- [ ] `10.13` Documentar todos los endpoints de favoritos y notificaciones: ruta, método, parámetros y ejemplo de respuesta `[ACA]`
- [ ] `10.14` Documentar el esquema de BD ampliado (todas las tablas nuevas, columnas agregadas y relaciones) `[AMBOS]`
- [ ] `10.15` Actualizar el README del fork con instrucciones para configurar y usar todos los módulos nuevos `[AMBOS]`

### Entrega

- [ ] `10.16` Preparar el Pull Request al repositorio original con descripción detallada de todos los cambios `[AMBOS]`
- [ ] `10.17` Preparar la presentación final para el curso de Sistemas de Información Geográfica `[SIG]`
- [ ] `10.18` Preparar la presentación final para el curso de Aplicaciones de Código Abierto `[ACA]`
