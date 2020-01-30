#ENCODING
disp("Codificador para el codigo de bloques lineal sistemático")
d = input("Ingrese el mensaje a codificar:  ")
#d = [0 0 1] # word of k bits to encode
k = length(d);
n = 6;
m = n-k;
P = [1 0 1; 1 1 1; 1 1 0];
Ik = eye(k);
PT = P';
G = [Ik PT];
c = mod(d*G,2)

#DECODING
disp("Decodificador para el codigo de bloques lineal sistemático")
r = input("Ingrese el codigo del mensaje recibido:  ")
#r = [0 1 0 1 1 1] # word received
Im = eye(m);
HT = [PT; Im];
s = mod(r*HT,2);
if( s == 0 )
  disp("No se han encontrado errores, el mensaje enviado es:")
  d2 = r(1:k)
else
  [tf, errorIndex]=ismember(s,HT,'rows');
  r(errorIndex) = (r(errorIndex) == 0);
  disp("Se ha encontrado un error en la posicion", errorIndex)
  disp("El mensaje corregido es:")
  r_corrected = r
endif
  


