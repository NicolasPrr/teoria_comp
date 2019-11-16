#Universidad Nacional de Colombia Sede Bogotá
#Teoría de la información y sistemas de comunicaciones
#--Fabián Camilo Ordóñez
#--Jair Alexis Villalba
#Taller 3

#Algoritmo de huffman puesto en marcha
function y = huffman( Px )
  #shuffle list es la lista sin ordenar. Tal como es pasada a la función
  shuffle_list = Px;
  
  #Px es la lista ya ordenada
  Px = sort( Px, "descend" );
  
  #size es el tamaño de la lista de probabilidades 
  size = length( Px );
  
  last = size;
  cont = 1;
  cont2 = 0;
  
  #marks hace referencia a las probabilidades que son producto de una suma
  marks = zeros( 1, last - 2 );
  
  #m_probab hace referencia a la matriz de probabilidades presentes en el algoritmo
  m_probab = zeros( size, size - 1 );
  m_probab( 1:size ) = Px;
  
  #Dentro de este ciclo for, se rellenará la matriz con todos sus correspondientes valores de probabilidades
  for i = 1:( size - 2 )
    #En sum se guarda la la suma de los 2 últimos valores del arreglo anterior
    sum = m_probab( last + ( size * cont2 ) ) + m_probab( last + ( size * cont2 ) - 1 );
    
    #En vec_aux se almacenarán todos los valores del nuevo vector
    vec_aux = zeros( 1, last );
    vec_aux = m_probab( 1 + ( size * cont2 ):( last - 2 ) + ( size * cont2 ) );
    vec_aux( last - 1 ) = sum;
    last = last - 1;
    m_probab( 1 + ( size * cont ) : last + ( size * cont ) ) = sort( vec_aux, "descend" );
    
    #pos_mark es la posición en la que está el valor que fue producto de la suma de los últimos
    #dos valores del vector anterior
    pos_mark = find( sort( vec_aux, "descend" ) == sum );

    #Si el valor de sum se encuentra más de una vez en vec_aux, se toma el último de estos valores
    if( length( pos_mark ) == 1 )
      marks( cont ) = pos_mark( 1 );
    else
      marks( cont ) = pos_mark( end );
    endif

    cont = cont + 1;
    cont2 = cont2 + 1;
  endfor
  
  #en coding se almacenará el código para cada símbolo
  coding = cell( 1, last );
  vec_aux = zeros( 1, last );
  coding( 1 ) = "0";
  coding( 2 ) = "1";
  cont = cont - 1;
  len_last_vec = 2;

  #En este ciclo for se hará la codificación de los símbolos, acorde al algoritmo de Huffman
  for i = 1:( size - 2 ) 
    mark = marks( cont );
    carry = coding( 1, mark );
    cont = cont - 1;
    
    #vec_aux contendrá cada uno de los vectores de la matriz de probabilidades
    #de atrás hacia adelante
    vec_aux = zeros( 1, last );
    vec_aux = m_probab( ( ( size * ( cont + 1 ) ) - ( size - 1 ):( size * ( cont + 1 ) ) - ( size - ( len_last_vec + 1 ) ) ) );
    
    aux_cod = cell( 1, ( last + 1 ) );
  
    #Se concatena un 0 o un 1, dependiendo de cuál número es mayor
    aux_cod( length( aux_cod ) - 1 ) = strcat( carry, "0" );
    aux_cod( length( aux_cod ) ) = strcat( carry, "1" );
    
    #Si mark es diferente de last, entonces hay que copiar los números que se quedan 
    #sin sin modificación 
    if( mark != last )
      pass = coding( ( mark + 1 ):last );
      aux_cod( last - length( pass ):( mark + length( pass ) ) - 1 ) = pass;
      if mark - length( pass ) > 1
        aux_cod( 1:mark - length( pass ) ) = coding( 1:mark - length( pass ) );
      endif
    #En caso contrario, todos los números quedan sin cambios
    else
      aux_cod( 1:mark - 1 ) = coding( 1, mark - 1 );
    endif  
     
    aux_cod;
    
    #coding será quien contendrá todos los códigos para cada simbolo
    coding = cell( 1, last + 1 );
    coding = aux_cod;
     
    len_last_vec = len_last_vec + 1;
    last = last + 1;
  endfor
  printf( "     \t_________________________________________________\n" );
  for i = 1:size
    printf( "\n\t|     x%i --> P(x%i) = %f -- CODE: ", i, i, shuffle_list( i ) );
    printf( coding{ find( Px == shuffle_list( i ) ) } );
    printf( "\t|" );
  endfor
  printf( "\n     \t_________________________________________________\n" );
  printf( "\n\n" );
endfunction