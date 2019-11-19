disp("punto 1")
warning('off', 'all');
clc
#La funcion nos permite verificar si los inputs del archivo p(x) estan bien
function y = verification_p(array)
  sum = 0;
  for i = array
    sum = sum + i;
  end
  if sum == 1
    y = true;
    return
  endif
  y = false;
endfunction
function y = verification_shapes(PX, PYX )
  if columns(PX) == rows(PYX)
    y = true; 
    return;
   endif
   disp("Bad shape PX or PXY")
   y = false;
endfunction

function y = verification_pyx( PYX )
  y = (sum(PYX,2) == ones(rows(PYX)));
endfunction


function y = esBSC(matriz)
  if(columns(matriz)==2 && rows(matriz)==2)    
    if(matriz(1,1)==matriz(2,2) && matriz(1,2)==matriz(2,1))      
      y = true;
      return;    
    endif      
  endif
  y=false;  
endfunction



NAMEFILE_PX = "P(X).TXT";
P = load (NAMEFILE_PX, "R")
NAMEFILE_PYX = "P(YX).TXT";
PYX = load (NAMEFILE_PYX, "R")

allow = verification_p(P)  && verification_shapes(P,PYX) && verification_pyx(PYX);
if allow
  disp("P(X) FORMAT: OK")
  
  #[P(Y)]
  disp("[P(Y)]")
  PY = P*PYX
  
  #P(X,Y)
  disp("P(X,Y)")
  PX_Y = diag(P) * PYX
  #H(X)
  disp("H(X)")
  HX = - sum(P.*log2(P))
  #H(Y)
  disp("H(Y)")
  HY = - sum(PY.*log2(PY))
  #H(P(X,Y))
  disp("H(X,Y)")
  HX_Y = -sum(sum(PX_Y.*log2(PX_Y)))
  #H(P(Y|X))
  disp("H(X|Y)")
  HXY = HX_Y - HY
  
   #H(P(Y|X))
 
  disp("H(Y|X)")
  HYX = HX_Y - HX
 
  HYX = -sum(sum(PX_Y.*log2(PYX)))
  
  if(columns(PYX)==2 && rows(PYX)==2)
    if(PYX(1,1)==PYX(2,2) && PYX(1,2)==PYX(2,1)) 
      p = PYX(1,2);
      cs = 1+p*log2(p)+(1-p)*log2(1-p)
     else
      disp("No es simetrico")
    endif
  endif
  
else
  disp("P(X) FORMAT: wrong input")
endif
