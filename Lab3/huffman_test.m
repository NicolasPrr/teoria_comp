function y = huffman_test( Px )
  list = cell( 1, length( Px ) - 1 );
  for i = 1:length( list )
    list{ i } = cell( 1, 3 );
  endfor
  Px = sort( Px, "descend" );
  list{ 1 }{ 1 } = Px;

  for i = 2:( length( Px ) - 1 )
    list{ i }{ 1 } = list{ i - 1 }{ 1 }( 1:( end - 2 ) );
    list{ i }{ 1 }( end + 1 ) = list{ i - 1 }{ 1 }( end ) + list{ i - 1 }{ 1 }( end - 1 );
    list{ i }{ 2 } = [ list{ i - 1 }{ 1 }( end - 1 ), list{ i - 1 }{ 1 }( end ) ];
    list{ i }{ 1 } = sort( list{ i }{ 1 }, "descend" );
  endfor
  list{ end }{ 3 } = { "0", "1" };
  find( list{ 4 }{ 1 } == 0.3 );
  
  for i = 1:( length( list ) - 1 )
    list{ i }{ 3 } = cell( 1, length( Px ) );
  endfor
  #list
  for i = ( length( list ) ):-1:2
    flag1 = true;
    flag2 = true;
    for j = 1:( length( list{ i }{ 1 } ) )
      flag3 = true;
      if( ( list{ i }{ 2 }( 1 ) + list{ i }{ 2 }( 2 ) ) == list{ i }{ 1 }( j ) )
        for k = length( list{ i - 1 }{ 1 } ):-1:1 
          #printf( "jaaa %i ", k )
          if( list{ i }{ 2 }( 1 ) == list{ i - 1 }{ 1 }( k ) && flag1 )
            #printf( "--%i-- ", k )
            list{ i - 1 }{ 3 }{ k } = strcat( list{ i }{ 3 }{ j }, "0" );
            flag1 = false;
          endif
          if( list{ i }{ 2 }( 2 ) == list{ i - 1 }{ 1 }( k ) && flag2 )
            #printf( "++%i++ ", k )
            list{ i - 1 }{ 3 }{ k } = strcat( list{ i }{ 3 }{ j }, "1" );
            flag2 = false;
          endif
        endfor
      else
        for k = 1:length( Px )
          if( isempty( list{ i - 1 }{ 3 }{ k } ) && flag3)
            #printf( "find" );
            flag3 = false;
            list{ i - 1 }{ 3 }{k} = list{ i }{ 3 }{ j };
          endif  
        endfor
      endif
      #list
    endfor
  endfor
  list
endfunction
