# Práctica 1: Percepción 3D

Esta práctica está dedicada al **Preprocesamiento y la Segmentación de Nubes de Puntos (Point Clouds)** en MATLAB. 

## Objetivos
* **Lectura y visualización** de formatos estándar (`.ply`, `.pcd`) usando `pcread` y `pcshow`.
* **Procesamiento de datos**:
  * Recorte por región de interés (ROI).
  * Reducción de puntos (Downsampling, `pcdownsample`).
  * Eliminación de ruido (Denoising, `pcdenoise`).
* **Cálculo de normales** de las superficies.
* **Ajustes Geométricos (Fitting)**: Encontrar geometrías puras (planos, esferas, cilindros) en la nube mediante algoritmos de RANSAC/MSAC.
* **Segmentación de objetos** en el espacio analizando las distancias entre conjuntos usando `pcsegdist`.

## Requisitos y Configuración de MATLAB
Esta práctica se basa exclusivamente en MATLAB (aunque la carpeta de recursos ponga "PySNP"), por lo que requerirás instalar algunos complementos (Toolboxes) desde la pestaña "Home" -> "Add-Ons":
- **Computer Vision Toolbox**
- **Lidar Toolbox**

## Scripts y Datos Locales
Los datos en bruto (`mesa.ply`, `calle1.pcd`, etc.) se encuentran en la subcarpeta `Practica 1`. 
Se han creado scripts propios (como `Visualizar_PLY.m`) que permiten automatizar la carga de las nubes de puntos con rutas relativas a este entorno.
