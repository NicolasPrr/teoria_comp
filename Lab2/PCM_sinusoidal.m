% Aplicando PCM a una se�al sinusoidal  de 1 Hz.

T=2;                                             % duraci�n de la se�al
Fm=1; Fs=4; Ts=1/Fs;                    % ancho de banda = 1, frecuencia max. = 1 Hz, fs >= 2*fm = 2 Hz, Ts = 1/Fs
N=T/Ts;                                        % numero de muestras
t=[0:Ts:T];                                     % vector de tiempo
x=2.5*cos((2*pi*t)+(pi/2));            % sinusoidal muestreada
wm=2*pi*Fm;
[xq,xqcode]=cuant_and_coder(x,2.5,4); % cuant_and_coder(x,xmax,n): cuantiza x sobre (-xmax,xmax) usando 2^n niveles y codifca los valores cuantizados de x.
xq                                                  % valores de la se�al cuantizados
xqcode                                           % esto es lo que se traduce al formato de onda de pulsos


UNRZ = xqcode; #Vector que contiene la representaci�n en xqcodes de la forma UNRZ

  ## plot de la onda digital de la forma Unipolar NRZ
  figure( 2 );
  subplot( 6, 1, 1 );
  stairs( [0:length( UNRZ )-1], UNRZ );
  ylim( [-1 2] );
  title( "Unipolar NRZ" );
  grid;

  BNRZ = xqcode; #Vector que contiene la representaci�n en xqcodes de la forma BNRZ

  ## Se hace la conversi�n de UNRZ a BNRZ
  for i = 1:length( xqcode )
    if( BNRZ(i) == 0 )
      BNRZ( i ) = -1;
    endif
  endfor
  ## end

  ## plot de la onda digital de la forma Bipolar NRZ
  subplot( 6, 1, 2 );
  stairs( [0:length( BNRZ )-1], BNRZ ); 
  ylim( [-2 2] );
  title( "Bipolar NRZ" );
  grid;
  ## end plot

  URZ = [];#Vector que contiene la representaci�n en xqcodes de la forma URZ
  cont = 1;

  ## Se hace la conversi�n de UNRZ a URZ
  for i = 1:length( xqcode )
    if( xqcode( i ) == 1 )
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
  stairs( [0:0.5:length( xqcode ) - 0.5], URZ );
  ylim( [ -1 2 ] );
  title( "Unipolar RZ" )
  grid;
  ## end plot

  BRZ = [];#Vector que contiene la representaci�n en xqcodes de la forma BRZ
  cont = 1;

  ## Se hace la conversi�n de UNRZ a BRZ
  for i = 1:length( xqcode )
    if( xqcode( i ) == 1 )
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
  stairs( [0:0.5:length( xqcode ) - 0.5], BRZ );
  ylim( [ -2 2 ] );
  title( "Bipolar RZ" );
  grid;
  ## end

  AMI = []; #Vector que contiene la representaci�n en xqcodes de la forma AMI
  flag = true;
  cont = 1;

  ## Se hace la conversi�n de UNRZ a AMI
  for i = 1:length( xqcode )
    if( xqcode( i ) == 1 && flag == true )
      AMI( cont ) = 1;
      AMI( cont + 1 ) = 0;
      flag = false;
    elseif( xqcode( i ) == 1 && flag == false )
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
  stairs( [0:0.5:length( xqcode ) - 0.5], AMI );
  ylim( [ -2 2 ] );
  title( "AMI" );
  grid;
  ## end plot


  manchester = []; #Vector que contiene la representaci�n en xqcodes de la forma manchester
  cont = 1;

  ## Se hace la conversi�n de UNRZ a manchester
  for i = 1:length( xqcode )
    if( xqcode( i ) == 1 )
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
  stairs( [0:0.5:length( xqcode ) - 0.5], manchester );
  ylim( [ -2 2 ] );
  title( "Manchester" );
  grid;
  ## end plot
