disp("Codificacion y decodificacion convolucional")
disp("Codificacion convolucional")
#CONVOLUTIONAL ENCODING
#d = input("Ingrese el mensaje a codificar:  ")
d = [1 0 1 0 0]
X = [0 0 0];
m = 3;
states = zeros(length(d),m-1);
outputs = zeros(length(d),m-1);

j = 1;
for i=1:1:length(d) 
    inputBit=d(i);
    X(1)=inputBit;    
    v1 = xor(X(1),X(3));
    v2 = xor(X(2),v1);    
    states(j,1)= X(1);
    states(j,2)= X(2);    
    outputs(j,1)=v1;
    outputs(j,2)=v2;    
    X(3) = X(2);
    X(2) = X(1);
    j = j+1;
end

code = outputs;
encoding = [ d' states code]
code

#CONVOLUTIONAL DECODING
disp("Decodificador de Viterbi")
#outputs = input("Ingrese el codigo recibido:  ")
outputs =[1 1;0 0;0 0;0 1;1 1];
codeRecv = outputs
n=length(d);
lengt = 2^n;
options = zeros(lengt-1,n);
hammings = zeros(lengt-1,1);

#Las opciones son todas las posibles palabras del mensaje
for i=0:1:lengt-1
    word=dec2bin(i);
    for z=1:1:length(word);
      options(i+1,z)=str2num(word(z));
    end
end

#dfree calculation
for z=1:1:lengt
  X1 = [0 0 0];
  dhamming=0;
  j = 1;
  for i=1:1:length(d) 
      dhamming1=0;
      dhamming2=0;
      X1(1)=options(z,i);
      vs1 = xor(X1(1),X1(3));
      vs2 = xor(X1(2),vs1);
      
      if((vs1==1&&vs2==0)&&(outputs(j,1)==0&&outputs(j,2)==1)||(vs1==0&&vs2==1)&&(outputs(j,1)==1&&outputs(j,2)==0))
            dhamming = dhamming+2;
       else          
            
           if(vs1==1)
                 dhamming1= dhamming1+1;
           end
           if(outputs(j,1)==1)
           
                dhamming2= dhamming2+1;
           end
           if(vs2==1)
               dhamming1= dhamming1+1;
           end
           if(outputs(j,2)==1)
          
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

[dfree, index] = min(dhammings);
dfree
index;

states1 = zeros(length(d),2);
outputs1 = zeros(length(d),2);
output = zeros(1,length(d));

for m=1:1:length(d)
  output(1,m)=options(index,m);
end

message = output;

j=1;
X1 = [0 0 0];

for i=1:1:length(d) 
   dhamming1=0;
   dhamming2=0;
   X1(1)=options(index,i);
   vs1 = xor(X1(1),X1(3));
   vs2 = xor(X1(2),vs1);
   states1(j,1)= X1(1);
   states1(j,2)= X1(2);
   outputs1(j,1)=vs1;
   outputs1(j,2)=vs2;
   X1(3) = X1(2);
   X1(2) = X1(1);
   j=j+1;
end

path = [d' states1 outputs1]
message