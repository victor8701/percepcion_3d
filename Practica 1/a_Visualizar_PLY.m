% Script para abrir y visualizar todos los archivos .ply
% Busca de forma recursiva en la carpeta actual y sus subcarpetas.

% Obtener la lista de todos los archivos .ply
ply_files = dir('**/*.ply');

if isempty(ply_files)
    disp('No se encontraron archivos .ply en este directorio ni en sus subdirectorios.');
else
    disp(['Se encontraron ', num2str(length(ply_files)), ' archivos .ply. Abriendo...']);
    
    for i = 1:length(ply_files)
        % Ruta completa del archivo actual
        file_path = fullfile(ply_files(i).folder, ply_files(i).name);
        
        % Leer la nube de puntos
        ptCloud = pcread(file_path);
        
        % Mostrar la nube de puntos en una nueva figura
        figure('Name', ply_files(i).name, 'NumberTitle', 'off');
        pcshow(ptCloud);
        
        % Configurar la vista
        title(ply_files(i).name, 'Interpreter', 'none');
        xlabel('X'); ylabel('Y'); zlabel('Z');
        
        % Mensaje en la consola
        disp(['Abierto: ', ply_files(i).name]);
    end
    
    disp('Todos los archivos .ply han sido abiertos.');
end
