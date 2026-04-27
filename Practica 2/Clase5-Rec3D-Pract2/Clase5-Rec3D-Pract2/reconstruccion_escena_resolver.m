clear all; close all; clc;

%% Cargar nube de puntos

% 1. Cargamos un array de nubes de puntos
% TO DO

%% Alinear y fusionar dos nubes RGB-D

% 2. Cargamos las primeras dos nubes de puntos de la secuencia
% TO DO

% 3. Bajar la resolución de las dos nubes de puntos. Agiliza el
%    procesamiento y mejora la correspondencia entre nubes (elimina ruido)
% TO DO

% 4. Calculamos la transformación para alinear las nubes de puntos
% TO DO

% 5. Aplicamos la transformación acumulada a la nueva nube de puntos
% TO DO

% 6. Unimos la nueva nube transformada con la nube resultado de la fusión
%    de todas las anteriores
% TO DO

% 7. Mostramos los resultados de la fusión

%--------------- DESCOMENTAR --------------
% figure
% subplot(2,2,1)
% imshow(n_referencia.Color)
% title('Imagen de referencia')
% drawnow
% 
% subplot(2,2,3)
% imshow(n_nueva.Color)
% title('Imagen a alinear')
% drawnow
% 
% % Mostramos la escena fusionada
% subplot(2,2,[2,4])
% pcshow(nubes_fusionadas, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down')
% title('Escena reconstruida inicial')
% xlabel('X (m)')
% ylabel('Y (m)')
% zlabel('Z (m)')
% drawnow
%--------------- HASTA AQUI --------------

%% Alinear y fusionar una secuencia de nubes RGB-D

% IMPORTANTE
% La variable nubes_fusionadas acumulará todas las nubes que se vayan
% uniendo. Contiene ya la fusión de las dos primeras nubes del apartado
% anterior

% 1. Guardar la transformación del ejercicio anterior en una variable donde
%    se irán acumulando las transformaciones que vayamos calculando
% TO DO


% Creamos una escena nueva donde mostraremos las nubes según se vayan
% fusionando
%--------------- DESCOMENTAR --------------
% figure
% hAxes = pcshow(nubes_fusionadas, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down');
% title('Escena fusionada')
% hAxes.CameraViewAngleMode = 'auto';
% hScatter = hAxes.Children;

%for i = 3:length(livingRoomData)
%--------------- HASTA AQUI --------------
    
% 2. Cargamos una nube de puntos nueva
   % TO DO
      
% 3. Usamos la nube de la interación/ejercicio anterior como referencia 
%    para alinear la nueva 
% TO DO

% 4. Bajamos la resolución de la nube nueva
% TO DO
  
% 5. Calculamos la transformación para alinear las nubes de puntos
% TO DO

% 6. Construimos una transformada que incluya las transformaciones
% anteriores. Esto servirá para llevar la nube actual al sistema de
% coordenadas definido por la nube inicial
% TO DO
  
% 7. Aplicamos la transformación acumulada a la nueva nube de puntos
% TO DO
   
% 8. Unimos la nueva nube transformada con la nube resultado de la fusión
% de todas las anteriores
% TO DO

% 9. Actualizamos la escena
%--------------- DESCOMENTAR --------------

%     hScatter.XData = nubes_fusionadas.Location(:,1);
%     hScatter.YData = nubes_fusionadas.Location(:,2);
%     hScatter.ZData = nubes_fusionadas.Location(:,3);
%     hScatter.CData = nubes_fusionadas.Color;
%     drawnow('limitrate')
%     
%     % Pausamos la ejecución para mejorar la visualización
%     pause(1);
%  end
%--------------- HASTA AQUI --------------

% El dataset se construyó con un Kinect mirando hacia abajo. Para mejorar
% la visualización de lso resultados, vamos a aplicar una trasnformación a
% los datos para dejar el plano del suelo paralelo al plano X-Z

%--------------- DESCOMENTAR --------------
% angle = -pi/10;
% A = [1,0,0,0;...
%      0, cos(angle), sin(angle), 0; ...
%      0, -sin(angle), cos(angle), 0; ...
%      0 0 0 1];
% nubes_fusionadas = pctransform(nubes_fusionadas, affine3d(A));
% pcshow(nubes_fusionadas, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down', ...
%         'Parent', hAxes)
% title('Escena fusionada')
% xlabel('X (m)')
% ylabel('Y (m)')
% zlabel('Z (m)')
%--------------- HASTA AQUI --------------
