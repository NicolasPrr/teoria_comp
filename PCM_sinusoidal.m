% Aplicando PCM a una señal sinusoidal  de 1 Hz.

T=2;                                             % duración de la señal
Fm=1; Fs=4; Ts=1/Fs;                    % ancho de banda = 1, frecuencia max. = 1 Hz, fs >= 2*fm = 2 Hz, Ts = 1/Fs
N=T/Ts;                                        % numero de muestras
t=[0:Ts:T];                                     % vector de tiempo
x=2.5*cos((2*pi*t)+(pi/2));            % sinusoidal muestreada
wm=2*pi*Fm;
[xq,xqcode]=cuant_and_coder(x,2.5,4); % cuant_and_coder(x,xmax,n): cuantiza x sobre (-xmax,xmax) usando 2^n niveles y codifca los valores cuantizados de x.
xq                                                  % valores de la señal cuantizados
xqcode                                           % esto es lo que se traduce al formato de onda de pulsos
