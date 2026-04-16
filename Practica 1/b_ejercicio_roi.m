% indices = findPointsInROI(ptCloud,roi)

% Se ajusta la ruta a la subcarpeta donde está el archivo mesa.ply
pc = pcread('Practica 1/mesa.ply');

roi = [-1, 0; -0.2, 0.4; -1.8, -1.2];
indices = findPointsInROI(pc, roi);
pc2 = select(pc, indices);

pcshow(pc.Location, 'r');
hold on;
pcshow(pc2.Location, 'g');
hold off;

% Guardar imagen para el README
if ~exist('images', 'dir'), mkdir('images'); end
saveas(gcf, 'images/ejercicio_roi.png');
