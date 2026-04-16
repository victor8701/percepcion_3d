% =========================================================================
% DESAFÍO 1: Aislar el teléfono de la escena iterativamente
% =========================================================================

% 1. Cargar nube de puntos original
% Obtenemos la ruta donde reside este propio script para evitar fallos de MATLAB
scriptDir = fileparts(mfilename('fullpath'));
rutaNube = fullfile(scriptDir, '..', 'Practica 1', 'objetos.ply');
pc = pcread(rutaNube); 

disp('1. Nube de objetos original cargada.');

% --- Fase Angular: Recorte Geométrico Secuencial ---

% 2. Quitar Plano 1 (Suelo/Mesa) - Tolerancia equilibrada (2 cm)
[~, ~, out1] = pcfitplane(pc, 0.02);
resto = select(pc, out1);
disp('2. Mesa/Suelo eliminado.');

% 3. Quitar Plano 2 (Pared de fondo)
[~, ~, out2] = pcfitplane(resto, 0.02);
resto = select(resto, out2);
disp('3. Primera pared eliminada.');

% 4. Quitar Plano 3 (Segunda lateral o superficie secundaria)
[~, ~, out3] = pcfitplane(resto, 0.02);
resto = select(resto, out3);
disp('4. Segunda pared eliminada.');

% 5. Quitar Cilindro (bote)
[~, ~, outCil] = pcfitcylinder(resto, 0.02);
resto = select(resto, outCil);
disp('5. Cilindro u objeto tubular eliminado.');

% 6. Quitar Esfera (pelota)
[~, ~, outEsf] = pcfitsphere(resto, 0.02);
nube_sucia = select(resto, outEsf); 

% --- Mejora de Calidad Computacional ---
% Al aplicar RANSAC puramente geométrico, siempre quedan algunas 'chispas'
% flotando (ruido residual) que desastabilizan visualmente al sujeto restante.
% 7. Segmentación final: nos quedamos solo con la masa contigua principal.
[labels, numClusters] = pcsegdist(nube_sucia, 0.03); 
val_freq = mode(labels); % Hallar el grupo numérico que posee más puntos
idx_telefono = find(labels == val_freq);
nube_telefono = select(nube_sucia, idx_telefono);

disp('6. Esfera eliminada. Teléfono destilado del ruido flotante.');

% =========================================================================
% Visualización del Resultado Final
% =========================================================================
figure('Name', 'Desafío 1: Teléfono Aislado', 'NumberTitle', 'off');

subplot(1, 2, 1);
pcshow(pc);
title('Escena Original');

subplot(1, 2, 2);
pcshow(nube_telefono); % Al haber cribado todas las geometrías puras, queda la irregular (teléfono)
title('Teléfono Aislado (Residuo)');

set(gcf, 'Position', [100, 100, 1000, 500]);

% Guardar captura asegurando que se crea en el directorio correcto
imageFolder = fullfile(scriptDir, 'images');
if ~exist(imageFolder, 'dir'), mkdir(imageFolder); end
saveas(gcf, fullfile(imageFolder, 'resultado_telefono.png'));
disp('Resultados graficados y guardados.');
