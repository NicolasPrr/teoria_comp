#Universidad Nacional de Colombia Sede Bogot�
#Teor�a de la informaci�n y sistemas de comunicaciones
#Taller 3

#Algoritmo de huffman puesto en marcha
function y = huffman( Px )
  #shuffle list es la lista sin ordenar. Tal como es pasada a la funci�n
  shuffle_list = Px;
  
  #Px es la lista ya ordenada
  Px = sort( Px, "descend" );
  
  #size es el tama�o de la lista de probabilidades 
  size = length( Px );
  
  last = size;
  cont = 1;
  cont2 = 0;
  
  #marks hace referencia a las probabilidades que son producto de una suma
  marks = zeros( 1, last - 2 );
  
  #m_probab hace referencia a la matriz de probabilidades presentes en el algoritmo
  m_probab = zeros( size, size - 1 );
  m_probab( 1:size ) = Px;
  
  #Dentro de este ciclo for, se rellenar� la matriz con todos sus correspondientes valores de probabilidades
  for i = 1:( size - 2 )
    #En sum se guarda la la suma de los 2 �ltimos valores del arreglo anterior
    sum = m_probab( last + ( size * cont2 ) ) + m_probab( last + ( size * cont2 ) - 1 );
    
    #En vec_aux se almacenar�n todos los valores del nuevo vector
    vec_aux = zeros( 1, last );
    vec_aux = m_probab( 1 + ( size * cont2 ):( last - 2 ) + ( size * cont2 ) );
    vec_aux( last - 1 ) = sum;
    last = last - 1;
    m_probab( 1 + ( size * cont ) : last + ( size * cont ) ) = sort( vec_aux, "descend" );
    
    #pos_mark es la posici�n en la que est� el valor que fue producto de la suma de los �ltimos
    #dos valores del vector anterior
    pos_mark = find( sort( vec_aux, "descend" ) == sum );

    #Si el valor de sum se encuentra m�s de una vez en vec_aux, se toma el �ltimo de estos valores
    if( length( pos_mark ) == 1 )
      marks( cont ) = pos_mark( 1 );
    else
      marks( cont ) = pos_mark( end );
    endif

    cont = cont + 1;
    cont2 = cont2 + 1;
  endfor
  
  #en coding se almacenar� el c�digo para cada s�mbolo
  coding = cell( 1, last );
  vec_aux = zeros( 1, last );
  coding( 1 ) = "0";
  coding( 2 ) = "1";
  cont = cont - 1;
  len_last_vec = 2;

  #En este ciclo for se har� la codificaci�n de los s�mbolos, acorde al algoritmo de Huffman
  for i = 1:( size - 2 ) 
    mark = marks( cont );
    carry = coding( 1, mark );
    cont = cont - 1;
    
    #vec_aux contendr� cada uno de los vectores de la matriz de probabilidades
    #de atr�s hacia adelante
    vec_aux = zeros( 1, last );
    vec_aux = m_probab( ( ( size * ( cont + 1 ) ) - ( size - 1 ):( size * ( cont + 1 ) ) - ( size - ( len_last_vec + 1 ) ) ) );
    
    aux_cod = cell( 1, ( last + 1 ) );
  
    #Se concatena un 0 o un 1, dependiendo de cu�l n�mero es mayor
    aux_cod( length( aux_cod ) - 1 ) = strcat( carry, "0" );
    aux_cod( length( aux_cod ) ) = strcat( carry, "1" );
    
    #Si mark es diferente de last, entonces hay que copiar los n�meros que se quedan 
    #sin sin modificaci�n 
    if( mark != last )
      pass = coding( ( mark + 1 ):last );
      aux_cod( last - length( pass ):( mark + length( pass ) ) - 1 ) = pass;
      if mark - length( pass ) > 1
        aux_cod( 1:mark - length( pass ) ) = coding( 1:mark - length( pass ) );
      endif
    #En caso contrario, todos los n�meros quedan sin cambios
    else
      aux_cod( 1:mark - 1 ) = coding( 1, mark - 1 );
    endif  
     
    aux_cod;
    
    #coding ser� quien contendr� todos los c�digos para cada simbolo
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