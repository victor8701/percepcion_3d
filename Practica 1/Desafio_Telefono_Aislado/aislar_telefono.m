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

% 2. Quitar Plano 1 (Suelo/Mesa) - Bajamos la tolerancia drásticamente a 0.01
[~, ~, out1] = pcfitplane(pc, 0.015);
resto = select(pc, out1);
disp('2. Mesa/Suelo eliminado.');

% 3. Quitar Plano 2 (Pared de fondo)
[~, ~, out2] = pcfitplane(resto, 0.015);
resto = select(resto, out2);
disp('3. Primera pared eliminada.');

% 4. Quitar Plano 3 (Segunda pared lateral)
[~, ~, out3] = pcfitplane(resto, 0.015);
resto = select(resto, out3);
disp('4. Segunda pared eliminada.');

% 5. Quitar Cilindro
[~, ~, outCil] = pcfitcylinder(resto, 0.015);
resto = select(resto, outCil);
disp('5. Cilindro u objeto tubular eliminado.');

% 6. Quitar Esfera
[~, ~, outEsf] = pcfitsphere(resto, 0.015);
nube_telefono = select(resto, outEsf); 
disp('6. Esfera eliminada. Extrayendo el residuo (Teléfono).');

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
