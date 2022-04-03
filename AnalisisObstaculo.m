%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de lectura del laser Hokuyo y representación de las medidas usando
% manejadores. Hay que definir inicialmente 682, uno para cada medida
% La lectura del Lidar se hace mediante la funcion de callback mi_callback
% que lee los datos del buffer cuando se han recibido los bytes
% correspondientes, guardarlos en la variable global rangescan y se encarga
% de pedir una nueva lectura de datos
% 
%--------------------------------------------------
% F Gomez Bravo 07/07/18
%--------------------------------------------------
clear all
clc

global rangescan %variable que contiene las medidas del lidar se actualiza 
                 % en la función callback mi_callback.m 

%-----------------------------------------------------------------------------
SetupLidar_callback %Inicializa el puerto configurando la función de callback
%---------------------------------------------------------------------------


%definición de los handles para representar las medidas del lidar
 handles(1:682) = plot(0,'Erasemode','xor'); 
 grid on
 axis ([-1000 1000 -1000 1000]);
 global tstart;
 global tiempo;
 
 tstart=tic;
%------------------------------------------------
handle.s = serialport("COM5",9600,"Timeout", 5);
configureTerminator(handle.s,"CR/LF");
flush(handle.s);
handle.s.UserData = struct("Data",[],"Count",1);
%------------------------------------------------
% primera lectura del lidar
% Al arrancar la función del callback el puerto se queda ocupado
% constantemente ya que en la esa función se vuelve a mandar la petición de
% datos al lidar
 fprintf(lidar,'GD0044072500'); %pide al lidar entregar lectura 
 pause(1);
%----------------------
matriz_datos=[];
distancia=1000; 
distancia_min=1000;
distancia_real=1000;
obs1=0;

while (tiempo<60) % el experimento dura 60 SEG
    %plotear_laser_handles(rangescan,handles)
    if (rangescan(341) < 450 && rangescan(341) > 250) %Encuentra obstaculo
        distancia=rangescan(341);
        write(handle.s,1,'uint8');
        
        if (distancia < distancia_min)
            distancia_min=distancia;
        end
                 
    elseif (rangescan(341) <= 250) %Obstaculo no visto
        write(handle.s,0,'uint8');
        
    elseif (rangescan(341)>=500 && distancia_min ~= 1000)
        if (obs1==0)
            tiempo_jump = toc(tstart);
            obs1=1;
        end
        
        distancia_real=cos(35*pi/180)*distancia_min; %distancia_min es la hipotenusa
        tiempo_salto=distancia_real/30.7; %tiempo=distancia/velocidad (velocidad de 11.3 mm/s)
            
        if (tiempo-tiempo_jump > tiempo_salto-2)
            write(handle.s,5,'uint8');
            distancia_min=1000;
        end

    else
        write(handle.s,2,'uint8');
    end
    matriz_datos=[matriz_datos;rangescan];
end

%%%%%%save 'SaltaObstaculo.dat' matriz_datos '-ascii'

%----------------------
% Se cierra el puerto para que no se quede funcionando la función 
% de calback
 cerrar_puerto  
 clear all
 clc
% DisconnectLidar
%--------------------------
%Cálculo del diferencial de tiempo
%%%%%%% dt=tiempo(2:end)-tiempo(1:end-1);