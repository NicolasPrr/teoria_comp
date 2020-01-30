
d = [1 0 1 0 0]
X = [0 0 0];
states = zeros(length(d),2);
salidas = zeros(length(d),2);

j = 1;
for i=1:1:length(d) 
    X(1)=d(i);    
    v1 = xor(X(1),X(3));
    v2 = xor(X(2),v1);    
    states(j,1)= X(1);
    states(j,2)= X(2);    
    salidas(j,1)=v1;
    salidas(j,2)=v2;    
    X(3) = X(2);
    X(2) = X(1);
    j = j+1;
end

states
salidas

salidas =[1 1;0 0;0 0;0 1;1 1]
n=length(d);
tamano= 2^n;
opciones = zeros(tamano-1,n);
hammings = zeros(tamano-1,1);
for i=0:1:tamano-1
    palabra=dec2bin(i);
    for z=1:1:length(palabra);
      opciones(i+1,z)=str2num(palabra(z));
    end
end
for z=1:1:tamano
  X1 = [0 0 0];
  dhamming=0;
  j = 1;
  for i=1:1:length(d) 
      dhamming1=0;
      dhamming2=0;
      X1(1)=opciones(z,i);
      vs1 = xor(X1(1),X1(3));
      vs2 = xor(X1(2),vs1);
      
      if((vs1==1&&vs2==0)&&(salidas(j,1)==0&&salidas(j,2)==1)||(vs1==0&&vs2==1)&&(salidas(j,1)==1&&salidas(j,2)==0))
            dhamming = dhamming+2;
       else
           
            
           if(vs1==1)
                 dhamming1= dhamming1+1;
           end
           if(salidas(j,1)==1)
           
                dhamming2= dhamming2+1;
           end
           if(vs2==1)
               dhamming1= dhamming1+1;
           end
           if(salidas(j,2)==1)
          
                dhamming2= dhamming2+1;
           end
           dhamming = dhamming + sqrt((dhamming1-dhamming2)^2);
       end
          X1(3) = X1(2);
          X1(2) = X1(1);
          j=j+1;
    end
    dhammings(z)=dhamming;
end
minimo=99;
indice=0;
for m=1:1:length(dhammings)
  dhammings(m);
  if(dhammings(m)<=minimo)
    minimo = dhammings(m);
    indice = m;
  end
end
minimo
indice;
states1 = zeros(length(d),2);
salidas1 = zeros(length(d),2);
salida = zeros(1,length(d));
for m=1:1:length(d)
  salida(1,m)=opciones(indice,m);
end
salida
j=1;
X1 = [0 0 0];
for i=1:1:length(d) 
   dhamming1=0;
   dhamming2=0;
   X1(1)=opciones(indice,i);
   vs1 = xor(X1(1),X1(3));
   vs2 = xor(X1(2),vs1);
   states1(j,1)= X1(1);
   states1(j,2)= X1(2);
   salidas1(j,1)=vs1;
   salidas1(j,2)=vs2;
   X1(3) = X1(2);
   X1(2) = X1(1);
   j=j+1;
end
salidas1
states1
