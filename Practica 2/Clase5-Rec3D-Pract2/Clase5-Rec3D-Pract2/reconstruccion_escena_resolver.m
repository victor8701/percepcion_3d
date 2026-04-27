clear all; close all; clc;

% Guardamos imagenes en Practica 2/images/ (mismo nivel que el README)
script_dir = fileparts(mfilename('fullpath'));
practica_dir = fileparts(fileparts(script_dir));
img_dir = fullfile(practica_dir, 'images');
if ~exist(img_dir, 'dir'), mkdir(img_dir); end

%% Cargar nube de puntos

% 1. Cargamos el array de nubes de puntos RGB-D de la sala
load('livingRoom.mat');  % carga la variable livingRoomData (cell array)

%% Alinear y fusionar dos nubes RGB-D

% 2. Cargamos las primeras dos nubes de la secuencia
n_referencia = livingRoomData{1};
n_nueva      = livingRoomData{2};

% 3. Bajamos la resolucion de ambas nubes (voxel de 10 cm)
%    Esto acelera el ICP y mejora la correspondencia entre puntos eliminando ruido
n_referencia_reducida = pcdownsample(n_referencia, 'gridAverage', 0.1);
n_nueva_reducida      = pcdownsample(n_nueva,      'gridAverage', 0.1);

% 4. Calculamos la transformacion para alinear n_nueva -> n_referencia con ICP
%    'pointToPlane': cada punto se proyecta sobre el plano tangente del mas cercano
%    Mas preciso que 'pointToPoint' para escenas con superficies planas (paredes, suelo)
transformacion = pcregistericp(n_nueva_reducida, n_referencia_reducida, ...
                               'Metric', 'pointToPlane', 'MaxIterations', 100);

% 5. Aplicamos la transformacion a la nube COMPLETA (sin reducir) para conservar detalle
n_nueva_transformada = pctransform(n_nueva, transformacion);

% 6. Fusionamos: voxel de 1.5 cm para el resultado
nubes_fusionadas = pcmerge(n_referencia, n_nueva_transformada, 0.015);

% 7. Mostramos los resultados de la fusion
figure
subplot(2,2,1)
imshow(n_referencia.Color)
title('Imagen de referencia')
drawnow

subplot(2,2,3)
imshow(n_nueva.Color)
title('Imagen a alinear')
drawnow

subplot(2,2,[2,4])
pcshow(nubes_fusionadas, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down')
title('Escena reconstruida inicial')
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)')
drawnow

saveas(gcf, fullfile(img_dir, 'fusion_dos_nubes.png'));

%% Alinear y fusionar una secuencia de nubes RGB-D

% IMPORTANTE: nubes_fusionadas ya contiene la fusion de las dos primeras nubes.
% Vamos a seguir añadiendo el resto de la secuencia una a una.

% 1. Guardamos la transformacion del ejercicio anterior como punto de partida
%    de la cadena de transformaciones acumuladas
transformacion_acumulada = transformacion;

% Abrimos una figura nueva donde actualizaremos la escena en tiempo real
figure
hAxes = pcshow(nubes_fusionadas, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down');
title('Escena fusionada')
hAxes.CameraViewAngleMode = 'auto';
hScatter = hAxes.Children;

for i = 3:length(livingRoomData)

    % 2. Cargamos la siguiente nube de la secuencia
    n_nueva = livingRoomData{i};

    % 3. La nube de referencia es la inmediatamente anterior
    %    (alineamos siempre entre nubes consecutivas, que se solapan mas)
    n_referencia = livingRoomData{i-1};

    % 4. Bajamos la resolucion de la nube nueva para el ICP
    n_nueva_reducida      = pcdownsample(n_nueva,      'gridAverage', 0.1);
    n_referencia_reducida = pcdownsample(n_referencia, 'gridAverage', 0.1);

    % 5. Calculamos la transformacion local: n_nueva -> n_referencia anterior
    transformacion = pcregistericp(n_nueva_reducida, n_referencia_reducida, ...
                                   'Metric', 'pointToPlane', 'MaxIterations', 100);

    % 6. Acumulamos la transformacion para llevar la nube al sistema de coordenadas
    %    de la nube inicial (no solo de la anterior).
    %    Multiplicar las matrices T encadena todas las transformaciones parciales.
    transformacion_acumulada = affine3d(transformacion.T * transformacion_acumulada.T);

    % 7. Aplicamos la transformacion acumulada a la nube completa (sin reducir)
    n_nueva_transformada = pctransform(n_nueva, transformacion_acumulada);

    % 8. Fusionamos la nube transformada con la escena acumulada
    nubes_fusionadas = pcmerge(nubes_fusionadas, n_nueva_transformada, 0.015);

    % 9. Actualizamos la visualizacion en tiempo real
    hScatter.XData = nubes_fusionadas.Location(:,1);
    hScatter.YData = nubes_fusionadas.Location(:,2);
    hScatter.ZData = nubes_fusionadas.Location(:,3);
    hScatter.CData = nubes_fusionadas.Color;
    drawnow('limitrate')

    pause(0.5);

    fprintf('Nube %d/%d fusionada\n', i, length(livingRoomData));
end

% El dataset se construyo con un Kinect mirando hacia abajo.
% Aplicamos una rotacion para dejar el suelo paralelo al plano X-Z
angle = -pi/10;
A = [1, 0,           0,          0; ...
     0, cos(angle),  sin(angle), 0; ...
     0, -sin(angle), cos(angle), 0; ...
     0, 0,           0,          1];
nubes_fusionadas = pctransform(nubes_fusionadas, affine3d(A));

pcshow(nubes_fusionadas, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down', ...
       'Parent', hAxes)
title('Escena fusionada')
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)')

saveas(gcf, fullfile(img_dir, 'reconstruccion_final.png'));
fprintf('\nReconstruccion completada.\n');
