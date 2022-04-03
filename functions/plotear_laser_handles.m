%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotealas medidas proporcionadas por el lase Okuyo
% Se considera que son entregadas 682 muestras
%-------------------------------------------
% rangescan: el vector devuelto por el laser
% handles: los manejadores de los dibujos de las medidas
% hay que definirlos fuera de la función  ver:
% ejemplo_lidar_handles.m
%--------------------------------------------------
% F Gomez Bravo 20/10/16
%--------------------------------------------------


function plotear_laser_handles(rangescan,handles)

global x;
global y;

i=1:682;
theta=(-120+(i-1)*0.3524)*pi/180;

 %theta=4*pi/6:-(4*pi/(6*341)):-4*pi/6;
%[size(theta) size(rangescan)]
 
x=rangescan(2:end).*cos(theta);
y=rangescan(2:end).*sin(theta);

%set(handles(1:682),'xdata',x(1:682),'ydata',y(1:682),'Color','red','LineStyle','.');
set(handles(1:682),'xdata',x(1:682),'ydata',y(1:682),'Color','red','LineStyle', '-');
%disp('hola')

%vector perceción total
% xt=sum(x);
% yt=sum(y);
% modulo_t=max(rangescan);
% %plot([0 modulo_t*xt/sqrt(xt^2+yt^2)],[0 modulo_t*yt/sqrt(xt^2+yt^2)],'r')
% 
% %vector perceción derecho
% xd=sum(x(1:341));
% yd=sum(y(1:341));
% modulo_d=max(rangescan(1:341));
% %plot([0 modulo_d*xd/sqrt(xd^2+yd^2)],[0 modulo_d*yd/sqrt(xd^2+yd^2)],'b')
% 
% %vector perceción izquierdo
% xi=sum(x(342:682));
% yi=sum(y(342:682));
% modulo_i=max(rangescan(342:682));
%plot([0 modulo_i*xi/sqrt(xi^2+yi^2)],[0 modulo_i*yi/sqrt(xi^2+yi^2)],'k')

