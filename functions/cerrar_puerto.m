%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Descconecta el lidar y cierra el puerto
%07/07/2018
%--------------------------

fprintf(lidar,'QT');
fclose(lidar)
delete(lidar)
clear lidar
%clear all