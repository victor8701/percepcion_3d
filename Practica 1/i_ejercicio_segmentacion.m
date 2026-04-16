% Segmentación por distancia
% Uso de pcsegdist para agrupar puntos separados físicamente en el espacio

% Cargar nube de puntos que contiene elementos separados
pc = pcread('Practica 1/esferas_2.ply');

% Definimos la distancia mínima (umbral) de vacío que tiene que haber 
% entre dos puntos para que el algoritmo considere que son objetos distintos.
minDistance = 0.5;

% Segmentamos. Esto nos devuelve una etiqueta (identificador de grupo) 
% para que cada punto y el conteo del número total de grupos detectados.
[labels, numClusters] = pcsegdist(pc, minDistance);


%% Visualización
figure('Name', 'Segmentación por Clústeres de Distancia', 'NumberTitle', 'off');

% Gráfica 1: Nube original
subplot(1,3,1);
pcshow(pc);
title('Original (esferas_2.ply)');

% Gráfica 2: Todos los objetos segmentados y coloreados por Matlab automáticamente
subplot(1,3,2);
% Pasándole los 'labels' Matlab aplica internamente un colormap distinto por clúster
pcshow(pc.Location, labels); 
colormap(hsv(numClusters));
title(['Objetos (Grupos): ' num2str(numClusters)]);

% Gráfica 3: Aislamiento manual físico de un objeto concreto
subplot(1,3,3);
pc1 = select(pc, find(labels == 1)); % Extraemos únicamente los puntos del Grupo 1
% pc2 = select(pc, find(labels == 2)); % Opcional para ver el Grupo 2
pcshow(pc1);
title('Objeto #1 Aislado');

set(gcf, 'Position', [100, 100, 1200, 400]);

% Guardar captura para la documentación
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_segmentacion.png');
