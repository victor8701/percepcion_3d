% Variar la resolución de la nube de puntos (Downsampling)
% Basado en las 3 estrategias de pcdownsample mostradas en la diapositiva

% Cargar una nube de puntos de prueba
ptCloudIn = pcread('Practica 1/mesa.ply');

% --- 1. Método Random (Aleatorio) ---
% Reduce el número de puntos conservando solo un porcentaje dado (ej. 0.1 = 10%)
percentage = 0.1;
ptCloudRandom = pcdownsample(ptCloudIn, 'random', percentage);


% --- 2. Método Grid Average (Promedio de cuadrícula/voxel) ---
% Divide el volumen en cajas (voxels) de tamaño 'gridStep'. 
% Los puntos dentro de cada caja se fusionan en un único punto promedio.
gridStep = 0.05; % Ajustar según el tamaño real de la escena
ptCloudGrid = pcdownsample(ptCloudIn, 'gridAverage', gridStep);


% --- 3. Método Non-uniform Grid Sample ---
% Similar a gridAverage, pero permite especificar el número máximo de puntos a mantener de cada caja.
maxNumPoints = 6; % La documentación exige que sea al menos 6
ptCloudNonUniform = pcdownsample(ptCloudIn, 'nonuniformGridSample', maxNumPoints);


%% Visualización Comparativa

% Figura 1: Original vs Random
figure('Name', 'Comparativa de Downsampling 1', 'NumberTitle', 'off');
subplot(1,2,1);
pcshow(ptCloudIn);
title('Original');
subplot(1,2,2);
pcshow(ptCloudRandom);
title(['Random (' num2str(percentage*100) '%)']);

% Figura 2: Grid Average vs Non-Uniform Grid
figure('Name', 'Comparativa de Downsampling 2', 'NumberTitle', 'off');
subplot(1,2,1);
pcshow(ptCloudGrid);
title(['Grid Average (Step=' num2str(gridStep) ')']);
subplot(1,2,2);
pcshow(ptCloudNonUniform);
title(['Non-Uniform (MaxPts=' num2str(maxNumPoints) ')']);

% Guardar imágenes para el README
if ~exist('images', 'dir'), mkdir('images'); end
saveas(figure(1), 'images/downsample_random.png');
saveas(figure(2), 'images/downsample_grid.png');
