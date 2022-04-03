function mi_callback(obj, event)
% mi_callback(obj, event) Lee datos del lidar cuando el bufer tiene el 
% número de bits adecuado 2134
% al configurar el puerto sewrie hay que establecer el valor;
%        lidar.BytesAvailableFcnCount = 2134 
% Una vez lee los datos los convierte a caracteres ASCII y los guarda en
% la variable global rangescan.
% Seguidamente vuelve a mandar un mensaje al LIDAR para pèdir otra lectura
%   
%   $ Fernando Gómez Bravo 07/07/2018 $

    
  global rangescan %variable que contiene las medidas del lidar
  global tstart
  global tiempo

% Determine the type of event.
    EventType = event.Type;
    
    if EventType=='BytesAvailable'
        %disp(EventType)
        data=char(fread(obj,2134,'char'))';
        [rangescan]=convierte_datos(data);
        tiempo=toc(tstart);
        rangescan=[tiempo rangescan]; %quitar (341) para todos los datos
        %datos=[tiempo rangescan];
        drawnow %actualiza la representación gráfica
        %lee_lidar
        fprintf(obj,'GD0044072500'); %pide al lidar entregar lectura
    end
end

