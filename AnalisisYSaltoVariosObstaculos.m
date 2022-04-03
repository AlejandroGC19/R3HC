%{
Lee y dibuja los datos del LIDAR, mientras analiza y sobrepasa los
obstáculos que se encuentran en su trayectoria.

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
distancia=1000; 
distancia_min=1000;
distancia_real=1000;
tiempo_prof=0;
obs_fin=0;
Nobs=0;
aux=0;
aux2=0;
arriba=0;
cont=0;
stop=0;
obst_saltados=0;

while (tiempo<60) % el experimento dura 60 SEG
    plotear_laser_handles(rangescan,handles)
    if ((rangescan(341) < 500 && rangescan(341) > 250 && obs_fin==0) || (distancia_min<500 && distancia_min>480 && obs_fin==0)) %Encuentra obstaculo
        if (distancia_min==1000)
            Nobs=Nobs+1; %Numero de obstaculos encontrados
            tiempo_obs_visto=toc(tstart);
            distancia=rangescan(341);
            distancia_real=cos(35*pi/180)*distancia; %distancia_min es la hipotenusa
            tiempo_tojump=distancia_real/11.3; %tiempo=distancia/velocidad (velocidad de 11.3 mm/s)           
            tiempo_alt=toc(tstart);
        end
        write(handle.s,1,'uint8');
        
                
        if (rangescan(341) < distancia_min)
            distancia_min=rangescan(341);
            cont=0;
        elseif (rangescan(341) <= distancia_min+5)
            cont=cont+1;
        end
        
        if (cont>=3)
            tiempo_prof=toc(tstart);
            cont=0;
        end
                 
    elseif (rangescan(341) <= 250 || stop==1) %Obstaculo imprevisto
        write(handle.s,0,'uint8');
        stop=1;
        
    elseif (rangescan(341)>=540 && Nobs>obst_saltados)
        if (obs_fin==0)
            tiempo_obsfin = toc(tstart);
            prof=11.3*(tiempo_obsfin-tiempo_prof); %La profundidad es 11.3 mm/s * tiempo -tiempo_prof (s)            
            obs_fin=1;
        end
        
        
        if (tiempo-tiempo_obs_visto > tiempo_tojump-2)
            if (arriba==0)
                write(handle.s,19,'uint8');
                
                arriba=1;
                pause(8);
                %pause(prof/10); %tiempo para saltar el objeto hasta bajar la pata
            end
            if (arriba==1)
                write(handle.s,29,'uint8');
                pause(2);
                distancia_min=1000;
                obs_fin=0;
                arriba=0;
                obst_saltados=obst_saltados+1;
            end          
        end
        
    else
        write(handle.s,2,'uint8');
    end
    matriz_datos=[matriz_datos;rangescan];
end




% 
% while (tiempo<30) % el experimento dura 60 SEG
%     plotear_laser_handles(rangescan,handles)
%     if (rangescan(341) < 450 && rangescan(341) > 250) %Encuentra obstaculo
%         if (aux==1)
%             Nobs=Nobs+1; %Numero de obstaculos encontrados
%             %tiempo_alt=toc(tstart);
%         end
%         
%         distancia=rangescan(341);
%         write(handle.s,1,'uint8');
%         aux=0;
%         
%         if (distancia < distancia_min)
%             distancia_min=distancia;
%         else 
%             cont=cont+1;
%             if (cont >= 1 && aux2==0)
%                  tiempo_prof=toc(tstart);
%                  aux2=1;
%             end
%         end
%                  
%     elseif (rangescan(341) <= 250) %Obstaculo no visto
%         write(handle.s,0,'uint8');
%         
%     elseif (rangescan(341)>=500 && distancia_min ~= 1000)
%         
%         if (obs_fin==0)
%             tiempo_jump = toc(tstart);
%             distancia_real=cos(35*pi/180)*distancia_min; %distancia_min es la hipotenusa
%             tiempo_salto=distancia_real/11.3; %tiempo=distancia/velocidad (velocidad de 11.3 mm/s)           
% 
%             prof=11.3*(tiempo_jump-tiempo_prof); %La proundidad es 11.3 mm/s * tiempo -tiempo_prof (s)            
%             obs_fin=1;
%         end
%         
%         
%         if (tiempo-tiempo_jump > tiempo_salto-17)
%             if (arriba==0)
%                 write(handle.s,19,'uint8');
%                 arriba=1;
%                 pause(8);
%                 %pause(prof); %tiempo para saltar el objeto hasta bajar la pata
%             else
%                 write(handle.s,29,'uint8');
%                 distancia_min=1000;
%                 aux=0;
%                 aux2=0;
%                 obs_fin=0;
%                 aux3=1;
%                 arriba=0;
%             end
% %                 write(handle.s,24,'uint8');
% %                 pause(prof); %tiempo para saltar el objeto hasta bajar la pata
% %                 write(handle.s,34,'uint8');
% % 
% %                 write(handle.s,23,'uint8');
% %                 pause(prof); %tiempo para saltar el objeto hasta bajar la pata
% %                 write(handle.s,33,'uint8');           
% 
%             
%         end
%         
%     else
%         write(handle.s,2,'uint8');
%     end
%     matriz_datos=[ matriz_datos;rangescan];
% end

write(handle.s,0,'uint8');
%save 'SaltosNew.dat' matriz_datos '-ascii'
% cerrar_puerto  