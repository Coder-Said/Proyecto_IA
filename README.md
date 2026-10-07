# Sistema Móvil de Diagnóstico Acústico de Fallas Mecánicas Automotrices

---

## 1. Introducción

En los últimos años, el avance en técnicas de aprendizaje automático (*Machine Learning*) y aprendizaje profundo (*Deep Learning*) ha transformado el mantenimiento predictivo y el monitoreo de maquinaria industrial y automotriz. Históricamente, la detección de fallos mecánicos ha dependido de la inspección auditiva humana o de sistemas basados en umbrales fijos; sin embargo, estos enfoques presentan serias limitaciones de escalabilidad, alta subjetividad y una reducida capacidad para aislar patrones acústicos anómalos en entornos con ruido de fondo. Ante este escenario, el procesamiento digital de señales de audio combinado con arquitecturas neuronales permite identificar firmas acústicas sutiles asociadas a desgaste o averías prematuras, habilitando diagnósticos automáticos, reproducibles y objetivos.

### 1.1 Planteamiento del Problema
Las averías mecánicas representan una contingencia recurrente para los conductores; no obstante, la complejidad técnica de los sistemas automotrices impide que el usuario promedio identifique el origen de una falla. En la actualidad, el sector carece de herramientas de diagnóstico acústico accesibles y estandarizadas que permitan inferir anomalías mecánicas con alta precisión a partir de señales de audio. Esta brecha genera dos problemáticas críticas: por un lado, intervenciones innecesarias o reemplazos erróneos de componentes que no resuelven la causa raíz; por otro, una asimetría de información que deja al propietario vulnerable a sobrecostos y cobros desproporcionados por falta de un respaldo técnico verificable.

### 1.2 Propuesta de Solución
Para mitigar esta problemática, este proyecto propone el desarrollo de una aplicación móvil que integra procesamiento digital de señales y modelos de aprendizaje profundo para el diagnóstico no invasivo de fallas mecánicas. El sistema captura el audio del motor en tiempo real, aplica técnicas de filtrado y reducción de ruido ambiental, y transforma las señales en representaciones tiempo-frecuencia (espectrogramas de Mel). Estas representaciones alimentan una red neuronal convolucional (CNN) optimizada y cuantizada mediante TensorFlow Lite, permitiendo una inferencia local (*Edge AI*) directamente en el dispositivo móvil sin depender de conexión a internet. La herramienta entrega al usuario un reporte técnico comprensible, con la clase de avería detectada y su porcentaje de certeza.

---

## 2. Objetivos del Proyecto

### 2.1 Objetivo General
Desarrollar un sistema móvil de diagnóstico mecánico no invasivo basado en modelos de aprendizaje profundo y procesamiento digital de señales acústicas, capaz de clasificar patrones anómalos en vehículos automotrices mediante inferencia local (*edge computing*) y sin requerir conexión a internet.

### 2.2 Objetivos Específicos
1. **Adquisición y preprocesamiento de datos:** Recolectar y acondicionar un conjunto de datos de señales acústicas vehiculares, aplicando técnicas de filtrado de ruido y transformación tiempo-frecuencia (espectrogramas de Mel).
2. **Entrenamiento y optimización del modelo:** Diseñar, entrenar y validar una arquitectura de red neuronal convolucional (CNN) orientada a clasificar 5 fallos mecánicos críticos, alcanzando un desempeño mínimo del 75% en métricas ponderadas ($F_1\text{-Score}$).
3. **Compresión e inferencia en el borde (*Edge AI*):** Optimizar y cuantizar el modelo entrenado mediante TensorFlow Lite para permitir una ejecución eficiente, de baja latencia y autónoma (*offline*) en hardware móvil.
4. **Desarrollo de la aplicación móvil y validación:** Implementar una interfaz de usuario que integre el motor de inferencia local con la captura de audio del dispositivo, validando su precisión y tiempo de respuesta en escenarios de prueba reales.

---

## 3. Stack Tecnológico

| Componente | Tecnología | Justificación Técnica |
| :--- | :--- | :--- |
| **DSP y Audio** | `librosa`, `scipy`, `numpy` | Filtrado pasabanda y transformación a espectrogramas de Mel. |
| **Modelado IA** | `TensorFlow` / `Keras` | Entrenamiento y ajuste de la arquitectura convolucional (CNN). |
| **Optimización Edge** | `TensorFlow Lite (TFLite)` | Cuantización del modelo (INT8/FP16) para inferencia *offline*. |
| **Desarrollo Móvil** | `Flutter` (Dart) | Interfaz de usuario multiplataforma y captura de audio PCM. |
| **Inferencia Móvil** | `tflite_flutter` | Carga y ejecución local del binario `.tflite` en el dispositivo. |
| **Métricas y Análisis** | `scikit-learn`, `matplotlib` | Evaluación cuantitativa (F1-Score, matriz de confusión) y visualización. |

---

## 4. Pipeline Metodológico

```text
[ Señal de Audio (.wav) ]
          │
          ▼
[ Filtrado Digital y Supresión de Ruido ]
          │
          ▼
[ Transformación Tiempo-Frecuencia (Mel Spectrogram) ]
          │
          ▼
[ Inferencia con CNN Cuantizada (.tflite) ]
          │
          ▼
[ Diagnóstico: Tipo de Falla + Nivel de Confianza (%) ]
