%{
Lee y dibuja los datos del LIDAR, además de mover las patas que intervienen
en el salto de acuerdo al obstáculo encontrado.

--------------------------------------------------
Alejandro Garrocho Cruz
%}
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
handle.s = serialport("COM4",9600,"Timeout", 5);
configureTerminator(handle.s,"CR/LF");
flush(handle.s);
handle.s.UserData = struct("Data",[],"Count",1);
%------------------------------------------------
 fprintf(lidar,'GD0044072500'); %pide al lidar entregar lectura 
 pause(1);
%----------------------
matriz_datos=[];
inicio_obs=1000;
final_obs=1000;
N_obs=0;
N_obs_saltados=0;
duracion=30;

write(handle.s,2,'uint8');
        
while (tiempo<duracion) % el experimento tiene una duracion determinada
    plotear_laser_handles(rangescan,handles)
    
    if (N_obs == N_obs_saltados)
        while (final_obs ==1000 || inicio_obs == 1000)
            for i=266:416
                if (rangescan(266)<500 && inicio_obs == 1000) % LADO DERECHO
                    inicio_obs=266;

                elseif (rangescan(i) - rangescan(i+3) > 50  && inicio_obs == 1000) 
                    inicio_obs=i;
                end
            

                if (rangescan(i) - rangescan(i-3) > 50 && final_obs == 1000)
                    final_obs=i;

                elseif (rangescan(416)<500 && final_obs == 1000)
                    final_obs=416;
                end
            end
        end
    
        if (inicio_obs~=1000 && final_obs~=1000 && N_obs == N_obs_saltados)
            N_obs=N_obs+1;
        end

        if (inicio_obs <292) %24
           if (final_obs<292)
               pause(16);
               write(handle.s,24,'uint8');
               pause(13);
               write(handle.s,34,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;

               inicio_obs=1000;
               final_obs=1000;
               
           elseif(final_obs<356) %19, 24, 23
               pause(10);
               write(handle.s,19,'uint8');
               pause(13);
               write(handle.s,29,'uint8');
               pause(1);
               write(handle.s,24,'uint8');
               pause(7);
               write(handle.s,34,'uint8');
               pause(1);
               write(handle.s,23,'uint8');
               pause(7);
               write(handle.s,33,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;

               inicio_obs=1000;
               final_obs=1000;
               
           elseif(final_obs<390)   % 19 y 20, 24, 22 y 23
               pause(10);
               write(handle.s,7,'uint8');
               pause(10);
               write(handle.s,8,'uint8');
               pause(6);
               write(handle.s,24,'uint8');
               pause(2);
               write(handle.s,34,'uint8');
               pause(1);
               write(handle.s,6,'uint8');
               pause(10);
               write(handle.s,8,'uint8');
               pause(5);
               N_obs_saltados=N_obs_saltados+1;
 
               inicio_obs=1000;
               final_obs=1000;
                          
           elseif(final_obs<=416)  %Todas
               pause(10);
               write(handle.s,7,'uint8');
               pause(10);
               write(handle.s,8,'uint8');
               pause(6);
               write(handle.s,24,'uint8');
               pause(0.1);
               write(handle.s,21,'uint8');
               pause(5);
               write(handle.s,34,'uint8');
               pause(0.1);
               write(handle.s,31,'uint8');
               pause(1);
               write(handle.s,6,'uint8');
               pause(10);
               write(handle.s,8,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;

               inicio_obs=1000;
               final_obs=1000;
               
           end
           
           
        elseif (inicio_obs<330 && inicio_obs>=292) 
               
           if(final_obs<356) %19, 23
               pause(10);
               write(handle.s,19,'uint8');
               pause(2);
               write(handle.s,29,'uint8');
               pause(1);
               write(handle.s,23,'uint8');
               pause(2);
               write(handle.s,33,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;
               
               inicio_obs=1000;
               final_obs=1000;
               
           elseif(final_obs<390)   %19 y 20, 22 y 23
               pause(10);
               write(handle.s,7,'uint8');
               pause(15);
               write(handle.s,8,'uint8');
               pause(23);
               write(handle.s,6,'uint8');
               pause(15);
               write(handle.s,8,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;

               inicio_obs=1000;
               final_obs=1000;
                          
           elseif(final_obs<=416)  %19 y 20, 21, 22 y 23
               pause(10);
               write(handle.s,7,'uint8');
               pause(10);
               write(handle.s,8,'uint8');
               pause(6);
               write(handle.s,21,'uint8');
               pause(2);
               write(handle.s,31,'uint8');
               pause(1);
               write(handle.s,6,'uint8');
               pause(10);
               write(handle.s,8,'uint8');
               pause(4);  
               N_obs_saltados=N_obs_saltados+1;

               inicio_obs=1000;
               final_obs=1000;
               
           end
            
        elseif(inicio_obs>=330 && inicio_obs<390)
           if(final_obs>356 && final_obs<390)   %20, 22
               pause(10);
               write(handle.s,20,'uint8');
               pause(2);
               write(handle.s,30,'uint8');
               pause(1);
               write(handle.s,22,'uint8');
               pause(2);
               write(handle.s,32,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;
               
               inicio_obs=1000;
               final_obs=1000;
               
           elseif(final_obs>356 && final_obs<=416)  %20, 21, 22
               pause(10);
               write(handle.s,20,'uint8');
               pause(2);
               write(handle.s,30,'uint8');
               pause(1);
               write(handle.s,21,'uint8');
               pause(2);
               write(handle.s,31,'uint8');
               pause(1);
               write(handle.s,22,'uint8');
               pause(2);
               write(handle.s,32,'uint8');
               pause(1);
               N_obs_saltados=N_obs_saltados+1;
               
               inicio_obs=1000;
               final_obs=1000;
               
           end 
            
        elseif (inicio_obs >= 390)   %21  
           pause(16);
           write(handle.s,21,'uint8');
           pause(13);
           write(handle.s,31,'uint8');
           pause(1);
           N_obs_saltados=N_obs_saltados+1;

           inicio_obs=1000;
           final_obs=1000;
           
        end
    end
    
    matriz_datos=[matriz_datos;rangescan];
end


write(handle.s,0,'uint8');

%save 'SaltosDoble.dat' matriz_datos '-ascii'
cerrar_puerto  