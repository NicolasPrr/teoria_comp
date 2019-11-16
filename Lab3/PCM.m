function y = PCM( w )
  tmin = 0;  #Tiempo límite inferior
  tmax = 10;  #Tiempo límite superior
  t = [tmin:0.01:tmax]; #Vector de tiempo
  wMax = max( w ); #Frecuencia máxima entre todas las frecuencias ingresadas
  wMuestreo = 2*wMax; #Frecuencia de muestreo (el doble de la frecuencia máxima)
  TMuestreo = (1/wMuestreo); #Periodo de muestreo
  sampleVector = [tmin:TMuestreo:tmax]; #Vector de tiempos de muestreo
  
  figure( 1 );
  ## Plot de la onda anamógica
  subplot( 2, 2, 1 );
  plot( t, fun( t, w ) ); title( "Onda analógica" ); 
  xlabel( "t" ); 
  ylabel( "m( t )" );
  grid;
  ## end plot 
  
  ## Plot de la onda analógica muestreada
  subplot( 2, 2, 2 );
  stem( sampleVector, fun( sampleVector, w ), '.' );
  title( "Onda analógica muestreada" );
  xlabel( "t" );
  ylabel( "m_{s}( t )" );
  grid;
  ## end plot
  
  m_p = 3; #Amplitud de muestreo
  L = 8; #Número de intervalos
  Delta = ( 2*m_p )/L; #Delta de cada intervalo
  DeltaVector = [-m_p:Delta:m_p]; #Vector que contiene el límite superior e inferior de todos los Deltas
  
  ##Cada uno de estos Delta contiene el límite superior, límite inferior, valor medio y código numérico
  Delta1 = [DeltaVector(1), DeltaVector(2), (DeltaVector(1)+DeltaVector(2))/2, 0];
  Delta2 = [DeltaVector(2), DeltaVector(3), (DeltaVector(2)+DeltaVector(3))/2, 1];
  Delta3 = [DeltaVector(3), DeltaVector(4), (DeltaVector(3)+DeltaVector(4))/2, 2];
  Delta4 = [DeltaVector(4), DeltaVector(5), (DeltaVector(4)+DeltaVector(5))/2, 3];
  Delta5 = [DeltaVector(5), DeltaVector(6), (DeltaVector(5)+DeltaVector(6))/2, 4];
  Delta6 = [DeltaVector(6), DeltaVector(7), (DeltaVector(6)+DeltaVector(7))/2, 5];
  Delta7 = [DeltaVector(7), DeltaVector(8), (DeltaVector(7)+DeltaVector(8))/2, 6];
  Delta8 = [DeltaVector(8), DeltaVector(9), (DeltaVector(8)+DeltaVector(9))/2, 7];
  
  cuantizado = []; #Vector que contiene los valores de la onda muestreada pero ya cuantizados
  bit = []; #Vector que contiene la onda cuantizada pero representada en bits
  
  ##Variables auxiliares
  cont = 1;
  contBit = 1;
  
  ## Se cuantiza cada valor muestreado y se codifica
  for i = sampleVector
    if fun( i, w ) >= Delta1( 1 ) && fun( i, w ) < Delta1( 2 )
      cuantizado( cont ) = Delta1( 3 );
      bit( contBit ) = 0;
      bit( contBit + 1 ) = 0;
      bit( contBit + 2 ) = 0;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta1( 3 ) );
      printf( "\n Code Number: %i", Delta1( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 0, 0, 0 );
      
    elseif fun( i, w ) >= Delta2( 1 ) && fun( i, w ) < Delta2( 2 )
      cuantizado( cont ) = Delta2( 3 );
      bit( contBit ) = 0;
      bit( contBit + 1 ) = 0;
      bit( contBit + 2 ) = 1;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta2( 3 ) );
      printf( "\n Code Number: %i", Delta2( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 0, 0, 1 );
      
    elseif fun( i, w ) >= Delta3( 1 ) && fun( i, w ) < Delta3( 2 )
      cuantizado( cont ) = Delta3( 3 );
      bit( contBit ) = 0;
      bit( contBit + 1 ) = 1;
      bit( contBit + 2 ) = 0;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta3( 3 ) );
      printf( "\n Code Number: %i", Delta3( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 0, 1, 0 );
      
    elseif fun( i, w ) >= Delta4( 1 ) && fun( i, w ) < Delta4( 2 )
      cuantizado( cont ) = Delta4( 3 );
      bit( contBit ) = 0;
      bit( contBit + 1 ) = 1;
      bit( contBit + 2 ) = 1;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta4( 3 ) );
      printf( "\n Code Number: %i", Delta4( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 0, 1, 1 );
      
    elseif fun( i, w ) >= Delta5( 1 ) && fun( i, w ) < Delta5( 2 )
      cuantizado( cont ) = Delta5( 3 );
      bit( contBit ) = 1;
      bit( contBit + 1 ) = 0;
      bit( contBit + 2 ) = 0;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta5( 3 ) );
      printf( "\n Code Number: %i", Delta5( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 1, 0, 0 );
      
    elseif fun( i, w ) >= Delta6( 1 ) && fun( i, w ) < Delta6( 2 )
      cuantizado( cont ) = Delta6( 3 );
      bit( contBit ) = 1;
      bit( contBit + 1 ) = 0;
      bit( contBit + 2 ) = 1;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta6( 3 ) );
      printf( "\n Code Number: %i", Delta6( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 1, 0, 1 );
      
    elseif fun( i, w ) >= Delta7( 1 ) && fun( i, w ) < Delta7( 2 )
      cuantizado( cont ) = Delta7( 3 );
      bit( contBit ) = 1;
      bit( contBit + 1 ) = 1;
      bit( contBit + 2 ) = 0;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta7( 3 ) );
      printf( "\n Code Number: %i", Delta7( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 1, 1, 0 );
      
    elseif fun( i, w ) >= Delta8( 1 ) && fun( i, w ) <= Delta8( 2 )
      cuantizado( cont ) = Delta8( 3 );
      bit( contBit ) = 1;
      bit( contBit + 1 ) = 1;
      bit( contBit + 2 ) = 1;
      printf( "\n Sampled Value: %f", fun( i, w ) );
      printf( "\n Quantized Value: %f", Delta8( 3 ) );
      printf( "\n Code Number: %i", Delta8( 4 ) );
      printf( "\n Binary Code: %i %i %i\n", 1, 1, 1 );
    endif
    cont = cont + 1;
    contBit = contBit + 3;
  endfor
  ## end cuantizar i codificar
  
  ## plot de la onda cuantizada
  subplot( 2, 2, 3 );
  stem( sampleVector, cuantizado,'.' ); 
  title( "Onda cuantizada" );
  grid;
  ##end plot
  
  ##Plot de la función de cuantización uniforme
  subplot( 2, 2, 4 );
  stairs( DeltaVector, [Delta1(3),Delta2(3),Delta3(3),Delta4(3),Delta5(3),Delta6(3),Delta7(3),Delta8(3),Delta8(3)] );
  title( "Función cuantizacion uniforme" );
  xlabel( "Input" );
  ylabel( "Output" );
  grid;
  ##End plot
  
  
  UNRZ = bit; #Vector que contiene la representación en bits de la forma UNRZ
  
  ## plot de la onda digital de la forma Unipolar NRZ
  figure( 2 );
  subplot( 6, 1, 1 );
  stairs( [0:length( UNRZ )-1], UNRZ ); ylim( [-1 2] );
  title( "Unipolar NRZ" );
  grid;
  ## end plot
  
  BNRZ = bit; #Vector que contiene la representación en bits de la forma BNRZ
  
  ## Se hace la conversión de UNRZ a BNRZ
  for i = 1:length( bit )
    if( BNRZ(i) == 0 )
      BNRZ( i ) = -1;
    endif
  endfor
  ## end
  
  ## plot de la onda digital de la forma Bipolar NRZ
  subplot( 6, 1, 2 );
  stairs( [0:length( BNRZ )-1], BNRZ ); ylim( [-2 2] );
  title( "Bipolar NRZ" );
  grid;
  ## end plot
  
  URZ = [];#Vector que contiene la representación en bits de la forma URZ
  cont = 1;
  
  ## Se hace la conversión de UNRZ a URZ
  for i = 1:length( bit )
    if( bit( i ) == 1 )
      URZ( cont ) = 1;
      URZ( cont + 1 ) = 0;
    else
      URZ( cont ) = 0;
      URZ( cont + 1 ) = 0;
    endif
    cont = cont + 2;
  endfor
  ##end

  ## plot de la onda digital de la forma Unipolar RZ
  subplot( 6, 1, 3 );
  stairs( [0:0.5:length( bit ) - 0.5], URZ );
  ylim( [ -1 2 ] );
  title( "Unipolar RZ" )
  grid;
  ## end plot
  
  BRZ = [];#Vector que contiene la representación en bits de la forma BRZ
  cont = 1;
  
  ## Se hace la conversión de UNRZ a BRZ
  for i = 1:length( bit )
    if( bit( i ) == 1 )
      BRZ( cont ) = 1;
      BRZ( cont + 1 ) = 0;
    else
      BRZ( cont ) = -1;
      BRZ( cont + 1 ) = 0;
    endif
    cont = cont + 2;
  endfor
  ## end
  
  ## plot de la onda digital de la forma Bipolar RZ
  subplot( 6, 1, 4 );
  stairs( [0:0.5:length( bit ) - 0.5], BRZ );
  ylim( [ -2 2 ] );
  title( "Bipolar RZ" );
  grid;
  ## end
  
  AMI = []; #Vector que contiene la representación en bits de la forma AMI
  flag = true;
  cont = 1;
  
  ## Se hace la conversión de UNRZ a AMI
  for i = 1:length( bit )
    if( bit( i ) == 1 && flag == true )
      AMI( cont ) = 1;
      AMI( cont + 1 ) = 0;
      flag = false;
    elseif( bit( i ) == 1 && flag == false )
      AMI( cont ) = -1;
      AMI( cont + 1 ) = 0;
      flag = true;
    else
      AMI( cont ) = 0;
      AMI( cont + 1 ) = 0;
    endif
    cont = cont + 2;
  endfor
  ## end
  
  ## plot de la onda digital de la forma AMI
  subplot( 6, 1, 5 );
  stairs( [0:0.5:length( bit ) - 0.5], AMI );
  ylim( [ -2 2 ] );
  title( "AMI" );
  grid;
  ## end plot
  
  
  manchester = []; #Vector que contiene la representación en bits de la forma manchester
  cont = 1;
  
  ## Se hace la conversión de UNRZ a manchester
  for i = 1:length( bit )
    if( bit( i ) == 1 )
      manchester( cont ) = 1;
      manchester( cont + 1 ) = -1;
    else
      manchester( cont ) = -1;
      manchester( cont + 1 ) = 1;
    endif
    cont = cont + 2;
  endfor
  ## end
  
  ## plot de la onda digital de la forma manchester
  subplot( 6, 1, 6 );
  stairs( [0:0.5:length( bit ) - 0.5], manchester );
  ylim( [ -2 2 ] );
  title( "Manchester" );
  grid;
  ## end plot
  
endfunction
