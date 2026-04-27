%% Cargamos la nube de puntos y la mostramos

clear all; close all; clc;

% Ruta absoluta de la carpeta del script para guardar imagenes correctamente
script_dir = fileparts(mfilename('fullpath'));
img_dir = fullfile(script_dir, 'images');
if ~exist(img_dir, 'dir'), mkdir(img_dir); end

% 1. Cargamos la nube de puntos
nube1 = pcread('cow.ply');

% 2. Mostramos la nube cargada
figure;
pcshow(nube1);
title('Nube original (cow.ply)');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');

%% Transformamos la nube de puntos y comparamos

% 3. Creamos la matriz de transformacion (4x4 homogenea)
% En MATLAB la traslacion va en la ULTIMA FILA (no columna)
% Aplicamos: traslacion (3, 3, 0) + rotacion 45 grados alrededor del eje Z
theta = pi / 4; % 45 grados en radianes
matriz_transformacion = [cos(theta),  sin(theta), 0, 0; ...
                         -sin(theta), cos(theta), 0, 0; ...
                          0,          0,          1, 0; ...
                          3,          3,          0, 1];

% 4. Creamos la transformacion como objeto affine3d
transformacion = affine3d(matriz_transformacion);

% 5. Aplicamos la transformacion a la nube original para obtener nube2
nube2 = pctransform(nube1, transformacion);

% 6. Mostramos las diferencias entre las nubes (aparecen en 2 colores)
figure;
pcshowpair(nube1, nube2);
title('Nubes SIN alinear (2 colores = desplazadas)');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');
saveas(gcf, fullfile(img_dir, 'alineamiento_sin.png'));

%% Alineamos las nubes y las fusionamos

% 7. ICP calcula automaticamente la transformacion inversa para alinear nube2 -> nube1
transformacion_calculada = pcregistericp(nube2, nube1, 'Metric', 'pointToPlane', 'MaxIterations', 100);

% 8. Aplicamos la transformacion calculada sobre nube2
nube2_alineada = pctransform(nube2, transformacion_calculada);

% 9. Mostramos el resultado: si el alineamiento es perfecto, un solo color
figure;
pcshowpair(nube1, nube2_alineada);
title('Nubes alineadas con ICP (1 color = alineamiento perfecto)');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');
saveas(gcf, fullfile(img_dir, 'alineamiento_con.png'));

fprintf('Nubes fusionadas, las diferencias se veran en 2 colores. \nSi solo aparece un color, el alineamiento es perfecto\n\n');

%% Mostramos las transformaciones original y calculada

fprintf('Comparamos las transformaciones. \nTransformacion original\n');
disp(transformacion.T);

fprintf('\nTransformacion inversa calculada automaticamente. \n');
tform2 = invert(transformacion_calculada);
disp(tform2.T);

%% Test con ruido: comprobamos como afecta al alineamiento ICP

niveles_ruido = [0.1, 0.5, 1.0];
figure;

for k = 1:length(niveles_ruido)
    nivel = niveles_ruido(k);

    % Añadimos ruido a la nube transformada
    nube2_con_ruido = add_noise_to_pointCloud(nube2, nivel);

    % Intentamos alinear la nube ruidosa con ICP
    tform_ruido = pcregistericp(nube2_con_ruido, nube1, 'Metric', 'pointToPlane', 'MaxIterations', 100);
    nube2_ruido_alineada = pctransform(nube2_con_ruido, tform_ruido);

    % Mostramos el resultado en un subplot
    subplot(1, 3, k);
    pcshowpair(nube1, nube2_ruido_alineada);
    title(sprintf('Ruido = %.1f', nivel));
    xlabel('X'); ylabel('Y'); zlabel('Z');
end

sgtitle('Efecto del ruido sobre el alineamiento ICP');
saveas(gcf, fullfile(img_dir, 'alineamiento_ruido.png'));

fprintf('\nTest de ruido completado. A mayor nivel de ruido, peor alineamiento.\n');
