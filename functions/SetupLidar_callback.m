%{
Setup Lidar para trabajar con funci�n callback

Alejandro Garrocho Cruz
%}

lidar=serial('COM4','baudrate',115200); 
set(lidar,'InputBufferSize',40000);

lidar.BytesAvailableFcnCount = 2134; %es el n�mero de bytes recibidos en cada lectura
lidar.BytesAvailableFcnMode = 'byte';
lidar.BytesAvailableFcn = @mi_callback; %Configuraci�n funci�n de callback
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

