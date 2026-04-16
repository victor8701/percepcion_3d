% Encontrar y ajustar planos geométricos
% Uso del algoritmo pcfitplane (MSAC / RANSAC mejorado)

%% PARTE 1: Búsqueda iterativa de planos
% Ideal para buscar múltiples superficies en un objeto ruidoso
pc = pcread('Practica 1/mesa.ply');

% 1. Encontrar el plano principal (Tolerancia a distancia 0.05)
[plano1, in1, out1] = pcfitplane(pc, 0.05);
nube_plano1 = select(pc, in1); % Puntos pertenecientes al plano
resto = select(pc, out1);      % Puntos no pertenecientes al plano

% 2. Encontrar el segundo plano más predominante descartando los puntos del primero
[plano2, in2, out2] = pcfitplane(resto, 0.05);
nube_plano2 = select(resto, in2);
resto2 = select(resto, out2);

% Visualización 
figure('Name', 'Búsqueda Iterativa de Planos', 'NumberTitle', 'off');
subplot(1,3,1); pcshow(pc); title('Original');
subplot(1,3,2); pcshow(nube_plano1); title('1º Plano (Mayor)');
subplot(1,3,3); pcshow(nube_plano2); title('2º Plano (Subyacente)');
set(gcf, 'Position', [100, 100, 1200, 400]);

% Guardar imagen para el README
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_planos_mesa.png');


% Final de script
