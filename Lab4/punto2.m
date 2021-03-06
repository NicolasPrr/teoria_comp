disp ("--------------------------------------------");
disp ("               Codificador");
disp ("--------------------------------------------");

entrada = [1 1 0 0 0];
entrada
cola = [0 0 0];
n=length(entrada);
estados = zeros(n,2);
salidas = zeros(n,2);

j = 1;
for i=1:1:n 
    
    cola(1)=entrada(i);

    x1 = xor(cola(1),cola(3));
    x2 = xor(cola(2),x1);

    estados(j,1)= cola(1);
    estados(j,2)= cola(2);
    salidas(j,1)=x1;
    salidas(j,2)=x2;

    cola(3) = cola(2);
    cola(2) = cola(1);
    j = j+1;
end

estados
salidas


disp ("--------------------------------------------");
disp ("               Decodificador");
disp ("--------------------------------------------");


%Entrada con Error

entrada_deco =[1 1 
               1 1
               1 0
               1 1
               0 0];

     
entrada_deco

tamano= 2^n;
caminos = zeros(tamano-1,n);
dhammings = zeros(tamano-1,1);


for i=0:1:tamano-1
    palabra=dec2bin(i);
    for z=1:1:length(palabra);
      caminos(i+1,z)=str2num(palabra(z));
    end
end


for z=1:1:tamano
  cola1 = [0 0 0];
  hamming=0;
  j = 1;
  for i=1:1:n 
  
      cola1(1)=caminos(z,i);
      x1 = xor(cola1(1),cola1(3));
      x2 = xor(cola1(2),x1);
      
      if((x1 != entrada_deco(j,1)) && (x2 != entrada_deco(j,2)))
            hamming = hamming+2;
       else

        if(( (x1 == entrada_deco(j,1)) && (x2 != entrada_deco(j,2))) || ( (x1 != entrada_deco(j,1)) && (x2 == entrada_deco(j,2))))
          hamming= hamming+1;
        end
       end
           
          cola1(3) = cola1(2);
          cola1(2) = cola1(1);
          j=j+1;
    end
    dhammings(z)=hamming;
end


min_hamming= 1000;
camino_opt=0;
for m=1:1:length(dhammings)
  dhammings(m);
  if(dhammings(m)<=min_hamming)
    min_hamming = dhammings(m);
    camino_opt = m;
  end
end


salida_deco = zeros(1,n);

for m=1:1:n
  salida_deco(1,m)=caminos(camino_opt,m);
end

salida_deco
