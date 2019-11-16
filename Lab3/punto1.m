Px = input("Ingrese P(X): ");
Pyx = input("Ingrese P(Y|X): ");

function y = esBSC(matriz)
  if(columns(matriz)==2 && rows(matriz)==2)    
    if(matriz(1,1)==matriz(2,2) && matriz(1,2)==matriz(2,1))      
      y = true;
      return;    
    endif      
  endif
  y=false;  
endfunction

function cs = cs(p)
  cs = 1+p*log2(p)+(1-p)*log2(1-p);
endfunction

Py = Px*Pyx

Pxd = diag(Px)

Pxy = Pxd*Pyx

Hx = 0;
Hy = 0;
for i = Px
  Hx=Hx+(i*log2(1/i));
end
for i = Py
  Hy=Hy+(i*log2(1/i));
end
Hx
Hy

Hxy=0;
for j = 1:columns(Pxy)
  for i = 1:rows(Pxy)
    Hxy=Hxy+(Pxy(i,j)*log2(1/Pxy(i,j)));
  end  
end

Hxy


Hyx = Hxy-Hx


Ixy =  Hy - Hyx

if(esBSC(Pyx))
  cs(Pyx(1,2))
endif