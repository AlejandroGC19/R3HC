%------------------------------------------
% Convierte datos ASCII leidos del lidar en valores numericos
% en esta versión se permite limitar la lectura a 2mts y se utiliza una
% descodificación más efeciente y rápida: decodeSCIP_2.m
% 07/07/18; 31/07/18
%-------------------------------------------
function [rangescan]=convierte_datos(data)

    i=find(data==data(13));
    rangedata=data(i(3)+1:end-1);
    for j=0:31
        onlyrangedata((64*j)+1:(64*j)+64)=rangedata(1+(66*j):64+(66*j));
    end
    j=0;
    
    for i=1:floor(numel(onlyrangedata)/3)
        encodeddist(i,:)=[onlyrangedata((3*j)+1) onlyrangedata((3*j)+2) onlyrangedata((3*j)+3)];
        j=j+1;
    end
    
    for k=1:size(encodeddist,1)
        %rangescan(k)=decodeSCIP(encodeddist(k,:)); %descodificación original
        rangescan(k)=decodeSCIP_2(encodeddist(k,:)); %Descodificación más rápida 

        if (rangescan(k)>1000) %limitado a 2 mt.
            rangescan(k)=1000;
        end


        if (rangescan(k)<50) && (k>1)
            rangescan(k)=rangescan(k-1); %filtra los datos erroneos
        end
    end
end