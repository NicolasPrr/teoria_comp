% Script OCTAVE para la transformada de Fourier del pulso rectangular.
B=12.551;
a1=0.5; 	
T0=2;                                                                       % duración de la señal
f0=1/T0;  
Ts=0.040; 
N0=T0/Ts;                                                                    % numero de muestras
fs=25;  
t=-Ts*((N0-1)/2):Ts:Ts*((N0-1)/2);                                              % intervalo de muestreo y frecuencia de muestreo, Ts <= 1/2B, Ts <= 0.039836

x=Ts*(abs(t)<a1); Xw=fft(x); 

[Gp,Gm]=cart2pol(real(Xw),imag(Xw));
%k=0:N0-1;
k =-(N0-1)/2:(N0-1)/2;
w=2*pi*k;

wm = 20;
ws1 = 20;
ws2 = 40;

sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la funci?n sa(x)=sin(x)/x.

ta= (2*a1*sa(a1*w));

pb = abs(w) <= wm; %filtro pasa-bajas
pa = abs(w) >= wm;
pbd = ws1 <= abs(w) & abs(w) <= ws2; 
sbd = ~ (ws1 <= abs(w) & abs(w) <= ws2);

y1 = abs(Xw).*pb;
y2 = abs(Xw).*pa;
y3 = abs(Xw).*pbd;
y4 = abs(Xw).*sbd;


iy1 = abs(ifft(y1));
iy2 = abs(ifft(y2));
iy3 = abs(ifft(y3));
iy4 = abs(ifft(y4));

while(true)
  disp('1) Filtro pasa-bajas');
  disp('2) Filtro pasa-altas');
  disp('3) Filtro pasa-bandas');
  disp('4) Filtro suprime-bandas');
  option = input('Cual filtro desea usar?');

  switch (option)
    case 1
      subplot(5,1,1); stem(w,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
      subplot(5,1,2); stem(w,pb,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-bajas'); grid;
      subplot(5,1,3); stem(w,y1,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
      subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
      subplot(5,1,5); stem(t,iy1,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro pasabajas'); grid; 
    case 2
      subplot(5,1,1); stem(w,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
      subplot(5,1,2); stem(w,pa,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-altas'); grid;
      subplot(5,1,3); stem(w,y2,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
      subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
      subplot(5,1,5); stem(t,iy2,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro'); grid; 
      
    case 3
      subplot(5,1,1); stem(w,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
      subplot(5,1,2); stem(w,pbd,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-bandas'); grid;
      subplot(5,1,3); stem(w,y3,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
      subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
      subplot(5,1,5); stem(t,iy3,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro'); grid; 
      
   case 4
      subplot(5,1,1); stem(w,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
      subplot(5,1,2); stem(w,sbd,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro suprime-bandas'); grid;
      subplot(5,1,3); stem(w,y4,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
      subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
      subplot(5,1,5); stem(t,iy4,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro'); grid; 
      
    otherwise
      break  
  endswitch
endwhile