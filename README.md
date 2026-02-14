# 📚 Síntesis de Redes Activas (SRA)
### Facultad de Ciencias Exactas, Físicas y Naturales - Universidad Nacional de Córdoba

Este repositorio contiene el desarrollo, análisis teórico y simulaciones de los **Trabajos Prácticos de Laboratorio** de la cátedra de **Síntesis de Redes Activas**. El enfoque principal es el estudio profundo de Amplificadores Operacionales (AO), desde sus modelos ideales hasta las limitaciones reales y síntesis de filtros.

---

## 🚀 Contenidos del Repositorio

El material se encuentra organizado según los módulos temáticos de la asignatura:

### 1. Amplificadores Operacionales Ideales
Fundamentos y aplicaciones básicas bajo la presunción de idealidad.
*   ⚡ **Configuraciones básicas:** Inversor, No Inversor, Seguidor.
*   ➕➖ **Operaciones matemáticas:** Sumadores, Restadores y Amplificadores Diferenciales.
*   🎯 **Aplicaciones:** Circuitos lineales y no lineales (ej. Rectificadores de precisión).

### 2. Amplificadores Operacionales Reales
Análisis de las limitaciones físicas de los dispositivos y su impacto en el diseño.
*   🔌 **Errores en DC:** Tensión de Offset de entrada, corrientes de polarización y deriva térmica.
*   📉 **Respuesta en Frecuencia:** Ancho de banda y ganancia de lazo abierto.
*   🚀 **Respuesta Transitoria:** Limitaciones por *Slew Rate* y tiempos de establecimiento.

### 3. VFA, CFA y Estabilidad
Estudio comparativo de tecnologías y compensación de sistemas realimentados.
*   🔍 **Tecnologías:** Diferencias clave entre Amplificadores Realimentados por Tensión (**VFA**) y por Corriente (**CFA**). Usos complementarios.
*   📊 **Estabilidad:** Análisis de Margen de Ganancia y Margen de Fase (Diagramas de Bode).
*   🛠️ **Compensación:** Diseño de redes de compensación (polo-cero, capacitiva, etc.) para evitar oscilaciones y mejorar la respuesta dinámica.

### 4. Síntesis de Filtros Activos
Diseño e implementación de filtros analógicos.
*   🎚️ **Diseño:** Obtención de la función de transferencia a partir de requerimientos de plantilla (Butterworth, Chebyshev, etc.).
*   📡 **Implementación:** Síntesis de circuitos utilizando topologías activas (Sallen-Key, MFB, etc.).
*   🖥️ **Validación:** Comparación entre modelo matemático y simulación circuital.

---

### Extra - Calculadora Oscilador Hartley.
Permite jugar e interacturar con el calculo de un oscilador en tiempo real, viendo su comportamiento a medida que se modifican sus valores.
https://colab.research.google.com/drive/18beF1Tnzj-dZyt3Y_3oQHw-_bC_dfina?authuser=1#scrollTo=TDpUBGRPO60a

## 🛠️ Herramientas Utilizadas

*   **LTspice:** Para la simulación de circuitos, análisis transitorio y de respuesta en frecuencia (AC Analysis).
*   **LaTeX:** Para la redacción de informes técnicos y documentación matemática de alta calidad.
*   **Python**  Para el procesamiento de datos y gráficos teóricos.

---

## 📄 Estructura de Carpetas

```bash
├── 📁 TP1_AO_Ideales/         # Configuraciones básicas y aplicaciones
├── 📁 TP2_AO_Reales/          # Análisis de offset y limitaciones de frecuencia
├── 📁 TP3_VFA_CFA/            # Comparativa, estabilidad y compensación
├── 📁 TP4_Filtros/            # Síntesis y diseño de filtros activos
├── 📁 TPS_Extra/              # Trabajos Extra
├── 📄 Informes/               # Documentos PDF finales compilados en LaTeX
└── 📄 README.md               # Descripción del proyecto
```

---

## 🎓 Autores

Alumnos de la cátedra de Síntesis de Redes Activas - FCEFyN, UNC.
* Bazoalto Rocabado, Jacqueline.
* Cabero, Mauro Ezequiel.
* Mora, Ivan Alexander.
* Moran, Mauro Hugo.
* Ruiz, Iván Marcelo.

---
