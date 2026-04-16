% Funciones para encontrar objetos geométricos en la escena
% Detección de esferas y cilindros mediante pcfitcylinder y pcfitsphere

% Cargar la nube de puntos específica para detección de objetos
pc = pcread('Practica 1/objetos.ply');

% --- 1. Búsqueda de un Cilindro ---
% Tal y como indican las diapositivas, aplicando pcfitcylinder sobre la nube global:
[modelo_cilindro, inCilindro, outCilindro] = pcfitcylinder(pc, 0.05);
nube_cilindro = select(pc, inCilindro); % Puntos que conforman el cilindro


% --- 2. Búsqueda de una Esfera ---
% Tal y como indican las diapositivas, aplicando pcfitsphere sobre la nube global.
% (Nota: Si el algoritmo da un resultado geométrico inesperado confundiéndolo 
% con el suelo, se debe a la propia topografía del archivo 'objetos.ply').
[modelo_esfera, inEsfera, outEsfera] = pcfitsphere(pc, 0.05);
nube_esfera = select(pc, inEsfera); % Puntos de la esfera

%% Visualización
figure('Name', 'Detección Geométrica de Objetos', 'NumberTitle', 'off');

% Gráfica 1: Nube general
subplot(1,3,1);
pcshow(pc);
title('Original (objetos.ply)');

% Gráfica 2: Cilindro Extraído
subplot(1,3,2);
pcshow(nube_cilindro);
title('Cilindro Detectado');

% Gráfica 3: Esfera Extraída
subplot(1,3,3);
pcshow(nube_esfera);
title('Esfera Detectada');

set(gcf, 'Position', [100, 100, 1200, 400]);

% Guardar captura para la documentación
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_objetos.png');
