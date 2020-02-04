#ENCODING
printf("Codificador para el codigo de bloques lineal sistemático\n")
d = input("Ingrese el mensaje a codificar:  ")
#d = [1 0 1] # word of k bits to encode
k = length(d);
n = 6;
m = n-k
P = [1 0 1; 1 1 1; 1 1 0]
Ik = eye(k);
PT = P'
G = [Ik PT]
c = mod(d*G,2)

#DECODING
printf("Decodificador para el codigo de bloques lineal sistemático\n")
r = input("Ingrese el codigo recibido:  ")
#r = [0 1 0 0 1 1] # word received
Im = eye(m);
HT = [PT; Im]
s = mod(r*HT,2);
if( s == 0 )
  printf("No se han encontrado errores, el mensaje enviado es:\n")
  d2 = r(1:k)
else
  [tf, errorIndex]=ismember(s,HT,'rows');
  r(errorIndex) = (r(errorIndex) == 0);
  printf("Se ha encontrado un error en la posicion:\n")
  errorIndex  
  printf("El mensaje corregido es:\n")
  r_corrected = r
endif
  


