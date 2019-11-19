#Universidad Nacional de Colombia Sede Bogot�
#Teor�a de la informaci�n y sistemas de comunicaciones
#Taller 3

function y = DMC( Px, Pyx ) #LA funci�n DMC sirve para calcular [P(Y)], [P(X,Y)], 
                            #H(X), H(Y|X), H(Y), H(X|Y), I(X;Y) y, si el canal 
                            #es sim�trico, calcula tambi�n C_s. Dados los valores de 
                            #[P(x)] en la par�metro Px, y [P(Y|X)] en la par�metro Pyx
  
  printf( "  ________________________________________________\n" )
  #Py se refiere a [P(Y)]
  #Se calcula a partir de la multiplicaci�n matricial entre [P(X)] y [P(Y|X)]
  Py = Px * Pyx;
  printf( "\n  \t| VECTOR DE PROBABILIDADES DE Y |\n  [P(Y)] = " );
  Py

  
  #Px_d se refiere a la matriz diagonal de [P(X)]
  Px_d = diag( Px );
  
  printf( "  ________________________________________________\n" )
  #Pxcy se refiere a [P(X,Y)]
  #Se calcula a partir de la multiplicaci�n matricial entre [P(X)]_d y [P(Y|X)]
  Pxcy = Px_d * Pyx;
  printf( "\n  \t| MATRIZ DE RPOBABILIDADES CONJUNTAS |\n  [P(X,Y)] = " );
  Pxcy
  
  printf( "  ________________________________________________\n" )
  #Px_plus_log2Px es la suma elemento a elemento de Px + log2( Px )
  Px_plus_log2Px = ( Px .* log2( Px ) );
  
  #Se calcula H(X) como la suma entre todos los elementos de Px_plus_log2Px
  Hx = -1 * sum( Px_plus_log2Px );
  printf( "\n  \t| ENTROPIA DE X |\n  H(X) = " );
  Hx

  printf( "________________________________________________\n" )
  #Pxcy_plus_log2Pyx es la suma elemento a elemento de Pxcy + log2( Pyx )
  Pxcy_plus_log2Pyx = ( Pxcy .* log2( Pyx ) );
  
  #Se calcula H(Y|X) como la suma de todos los elementos de Pxcy_plus_log2Pyx
  Hyx = sum( Pxcy_plus_log2Pyx );
  Hyx = -1 * sum( Hyx );
  printf( "\n  \t| ENTROPIA CONDICIONAL |\n  [P(X,Y)] = " );
  printf( "\n  H(Y|X) = " );
  Hyx
  
  printf( "  ________________________________________________\n" )
  #Py_plus_log2Py se refiere a la suma entre Py + log2( Py )
  Py_plus_log2Py = ( Py .* log2( Py ) );
  
  #Se calcula H(Y) sumando todos los elementos de Py_plus_log2Py
  Hy = -1 * sum( Py_plus_log2Py );
  printf( "\n  \t| ENTROPIA DE Y |\n  H(Y) = " );
  Hy
  
  printf( "  ________________________________________________\n" )
  #Pxcy_plus_log2Pxcy se refiere a la suma entre Pxcy + log2( Pxcy )
  Pxcy_plus_log2Pxcy = ( Pxcy .* log2( Pxcy ) );
  
  Hxcy = sum( Pxcy_plus_log2Pxcy );
  Hxcy = -1 * sum( Hxcy );
  printf( "\n  \t| ENTROPIA CONJUNTA |\n  H(X,Y) = " );
  Hxcy

  #Se calcula H(X|Y) como la resta entre H(X,Y) con H(Y)
  Hxy = Hxcy - Hy;
  
  printf( "  ________________________________________________\n" )
  #I(X;Y) se calcula haciendo la resta entre H(X) con H(X|Y)
  Ixy = Hx - Hxy;
  printf( "\n  \t| INFORMACION MUTUA |\n  I(X;Y) = " );
  Ixy
  
  printf( "  ________________________________________________\n" )
  #Si el canal es binaria y sim�trica, se calcula la capacidad del canal por s�mbolo
  if( Pyx(1, 1) == Pyx(2, 2) ) && ( Pyx(1, 2) == Pyx(2, 1) ) && ( length( Pyx ) == 2 )
    Cs = 1 + ( Pyx(1, 2) * log2( Pyx(1, 2) ) ) + ( ( 1 - Pyx(1, 2) ) * log2( ( 1 - Pyx(1, 2) ) ) );
    printf( "\n  \t| CAPACIDAD DEL CANAL POR SIMBOLO |\n  C_s = " );
    Cs
  endif
  printf( "\n  ________________________________________________\n" )
endfunction
