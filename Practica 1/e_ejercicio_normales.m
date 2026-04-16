% Obtener las normales a la superficie
% Uso de pcnormals y representación de vectores con quiver3

% Carga de la nube de puntos
pc = pcread('Practica 1/mesa.ply');

% Calcular las normales (por defecto usa 6 puntos vecinos para aproximar el plano local)
normals = pcnormals(pc);

% Visualización inicial de la nube
figure('Name', 'Normales de la Superficie', 'NumberTitle', 'off');
pcshow(pc);
title('Nube con Normales de Superficie Estimadas');
hold on;

% Para no sobrecargar la gráfica con demasiadas flechas, 
% seleccionaremos y pintaremos 1 de cada 100 normales
paso = 100;

% Extraemos las coordenadas espaciales X, Y, Z de esos puntos seleccionados
x = pc.Location(1:paso:end, 1);
y = pc.Location(1:paso:end, 2);
z = pc.Location(1:paso:end, 3);

% Extraemos las componentes direccionales U, V, W del vector normal 
u = normals(1:paso:end, 1);
v = normals(1:paso:end, 2);
w = normals(1:paso:end, 3);

% Dibujamos las flechas usando quiver3 encima de la nube de puntos.
% El parámetro "2" ajusta la longitud/escala visual de la flecha.
quiver3(x, y, z, u, v, w, 2);
hold off;

% Guardar la figura generada en la carpeta de imágenes para el README
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_normales.png');
