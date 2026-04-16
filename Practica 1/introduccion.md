# Introducción a la Práctica 1: Percepción 3D

## 1. Resumen de la Práctica
Esta sesión práctica se centra en el **Preprocesamiento y la Segmentación de Nubes de Puntos (Point Clouds)** utilizando herramientas de análisis espacial en MATLAB. Los conceptos y pasos clave se dividen en:

* **Lectura/Escritura y Visualización:** Aprender a cargar archivos con formatos estándar de escáneres 3D como `.ply` y `.pcd` usando comandos como `pcread`. Visualizar estos datos en el espacio mediante `pcshow`.
* **Mallas 3D:** Creación de representaciones volumétricas basándose en los puntos crudos (ej. Triangulación de Delaunay).
* **Preprocesamiento y Limpieza:**
  * **Recorte (ROI):** Aislar puntos en un área específica.
  * **Downsampling (`pcdownsample`):** Reducir la cantidad de puntos de la nube (de forma aleatoria o con "gridAverage") para aligerar la carga computacional en algoritmos posteriores.
  * **Denoising (`pcdenoise`):** Eliminar puntos anómalos u "outliers" (como reflejos erróneos de sensores) analizando las distancias con sus vecinos.
* **Cálculo de normales:** Extracción de la perpendicular a la superficie (`pcnormals`), vital para estimar planos.
* **Ajuste Geométrico (Fitting):** Búsqueda de figuras geométricas puras dentro del caos de la nube de puntos. Se aprende a detectar el suelo/paredes (`pcfitplane`), tubos/cilindros (`pcfitcylinder`) y esferas (`pcfitsphere`) mediante algoritmos RANSAC/MSAC.
* **Segmentación (`pcsegdist`):** Agrupar y separar físicamente objetos distintos dentro de la escena basándose en la distancia y separación que hay entre ellos.

## 2. Cosas a considerar antes de la práctica

> [!WARNING]
> **No hay scripts base**
> A diferencia de otras prácticas, el profesor no ha suministrado plantillas ni archivos `.m`. Los únicos ficheros que posees son archivos de datos brutos y el `.md` con código incrustado en las diapositivas (como si fuera teoría). Se espera que seas tú quien abra scripts en blanco y vaya copiando, adaptando y ejecutando dichos bloques de código.

> [!NOTE]
> **Sobre el lenguaje (El engaño de "PySNP")**
> Aunque la carpeta reza `Clase3-PySNP-Pract1`, **NO usamos Python**. Las instrucciones mostradas (`pcread`, usar variables con ans `>>`) son de pura sintaxis matemática de **MATLAB**.

* **Datasets locales:** Tienes a tu disposición ficheros de prueba en la carpeta `Practica 1\Practica 1`. Principalmente usarás `mesa.ply` para buscar el plano de la tabla y `calle1.pcd` (o las demás) para detectar el asfalto.
* **Rutas relativas:** Recuerda que al no estar el código creado, cuando hagas `pcread()`, tendrás que asegurarte que la ruta que pones apunta a la carpeta donde están realmente las nubes de puntos, de lo contrario dará error.

## 3. ¿Qué instalar y cómo hacerlo?

Para que el código de la diapositiva funcione, un MATLAB vacío no será suficiente. Necesitas unas librerías específicas (Toolboxes).

### Herramientas Requeridas:
1. **MATLAB** (cualquier versión reciente, preferiblemente R2021a o superior).
2. **Lidar Toolbox:** Indispensable para muchísimas funciones avanzadas de Nubes de Puntos.
3. **Computer Vision Toolbox:** Posee muchas de las funciones base como `pcread` o transformaciones geométricas de cámara.

### ¿Cómo instalar las Toolboxes?
Si no las tienes instaladas desde tu centro de software (o te da error al ejecutar `pcread`), sigue estos pasos:

1. Abre **MATLAB**.
2. En el menú superior (pestaña **Home** o Inicio), busca la sección **Environment** (Entorno).
3. Haz clic en el botón con caja que dice **Add-Ons** (Complementos) y selecciona **Get Add-Ons** (Obtener complementos).
4. El programa abrirá el *Add-On Explorer*.
5. Usa el buscador de la ventana y escribe **"Computer Vision Toolbox"**.
6. Selecciónala en los resultados y dale al botón amarillo de la derecha para **Instalar**. Podría pedirte iniciar sesión con tu cuenta MathWorks de la universidad.
7. Repite el proceso (pasos 5 y 6) pero buscando el **"Lidar Toolbox"**.
8. Una vez finalizada la cuenta atrás, no necesitas reiniciar. Para comprobar que lo tienes configurado, teclea `ver` en la "Command Window" de abajo, dale a Enter y revisa si aparecen impresas estas herramientas en la lista.
