function y = huffman2( Px )
  shuffle_list = Px;
  Px = sort( Px, "descend" );
  size = length( Px );
  last = size;
  a = size - 2;
  cont = 1;
  cont2 = 0;
  mcs = zeros( 1, last - 2 );
  
  matriz_pro = zeros( size, size - 1 );
  matriz_pro( 1:size ) = Px;
  
  for i = 1:a 
    suma = matriz_pro( last + ( size * cont2 ) ) + matriz_pro( last + ( size * cont2 ) - 1 );
    aux_arr = zeros( 1, last );
    aux_arr = matriz_pro( 1 + ( size * cont2 ):( last - 2 ) + ( size * cont2 ) );
    aux_arr( last - 1 ) = suma;
    last = last - 1;
    arr_final = fliplr( sort( aux_arr ) );
    matriz_pro( 1 + ( size * cont ) : last + ( size * cont ) ) = arr_final;
    pos_marc = find( arr_final == suma );

      if( length( pos_marc ) == 1 )
         mcs( cont ) = pos_marc( 1 );
       else
        mcs( cont ) = pos_marc( length( pos_marc ) );
       endif

    cont = cont + 1;
    cont2 = cont2 + 1;
  endfor
  coding = cell( 1, last );
  aux_arr = zeros( 1, last );
  coding( 1 ) = "0";
  coding( 2 ) = "1";
  cont = cont - 1;
  b = 2;


  for i = 1:a 
    mc = mcs( cont );
    carry = coding( 1, mc );
    cont = cont - 1;
    aux_arr = zeros( 1, last );
    aux_arr = matriz_pro( ( ( size * ( cont + 1 ) ) - ( size - 1 ):( size * ( cont + 1 ) ) - ( size - ( b + 1 ) ) ) );
    aux_cod = cell( 1, ( last + 1 ) );
  
    aux_cod( length( aux_cod ) - 1 ) = strcat( carry, "0" );
    aux_cod( length( aux_cod ) ) = strcat( carry, "1" );
    

     if( mc != last )
        pasar = coding( ( mc + 1 ):last );
        aux_cod( last - length( pasar ):( mc + length( pasar ) ) - 1 ) = pasar;
        if mc - length( pasar ) > 1
        aux_cod( 1:mc - length( pasar ) ) = coding( 1:mc - length( pasar ) );
       endif
     else

        aux_cod( 1:mc - 1 ) = coding( 1, mc - 1 );
    endif  
     
        aux_cod;
        coding = cell( 1, last + 1 );
        coding = aux_cod;
     
     b = b + 1;
    last = last + 1;
  endfor
  for i = 1:size
    printf( "\n     x%i --> P(x%i) = %f -- CODE: ", i, i, shuffle_list( i ) );
    printf( coding{ find( Px == shuffle_list( i ) ) } );
  endfor
  printf( "\n\n" );
endfunction


