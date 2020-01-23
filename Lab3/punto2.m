#probabilidades = input("Ingrese el vector de probabilidades de cada simbolo P(x): \n");
Px = [0.30,0.08,0.20,0.12,0.25,0.05];
pro_sort = fliplr(sort(Px));
long = length(pro_sort);
a = length(pro_sort) - 2;
matriz_pro = zeros(length(pro_sort),length(pro_sort) - 1);
matriz_pro(1:length(pro_sort))=pro_sort;
cont = 1 ;
cont2 = 0;
last_pos = length(pro_sort);
marcados = zeros(1,last_pos - 2);

for i = 1 : 1 : a 

  suma = matriz_pro(last_pos + (long * cont2 )) + matriz_pro(last_pos + (long * cont2 ) - 1);
  aux_arr = zeros(1,last_pos);
  aux_arr = matriz_pro(1 + (long * cont2 ):(last_pos - 2) + (long * cont2 ));

  aux_arr(last_pos - 1) = suma;
  last_pos = last_pos - 1;
  arr_final = fliplr(sort(aux_arr));
  matriz_pro(1 + (long * cont)  : last_pos + (long * cont ) ) = arr_final;
  pos_marc = find(arr_final==suma);

    if length(pos_marc) == 1
       marcados(cont) = pos_marc(1);
     else
      marcados(cont) = pos_marc(length(pos_marc));
     endif

  cont = cont + 1;
  cont2 = cont2 + 1;
endfor

matriz_pro
codificacion = cell(1,last_pos);
aux_arr = zeros(1,last_pos);
  codificacion(1) = "0";
  codificacion(2) = "1";
codificacion
cont = cont -1 ;
b = 2;


for i = 1 : 1 : a 

  marcado = marcados(cont);
  carry = codificacion(1,marcado);
  cont = cont - 1;
  aux_arr = zeros(1,last_pos);
  aux_arr = matriz_pro(((long * (cont+1)) - (long - 1) : (long*(cont+1)) - (long - (b+1))));
  aux_cod = cell(1,last_pos + 1);
 
  
      aux_cod(length(aux_cod) - 1) =strcat(carry,"0");
      aux_cod(length(aux_cod) ) = strcat(carry, "1");
  

   if marcado != last_pos
      pasar = codificacion(marcado + 1:last_pos);
      aux_cod(last_pos - length(pasar):(marcado + length(pasar)) - 1) = pasar;
      if marcado - length(pasar) > 1
      aux_cod(1:marcado - length(pasar) ) = codificacion(1:marcado - length(pasar));
     endif
   else

      aux_cod(1:marcado - 1) = codificacion(1, marcado - 1);
  endif  
   
      aux_cod
      codificacion = cell(1,last_pos + 1);
      codificacion = aux_cod;
   
   b = b + 1;
  last_pos = last_pos + 1;
endfor
