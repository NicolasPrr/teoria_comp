% Script OCTAVE para la transformada de Fourier del pulso rectangular.
clc
clear
a1=1; 	
T=3;                                                                       % duración de la señal
f0=1/3;                                                                      % valor de la frecuencia lineal
fs=50*f0; Ts=1/fs;                                                % intervalo de muestreo y frecuencia de muestreo
t=[-T/2:Ts:T/2];                                                             % vector de tiempo
f=[-25:25];                                                                % vector de frecuencias

x=abs(t)<a1; Xw=fft(x)*Ts; 
sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x.
figure(1);
subplot(2,1,1); stem(f,abs(2*a1*sa(a1*f)),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;


N = 64;
from_a = -3;
to_b = 3;
t = linspace(from_a,to_b,51);
T = (to_b - from_a)/N;
y=  abs(t) <= a1 ;
%cos(2*pi*10*t);

fc = 1/(2*T);  % frecuencia de corte
paso = 2*fc/N  ; % en dominio de frecuencia
f2 = -fc:paso:fc - paso; % vector de frecuencia

Y = fftshift(abs(fft(y)));
subplot(2,1,2); stem(f2,Y);

figure(2);plot(t,y);


