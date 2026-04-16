% =========================================================================
% DESAFÍO 2: Extraer la lista de objetos en la calle (Inventario)
% =========================================================================

% 1. Cargar nube de puntos original de la calle
% Resolución de rutas absolutas basándonos en la ubicación de este script
scriptDir = fileparts(mfilename('fullpath'));
rutaNube = fullfile(scriptDir, '..', 'Practica 1', 'calle1.pcd');
pc = pcread(rutaNube);
disp('1. Nube de la calle cargada.');


% --- Fase 1: Preprocesamiento y Segmentación Geográfica ---

% 2. Filtrado de la nube (El "Slider")
% Para acotar el área de interés a las entidades puras de la calle y evitar
% saturar el algoritmo con fachadas de edificios distantes, aplicamos una ROI.
% Actúa como si moviéramos sliders en la interfaz limitando X, Y, Z.
x_limits = [-15, 15]; % Recortamos 15 metros a la redonda
y_limits = [-15, 15];
z_limits = [-2, 5];   % Evitamos el cielo y ruido bajo tierra

roi = [x_limits; y_limits; z_limits];
idx_roi = findPointsInROI(pc, roi);
pc_filtrada = select(pc, idx_roi);

% --- Optimización Computacional ---
% La calle es inmensa. Hacemos un downsample para retener solo 1 punto representativo
% por cada bloque de 10cm, aligerando el cálculo x100 y limpiando el ruido general
gridStep = 0.1; 
pc_filtrada = pcdownsample(pc_filtrada, 'gridAverage', gridStep);
disp('2. Recorte ROI y Downsampling (0.1m) ejecutado exitosamente.');


% 3. Extracción del asfalto/calzada
% Sabiendo que el suelo es puramente horizontal (vector Director Z)
distanciaMax = 0.25; % Tolerancia
[~, ~, idx_sinSuelo] = pcfitplane(pc_filtrada, distanciaMax, [0,0,1]);

% Nos quedamos con el resto, es decir, todo lo que "sobresale" del asfalto
pc_objetos_sucios = select(pc_filtrada, idx_sinSuelo);

% Limpiamos manchas flotantes de asfalto mal recortadas para que el clustering no falle
pc_objetos = pcdenoise(pc_objetos_sucios, 'NumNeighbors', 10, 'Threshold', 0.5);
disp('3. Asfalto purgado y ruido denoisado.');


% --- Fase 2: Inventariado y Clustering ---

% 4. Detección heurística de árboles, coches y estructuras
% Dado que un árbol no es una forma pura, usamos segmentación espacial.
distanciaVacio = 0.5; % Huecos superiores a medio metro dividen la geometría como objetos distintos
[etiquetas, numObjetos] = pcsegdist(pc_objetos, distanciaVacio);

disp(['4. Segmentación finalizada. Detectados ', num2str(numObjetos), ' objetos (ej. árboles, personas, papeleras).']);


% =========================================================================
% Visualización
% =========================================================================
figure('Name', 'Desafío 2: Inventario de Calle', 'NumberTitle', 'off');

subplot(1, 2, 1);
pcshow(pc);
title('Calle Original');

subplot(1, 2, 2);
% Coloreamos cada objeto detectado de un color para evidenciar que el conteo ha
% logrado separar de manera efectiva los distintos troncos y coches
pcshow(pc_objetos.Location, etiquetas);
colormap(hsv(numObjetos));
title(['Inventario: ', num2str(numObjetos), ' elementos urbanos']);

set(gcf, 'Position', [100, 100, 1000, 500]);

% Guardar captura en lugar seguro
imageFolder = fullfile(scriptDir, 'images');
if ~exist(imageFolder, 'dir'), mkdir(imageFolder); end
saveas(gcf, fullfile(imageFolder, 'resultado_calle.png'));
disp('Resultados graficados y guardados.');
