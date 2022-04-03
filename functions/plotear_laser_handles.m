%{
Dibuja las medidas proporcionadas por el laser Hokuyo.
Se considera que son entregadas 682 muestras.
-------------------------------------------
rangescan: el vector devuelto por el laser
handles: los manejadores de los dibujos de las medidas
(hay que definirlos fuera de la función)
--------------------------------------------------
Alejandro Garrocho Cruz
%}


function plotear_laser_handles(rangescan,handles)

global x;
global y;

i=1:682;
theta=(-120+(i-1)*0.3524)*pi/180;
 
x=rangescan(2:end).*cos(theta);
y=rangescan(2:end).*sin(theta);

set(handles(1:682),'xdata',x(1:682),'ydata',y(1:682),'Color','red','LineStyle', '-');


