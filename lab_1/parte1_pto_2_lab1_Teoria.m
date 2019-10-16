% Script OCTAVE para la transformada de Fourier del pulso rectangular.
a1=1; 	
T=3;                                                                       % duración de la señal
f0=1/3;                                                                      % valor de la frecuencia lineal
fs=50*f0; Ts=1/fs;                                                % intervalo de muestreo y frecuencia de muestreo
t=[-T/2:Ts:T/2];                                                             % vector de tiempo
f=[-25:25];                                                                % vector de frecuencias

x=abs(t)<a1; Xw=fft(x)*Ts; 
sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x.
subplot(2,1,1); stem(f,abs(2*a1*sa(a1*f)),'-b'); xlabel('\omega'); ylabel('X(\omega)'); title('Transformada de Fourier del Pulso Rectangular Analtica'); grid;
subplot(2,1,2); stem(f,fftshift(abs(Xw)),'-b'); xlabel('\omega'); ylabel('X2(\omega)'); title('Transformada de Fourier del Pulso Rectangular usando FFT'); grid;
