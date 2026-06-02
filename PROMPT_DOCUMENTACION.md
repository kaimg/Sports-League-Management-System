# 🤖 PROMPT PARA AGENTE IA — GENERACIÓN DE DOCUMENTACIÓN DE PROYECTO SOFTWARE

> **Instrucción para el agente:** Analiza el código fuente del proyecto en este repositorio y genera la documentación completa según la estructura definida a continuación. Para cada sección, explora los archivos relevantes, infiere el contexto del sistema, y redacta contenido técnico preciso y profesional. Si algún dato no puede inferirse del código, indícalo con `[PENDIENTE — completar manualmente]`.

---

## 📋 CONTEXTO DEL ENCARGO

Este proyecto requiere documentación formal que representa el **30% de la calificación final**. Debe evidenciar investigación, decisiones tomadas, diseño y especificación técnica del sistema construido.

La documentación debe seguir **dos ejes complementarios**:
1. **Eje estructural** — los documentos formales requeridos (ver sección A)
2. **Eje narrativo** — la historia del proyecto contada con coherencia (ver sección B)

---

## SECCIÓN A — DOCUMENTOS REQUERIDOS

Genera cada uno de los siguientes documentos como archivos `.md` independientes dentro de una carpeta `/docs`:

---

### 📄 A1. `business-case.md` — Documento de Caso de Negocio e Investigación

Genera este documento respondiendo:

- **Problema identificado:** ¿Qué problema del mundo real resuelve este sistema? Describe el contexto, quiénes lo padecen y cuál era el estado antes de la solución.
- **Soluciones evaluadas y software libre elegido:** ¿Qué alternativas se consideraron? ¿Qué librerías, frameworks o herramientas open source se seleccionaron y por qué?
- **Justificación técnica:** Argumenta por qué la solución tecnológica adoptada es la más adecuada para el problema.
- **Viabilidad — inversión y ROI estimado:** Estima costos de desarrollo (horas/persona, infraestructura) y el retorno o valor generado.
- **Beneficios y riesgos:** Lista los beneficios esperados del sistema y los riesgos identificados durante su construcción o despliegue.

---

### 📄 A2. `proposed-solution.md` — Documento de Solución Propuesta

Genera este documento cubriendo:

- **Descripción de la solución:** Explica en qué consiste el sistema construido, su propósito y usuarios objetivo.
- **Mejoras o funcionalidades desarrolladas:** Lista y describe cada funcionalidad implementada.
- **Alcance del proyecto:** Define qué está dentro y qué está fuera del alcance del sistema actual.
- **Criterios de aceptación:** Define condiciones medibles que determinan que el sistema funciona correctamente.

---

### 📄 A3. `technical-specification.md` — Documento de Especificación Técnica

Genera este documento incluyendo:

- **Historias de Usuario funcionales:** Para cada funcionalidad principal, redacta una historia en formato: *"Como [rol], quiero [acción] para [beneficio]"* con sus criterios de aceptación.
- **Historias de Usuario no funcionales:** Rendimiento, seguridad, disponibilidad, escalabilidad, usabilidad.
- **Diagrama de Arquitectura del Sistema:** Genera una descripción textual detallada (o código Mermaid) de la arquitectura general: capas, servicios externos, bases de datos, integraciones.
- **Diagrama de Arquitectura de la Solución:** Genera una descripción textual (o código Mermaid) del flujo de la solución específica: cómo interactúan los módulos internos del proyecto.

> 💡 Usa bloques de código Mermaid para los diagramas si es posible:
> ````
> ```mermaid
> graph TD
>   ...
> ```
> ````

---

### 📄 A4. `user-manual.md` — Manual de Usuario y Guía de Instalación

Genera este documento con:

- **Manual de usuario:** Paso a paso de cómo usar el sistema. Incluye capturas de pantalla sugeridas `[imagen: descripción]` donde aplique.
- **Guía de instalación:** Requisitos previos, pasos de instalación, configuración de variables de entorno, comandos de arranque y verificación.

---

### 📄 A5. `api-documentation.md` — Documentación de API *(si aplica)*

Si el proyecto expone una API, genera:

- Lista de endpoints con método HTTP, ruta, descripción, parámetros de entrada y formato de respuesta.
- Ejemplos de request/response en JSON.
- Códigos de error y su significado.

---

### 📄 A6. `decision-log.md` — Registro de Decisiones y Evidencias en Repositorio

Genera este documento con:

- **Registro de decisiones:** Para cada decisión técnica importante del proyecto (arquitectura, tecnología, patrón de diseño), documenta: la decisión tomada, las alternativas consideradas, y el razonamiento.
- **Evidencias en repositorio:** Lista los commits, ramas, carpetas o archivos clave que evidencian el trabajo realizado.

---

### 📄 A7. `kanban-sprints.md` — Evidencias de Kanban y Sprints

Genera este documento describiendo:

- Las fases o sprints del proyecto.
- Tareas completadas por sprint/iteración.
- Estado actual del tablero Kanban (To Do / In Progress / Done).

---

### 📄 A8. `risk-management.md` — Plan de Gestión de Riesgos

Genera una tabla con:

| Riesgo | Probabilidad | Impacto | Estrategia de mitigación | Plan de contingencia |
|--------|-------------|---------|--------------------------|----------------------|
| ...    | Alta/Media/Baja | Alto/Medio/Bajo | ... | ... |

Incluye al menos: riesgos técnicos, riesgos de proyecto, riesgos de seguridad, y riesgos de adopción.

---

### 📄 A9. `faq.md` — Preguntas Frecuentes (FAQ)

Genera un documento con respuestas a preguntas comunes sobre:

- La solución en general (¿qué hace?, ¿para quién es?)
- Instalación y configuración
- Uso del sistema
- Decisiones técnicas tomadas

---

## SECCIÓN B — NARRATIVA DEL PROYECTO

Además de los documentos anteriores, genera un archivo `project-story.md` que cuente la historia del proyecto siguiendo esta estructura narrativa:

### 📖 `project-story.md`

```
## Contexto
¿Qué problema existía antes de este proyecto?
Describe la situación inicial, el dolor del usuario/organización, y por qué era relevante resolverlo.

## Solución
¿Qué construyeron?
Describe el sistema resultante: qué es, cómo funciona, qué lo hace valioso.

## Conocimientos aplicados
¿Qué conocimientos técnicos y metodológicos se aplicaron?
Menciona tecnologías, patrones, metodologías y habilidades utilizadas.

## Decisiones
¿Por qué así y no de otra forma?
Explica las decisiones de diseño más relevantes y el razonamiento detrás de ellas.

## Impacto
¿Qué valor generó?
Describe los beneficios concretos: eficiencia, ahorro, experiencia de usuario, escala, etc.

## Retos
¿Qué obstáculos encontraron?
Describe los principales desafíos técnicos o de proyecto enfrentados.

## Lecciones
¿Qué aprendieron?
Reflexión sobre lo que el equipo aprendería de haber construido este sistema.
```

---

## ⚙️ INSTRUCCIONES DE EJECUCIÓN PARA EL AGENTE

1. **Escanea** todos los archivos del proyecto: código fuente, `README`, `package.json` / `requirements.txt` / equivalentes, carpetas de configuración, tests, y cualquier documentación existente.
2. **Infiere** el stack tecnológico, el dominio del negocio, las funcionalidades y la arquitectura.
3. **Genera** cada documento listado en la Sección A como un archivo `.md` separado dentro de `/docs/`.
4. **Genera** el archivo `project-story.md` en la raíz o dentro de `/docs/`.
5. **Marca** con `[PENDIENTE — completar manualmente]` cualquier información que no puedas inferir del código.
6. **Usa Mermaid** para todos los diagramas donde sea posible.
7. **Mantén un tono técnico-profesional** apropiado para entrega académica universitaria.
8. Al finalizar, genera un `README.md` actualizado que enlace todos los documentos generados.

---

*Prompt generado para documentación de proyecto — estructura basada en criterios de evaluación académica (30% calificación final).*
