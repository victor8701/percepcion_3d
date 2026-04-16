% =========================================================================
% DESAFÍO 1: Aislar el teléfono de la escena iterativamente
% =========================================================================

% BLOQUEO DE LA SEMILLA: MSAC/RANSAC es un algoritmo estadístico aleatorio. 
% Si no bloqueamos la semilla matemática, un pequeño cambio en la muestra 
% de puntos aleatorios hace que la pared se coma al teléfono entre ejecuciones.
rng(5); % Forzamos a que el sistema devuelva SIEMPRE los mismos puntos aleatorios

% 1. Cargar nube de puntos original
scriptDir = fileparts(mfilename('fullpath'));
rutaNube = fullfile(scriptDir, '..', 'Practica 1', 'objetos.ply');
pc = pcread(rutaNube); 

disp('1. Nube de objetos original cargada.');

% --- Fase Angular: Recorte Geométrico Secuencial ---
% 2. Mesa/Suelo
[~, ~, out1] = pcfitplane(pc, 0.02);
resto = select(pc, out1);

% 3. Primera pared
[~, ~, out2] = pcfitplane(resto, 0.02);
resto = select(resto, out2);

% 4. Segunda pared
[~, ~, out3] = pcfitplane(resto, 0.02);
resto = select(resto, out3);

% 5. Cilindro
[~, ~, outCil] = pcfitcylinder(resto, 0.02);
resto = select(resto, outCil);

% 6. Esfera 
[~, ~, outEsf] = pcfitsphere(resto, 0.02);
nube_sucia = select(resto, outEsf); 

% 7. Extracción Final
[labels, ~] = pcsegdist(nube_sucia, 0.03); 
val_freq = mode(labels); % Aislar el cluster principal
idx_telefono = find(labels == val_freq);
nube_telefono = select(nube_sucia, idx_telefono);

disp('2. Teléfono extraído con éxito.');

% =========================================================================
% Visualización del Resultado Final
% =========================================================================
figure('Name', 'Desafío 1: Teléfono Aislado', 'NumberTitle', 'off');

% Gráfica 1: Original
subplot(1, 3, 1);
pcshow(pc);
title('Escena Original');

% Gráfica 2: Teléfono extraído (MATLAB hace auto-zoom a este bloque)
subplot(1, 3, 2);
pcshow(nube_telefono); 
title('Teléfono Aislado (Auto-Zoom)');

% Gráfica 3: Teléfono extraído pero con la cámara en las coordenadas originales
subplot(1, 3, 3);
pcshow(nube_telefono);
xlim(pc.XLimits);
ylim(pc.YLimits);
zlim(pc.ZLimits);
title('Teléfono (Ejes de la Escena)');

set(gcf, 'Position', [100, 100, 1500, 500]);

% Guardar captura asegurando que se crea en el directorio correcto
imageFolder = fullfile(scriptDir, 'images');
if ~exist(imageFolder, 'dir'), mkdir(imageFolder); end
saveas(gcf, fullfile(imageFolder, 'resultado_telefono.png'));
disp('Resultados graficados y guardados.');
