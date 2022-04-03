%------------------------------------------------------
% Setup Lidar para trabajar con función callback
% Author- Fernando Gómez Bravo 
%07/07/2018
%-------------------------------------------

lidar=serial('COM4','baudrate',115200); 
set(lidar,'InputBufferSize',40000);

lidar.BytesAvailableFcnCount = 2134; %es el núemro de bytes recibidos en cada lectura
lidar.BytesAvailableFcnMode = 'byte';
lidar.BytesAvailableFcn = @mi_callback; %Configuración función de callback
fopen(lidar); %abre el puerto

%Configura el LIDAR

fprintf(lidar,'SCIP2.0');
pause(0.5);
char(fread(lidar, lidar.BytesAvailable,'char'))'
fprintf(lidar,'VV');
pause(0.5);
char(fread(lidar, lidar.BytesAvailable,'char'))'
fprintf(lidar,'BM');
pause(0.5);
char(fread(lidar, lidar.BytesAvailable,'char'))'

