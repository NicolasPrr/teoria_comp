PX = input("Por favor ingrese el vector de probabilidades de la fuente P(X): ");
PYX = input("Por favor ingrese la matriz del canal P(Y|X): ");

PY = PX*PYX
PXd = diag(PX)
PXY = PXd*PYX
HX = -1 * sum(PX.*(log2(PX)))
HY = -1 * sum(PY.*(log2(PY)))

HXY=0;
for j = 1:columns(PXY)
  for i = 1:rows(PXY)
    HXY=HXY+(PXY(i,j)*log2(1/PXY(i,j)));
  end  
end

HXY
HYX = HXY-HX
IXY =  HY - HYX

if(columns(PYX)==2 && rows(PYX)==2)
  if(PYX(1,1)==PYX(2,2) && PYX(1,2)==PYX(2,1)) 
    p = PYX(1,2);
    cs = 1+p*log2(p)+(1-p)*log2(1-p)
  endif
endif