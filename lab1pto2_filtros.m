% Script OCTAVE para la transformada de Fourier del pulso rectangular.
a1=1; 	
T=3;                                                                       % duraci?n de la se?al
f0=1/3;                                                                      % valor de la frecuencia lineal
fs=50*f0; Ts=1/fs;                                                % intervalo de muestreo y frecuencia de muestreo
t=[-T/2:Ts:T/2];                                                             % vector de tiempo
f=[-25:25];                                                                % vector de frecuencias
wm = 5;
ws1 = 5;
ws2 = 10;


x=abs(t)<a1; 
Xw=fft(x)*Ts; 

sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la funci?n sa(x)=sin(x)/x.

ta= (2*a1*sa(a1*f));

pb = abs(f) <= wm; %filtro pasa-bajas
pa = abs(f) >= wm;
pbd = ws1 <= abs(f) & abs(f) <= ws2; 
sbd = ~ (ws1 <= abs(f) & abs(f) <= ws2);


y1 = abs(fftshift(Xw)).*pb;
y2 = abs(fftshift(Xw)).*pa;
y3 = abs(fftshift(Xw)).*pbd;
y4 = abs(fftshift(Xw)).*sbd;

y11 = abs(ta).*pb;
y22 = abs(ta).*pa;
y33 = abs(ta).*pbd;
y44 = abs(ta).*sbd;

iy1 = ifft(y1);
iy2 = ifft(y2);
iy3 = ifft(y3);
iy4 = ifft(y4);


disp('1) Filtro pasa-bajas');

disp('2) Filtro pasa-altas');

disp('3) Filtro pasa-bandas');

disp('4) Filtro suprime-bandas');

option = input('Cual filtro desea usar?');



switch (option)
  case 1
    subplot(5,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
    subplot(5,1,2); stem(f,pb,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-bajas'); grid;
    subplot(5,1,3); stem(f,y11,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
    subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
    subplot(5,1,5); stem(t,iy1,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro pasabajas'); grid; 
  case 2
    subplot(5,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
    subplot(5,1,2); stem(f,pa,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-altas'); grid;
    subplot(5,1,3); stem(f,y22,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
    subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
    subplot(5,1,5); stem(t,iy2,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro'); grid; 
    
  case 3
    subplot(5,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
    subplot(5,1,2); stem(f,pbd,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-bandas'); grid;
    subplot(5,1,3); stem(f,y33,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
    subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
    subplot(5,1,5); stem(t,iy3,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro'); grid; 
    
 case 4
    subplot(5,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Espectro de magnitud de x(t)'); grid;
    subplot(5,1,2); stem(f,sbd,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro suprime-bandas'); grid;
    subplot(5,1,3); stem(f,y44,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta'); grid;
    subplot(5,1,4); stem(t,x,'-y'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
    subplot(5,1,5); stem(t,iy4,'-k'); xlabel('t'); ylabel('x´(t)'); title('Deformacion x(t) por el filtro'); grid; 
    
  otherwise
    subplot(4,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
    subplot(4,1,2); stem(f,fftshift(abs(Xw)),'-r'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
endswitch
