% Eliminar "outliers" (Denoising)
% Basado en las diapositivas sobre la función pcdenoise

% Cargar la nube de puntos 
pc = pcread('Practica 1/mesa.ply');

% --- 1. Denoise con parámetros por defecto ---
% Estima la media de la distancia a los k-vecinos más próximos (por defecto 4).
% Si es mayor a 1 desviación típica (Threshold por defecto), elimina el punto.
pc2 = pcdenoise(pc);

% --- 2. Denoise con parámetros personalizados ---
% Aquí se ajustan explícitamente el Threshold (Umbral) y el número de vecinos (NumNeighbors)
pc3 = pcdenoise(pc, 'Threshold', 0.5, 'NumNeighbors', 20);

% --- Opcional: Obtener los índices de los inliers y outliers ---
% [ptCloudOut,inlierIndices,outlierIndices] = pcdenoise(pc);


%% Visualización y Comparativa
% Se muestran las 3 nubes de puntos de izquierda a derecha.
figure('Name', 'Filtro Denoising', 'NumberTitle', 'off');

% Subplot 1: Nube Original (antes del filtro)
subplot(1,3,1);
pcshow(pc);
title('Original');

% Subplot 2: Denoise por defecto
subplot(1,3,2);
pcshow(pc2);
title('Denoise (Defecto)');

% Subplot 3: Denoise parametrizado
subplot(1,3,3);
pcshow(pc3);
title({'Denoise', '(Th: 0.5, NN: 20)'});

% Ajustamos un poco las proporciones de visualización
set(gcf, 'Position', [100, 100, 1200, 400]);

% Guardar la figura generada en la carpeta de imágenes para el README
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_denoise.png');
