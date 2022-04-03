function mi_callback(obj, event)
%{
Lee datos del lidar cuando el buffer tiene el número de bits adecuado 2134
al configurar el puerto serie hay que establecer el valor;

       lidar.BytesAvailableFcnCount = 2134 

Una vez lee los datos los convierte a caracteres ASCII y los guarda en
la variable global rangescan.
Seguidamente vuelve a mandar un mensaje al LIDAR para pèdir otra lectura

--------------------------------------------------
Alejandro Garrocho Cruz
%}

    
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
        drawnow %actualiza la representación gráfica
        %lee_lidar
        fprintf(obj,'GD0044072500'); %pide al lidar entregar lectura
    end
end

