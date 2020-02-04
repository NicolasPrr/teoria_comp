P=[1 0 1;  1 1 1 ;   1 1 0];
I=[1 0 0;  0 1 0;   0 0 1];
G=[I P'];

x=input('Ingrese el dato: ');
codigo= mod((x*G),2)
Ht=[P'; I];


codigo = [ 1 0 1 0 1 1]

r = mod((codigo * Ht),2)
dist = r * ones(3,1);
idx = 1;
if( dist == 0)
	printf("El codigo llego sin errores\n");
else
	Ht
	while(idx<rows(Ht))
		if (Ht(idx,:) == r)
			printf("Error en el bit %d \n ", idx);
			codigo(idx) = mod(codigo(idx) +1,2);
		endif
		idx+=1;
	endwhile
	codigo
	printf("El mensaje es ");
	codigo(1:3)
endif