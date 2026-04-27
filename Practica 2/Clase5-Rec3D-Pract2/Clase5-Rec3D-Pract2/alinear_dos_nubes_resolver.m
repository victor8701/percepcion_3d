%% Cargamos la nube de puntos y la mostramos

clear all;close all;clc; % Limpiamos el espacio de trabajo


% 1. Cargamos la nube de puntos
% TO DO

% 2. Mostramos la nube cargada
% TO DO

%% Transformamos la nube de puntos y comparamos

% 3. Creamos la matriz de transformación
% TO DO

% 4. Creamos la transformación                                    
% TO DO

% 5. Aplicamos la transformación a la nube de puntos original para
% conseguir una nube transformada
% TO DO

% 6. Mostramos las diferencias entre las nubes de puntos
figure;
% TO DO


%% Alineamos las nubes y las fusionamos

% 7. Calculamos la transformación para alinear las nubes de puntos
% TO DO

% 8. Aplicamos la transformación 3D sobre la segunda nube de puntos
% TO DO

% 9. Mostramos las diferencias entre la nube original y la nube alineada.
% Con una alineación perfecta, no deberían verse diferencias
% TO DO

fprintf('Nubes fusionadas, las diferencias se verían en 2 colores. \nSi solo aparece un color, el alineamiento es perfecto\n\n');

%% Mostramos las transformaciones original y calculada

fprintf('Comparamos las transformaciones. \nTransformación original\n');
disp(transformacion.T);

fprintf('\nTransformación inversa calculada automáticamente. \n');
tform2 = invert(transformacion_calculada);
disp(tform2.T);