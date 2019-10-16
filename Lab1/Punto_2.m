% Script OCTAVE para la transformada de Fourier del pulso rectangular.
a1=1; 	
T=4;    
Ts=1/64;                                                                    % duraci�n de la se�al
f0=T/Ts;                                                                      % valor de la frecuencia lineal
fs=50*f0;                                                % intervalo de muestreo y frecuencia de muestreo
t=[-T/2:Ts:T/2];                                                             % vector de tiempo
f=[-128:128];                                                                % vector de frecuencias
wm = 5;
ws1 = -10;
ws2 = 10;


x=abs(t)<a1; 
Xw=fft(x)*Ts; 

sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la funci�n sa(x)=sin(x)/x.

ta= (2*a1*sa(a1*f));

pb = abs(f) <= wm; %filtro pasa-bajas
pa = abs(f) >= wm;
pbd = ws1 <= abs(f) & abs(f) <= ws2; 
sbd = ~ (ws1 <= abs(f) & abs(f) <= ws2);


y1 = abs(fftshift(Xw)).*pb;
y2 = abs(fftshift(Xw)).*pa;
y3 = abs(fftshift(Xw)).*pbd;
y4 = abs(fftshift(Xw)).*sbd;
iy1 = ifft(y1);
iy2 = ifft(y2);
iy3 = ifft(y3);
iy4 = ifft(y4);


disp('1) Filtro pasa-bajas');

disp('2) Filtro pasa-altas');

disp('3) Filtro pasa-banda');

disp('4) Filtro suprime-banda');

option = input('Cual filtro desea usar?');



switch (option)
  case 1
    subplot(4,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
    subplot(4,1,2); stem(f,fftshift(abs(Xw)),'-r'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
    subplot(4,1,3); stem(f,y1,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-bajas'); grid;
    subplot(4,1,4); stem(t,iy1,'-b'); xlabel('t'); ylabel('y1(t)'); title('Deformacion x(t) por el filtro pasabajas'); grid; 
  case 2
    subplot(4,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
    subplot(4,1,2); stem(f,fftshift(abs(Xw)),'-r'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
    subplot(4,1,3); stem(f,y2,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-altas'); grid;
    subplot(4,1,4); stem(t,iy2,'-b'); xlabel('t'); ylabel('y1(t)'); title('Deformacion x(t) por el filtro pasa-altas'); grid; 
    
  case 3
    subplot(4,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
    subplot(4,1,2); stem(f,fftshift(abs(Xw)),'-r'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
    subplot(4,1,3); stem(f,y3,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasa-banda'); grid;
    subplot(4,1,4); stem(t,iy3,'-b'); xlabel('t'); ylabel('y1(t)'); title('Deformacion x(t) por el filtro pasa-banda'); grid;
    
 case 4
    subplot(4,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
    subplot(4,1,2); stem(f,fftshift(abs(Xw)),'-r'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
    subplot(4,1,3); stem(f,y4,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro suprime-banda'); grid;
    subplot(4,1,4); stem(t,iy4,'-b'); xlabel('t'); ylabel('y1(t)'); title('Deformacion x(t) por el filtro suprime-banda'); grid;
    
  otherwise
    subplot(4,1,1); stem(f,abs(ta),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
    subplot(4,1,2); stem(f,fftshift(abs(Xw)),'-r'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
endswitch




