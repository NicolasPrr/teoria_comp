% Script OCTAVE para la transformada de Fourier del pulso rectangular.
a1=1; 	
T=3;                                                                       % duración de la señal
f0=1/3;                                                                      % valor de la frecuencia lineal
fs=50*f0; Ts=1/fs;                                                % intervalo de muestreo y frecuencia de muestreo
t=[-T/2:Ts:T/2];                                                             % vector de tiempo
w=[-25:25];                                                                % vector de frecuencias

x=abs(t)<a1; X=fft(x)*Ts; 

wc = 5;wc1 = -5;wc2=5;

% filtros
pb = abs(w) <= wc;
pa = abs(w) >= wc;
pbd = wc1 <= abs(w) & abs(w) <= wc2; 
sbd = ~ (wc1 <= abs(w) & abs(w) <= wc2);

% resultado de aplicar el filtro 
y1 = abs(fftshift(X)).*pb;
y2 = abs(fftshift(X)).*pa;
y3 = abs(fftshift(X)).*pbd;
y4 = abs(fftshift(X)).*sbd;

% deformacion señal original
iy1 = ifft(y1);
iy2 = ifft(y2);
iy3 = ifft(y3);
iy4 = ifft(y4);

subplot(6,1,1); stem(w,abs(fftshift(X)),'-b'); xlabel('\omega'); ylabel('X2(\omega)'); title('Espectro de magnitud de x(t)'); grid;
subplot(6,1,2); stem(w,pb,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasabajas'); grid;
subplot(6,1,3); stem(w,y1,'-r'); xlabel('\omega'); ylabel('Y(\omega)'); title('Respuesta 1'); grid;
subplot(6,1,4); stem(w,pa,'-g'); xlabel('\omega'); ylabel('H(\omega)'); title('Filtro pasaaltas'); grid;
subplot(6,1,4); stem(t,x,'-b'); xlabel('t'); ylabel('x(t)'); title('Señal original'); grid;
subplot(6,1,5); stem(t,iy1,'-g'); xlabel('t'); ylabel('y1(t)'); title('Deformacion x(t) por el filtro pasabajas'); grid; 