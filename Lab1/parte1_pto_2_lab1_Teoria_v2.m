% Script OCTAVE para la transformada de Fourier del pulso rectangular.
B=12.551;
a1=0.5; 	
T0=2;                                                                       % duración de la señal
f0=1/T0;  
Ts=0.040; 
N0=T0/Ts;                                                                    % numero de muestras
fs=25;  
t=0:Ts:Ts*(N0-1);                                              % intervalo de muestreo y frecuencia de muestreo, Ts <= 1/2B, Ts <= 0.039836

x=Ts*(abs(t)<a1); Xw=fft(x); 

[Gp,Gm]=cart2pol(real(Xw),imag(Xw));
%k=0:N0-1;
k =-(N0-1)/2:(N0-1)/2;
w=2*pi*k;

sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x.
subplot(2,1,1); stem(n,abs((2*a1*sa(a1*n))),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
subplot(2,1,2); stem(w,abs(fftshift(Xw)),'-b'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;

