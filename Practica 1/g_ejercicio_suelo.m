% Detectar el plano del suelo asfáltico en un entorno exterior
% Uso de pcfitplane con vector director de referencia.

% Cargar la nube de puntos del escáner de la calle
pc = pcread('Practica 1/calle1.pcd');

% Definimos el vector normal esperado. 
% Sabemos que el suelo es horizontal, por tanto su perpendicular
% apunta completamente hacia arriba (eje Z).
vec = [0, 0, 1];

% Buscamos el plano. Dado que la calle tiene desniveles y ruido,
% ponemos una tolerancia de distancia alta (0.2 metros).
[plano_suelo, inIndicesSuelo, outIndicesSuelo] = pcfitplane(pc, 0.2, vec);

% Extraemos los puntos que pertenecen en exclusiva al suelo
superficie_suelo = select(pc, inIndicesSuelo);

% Visualización
figure('Name', 'Detección de Suelo en Entorno Exterior', 'NumberTitle', 'off');
pcshow(pc); 
hold on;
% Superponemos el modelo matemático del plano detectado
plot(plano_suelo, 'Color', [0, 1, 0]); % Lo pintamos de verde
title('Suelo detectado guiado por el vector Z [0, 0, 1]');
hold off;

% Guardar imagen para el README
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_suelo_calle.png');
