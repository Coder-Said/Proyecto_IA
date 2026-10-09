# Diagnóstico Acústico de Fallas Mecánicas

Aplicación móvil impulsada por **Deep Learning** y **procesamiento digital de señales (DSP)** para la detección no invasiva de fallas mecánicas automotrices mediante análisis de audio. El modelo está optimizado con **TensorFlow Lite** para realizar inferencia local directamente en el dispositivo (*Edge AI*), permitiendo diagnósticos rápidos y sin necesidad de conexión a internet.

---

## 🚀 Características

* **Análisis de audio en tiempo real:** Captura el sonido del motor y genera espectrogramas de Mel para su evaluación.
* **Diagnóstico local (*Offline*):** Inferencia en el borde utilizando TensorFlow Lite sin requerir datos móviles o Wi-Fi.
* **Detección multiclase:** Clasificación de patrones anómalos asociados a fallas mecánicas frecuentes con su respectivo porcentaje de certeza.
* **Interfaz intuitiva:** Diseñada para brindar diagnósticos claros y accesibles a cualquier conductor.

---

## 🛠️ Tecnologías Utilizadas

* **Audio y DSP:** Python, Librosa, NumPy, SciPy
* **Entrenamiento de Modelos:** TensorFlow / Keras (CNN)
* **Optimización en el Borde:** TensorFlow Lite (Cuantización INT8/FP16)
* **Desarrollo Móvil:** Mockups en Figma y aplicación en Android Studio

---

## 👥 Desarrolladores

Proyecto desarrollado por:

* **Said Josué Bravo González**
* **Jhon Alexander Solórzano Mendoza**
* **Deysi Abigail Guachamín Guanuña**

---

## 📄 Licencia

Proyecto desarrollado con fines estrictamente académicos y de investigación. Todos los derechos reservados © 2026. Para más detalles sobre las restricciones de uso y distribución, consulta el archivo [LICENSE](LICENSE).
