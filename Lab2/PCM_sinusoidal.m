% Aplicando PCM a una seï¿½al sinusoidal  de 1 Hz.

T=2;                                             % duraciï¿½n de la seï¿½al
%fm > n
Fm=1; Fs=4; Ts=1/Fs;                    % ancho de banda = 1, frecuencia max. = 1 Hz, fs >= 2*fm = 2 Hz, Ts = 1/Fs
N=T/Ts;    % numero de muestras
A = 4                                     
t=[0:Ts:T];
tx=[0:0.01:T];                                     % vector de tiempo
x=A*cos((2*pi*Fm*t)+(pi/2));            % sinusoidal muestreada
xt=A*cos((2*pi*Fm*tx)+(pi/2));            % sinusoidal muestreada

wm=2*pi*Fm;
[xq,xqcode]=cuant_and_coder(x,A,3); % cuant_and_coder(x,xmax,n): cuantiza x sobre (-xmax,xmax) usando 2^n niveles y codifca los valores cuantizados de x.
xq                                                  % valores de la seï¿½al cuantizados
xqcode                                           % esto es lo que se traduce al formato de onda de pulsos


figure(1)
subplot( 3, 1, 1 );plot(tx,xt);title("Señal original")
subplot( 3, 1, 2 );stem(t,x);title("Señal muestrada");grid;
subplot( 3, 1, 3 );stem(t,xq);title("Señal cuantizada");grid;
  


#Vector que contiene la representaciï¿½n en xqcodes de la forma UNRZ
array_xqcode = reshape(xqcode',1, rows(xqcode)*columns(xqcode));

UNRZ =  array_xqcode;
figure(2)
  ## plot de la onda digital de la forma Unipolar NRZ
  figure( 2 );
  subplot( 6, 1, 1 );
  stairs( [0: (length(UNRZ) -1) ], [UNRZ]);
  ylim( [-2 2] );
  title( "Unipolar NRZ" );
  set(gca,'XTick',[0: (length(UNRZ) -1) ]);
  xlim( [0 length(array_xqcode)] );

  grid;
  

  BNRZ = array_xqcode ;
  BNRZ = (BNRZ == 1) - (BNRZ == 0) ;
  

  ## end
 
  ## plot de la onda digital de la forma Bipolar NRZ
  subplot( 6, 1, 2 );
  stairs( [0:length( BNRZ )-1], BNRZ ); 
  ylim( [-2 2] );
  title( "Bipolar NRZ" );
  set(gca,'XTick',[0: (length(array_xqcode) -1) ]);
  xlim( [0 length(array_xqcode)] );
  grid;
  ## end plot

  URZ = [];#Vector que contiene la representaciï¿½n en xqcodes de la forma URZ
  cont = 1;

  ## Se hace la conversiï¿½n de UNRZ a URZ
  for i = 1:length( array_xqcode )
    if( array_xqcode( i ) == 1 )
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
  stairs( [0:0.5:length( array_xqcode ) - 0.5], URZ );
  ylim( [ -2 2 ] );
  title( "Unipolar RZ" )
  set(gca,'XTick',[0: (length(array_xqcode) -1) ]);
  xlim( [0 length(array_xqcode)] );
  
 
  grid;
  ## end plot

  BRZ = [];#Vector que contiene la representaciï¿½n en xqcodes de la forma BRZ
  cont = 1;

  ## Se hace la conversiï¿½n de UNRZ a BRZ
  for i = 1:length( array_xqcode )
    if( array_xqcode( i ) == 1 )
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
  stairs( [0:0.5:length( array_xqcode ) - 0.5], BRZ );
  ylim( [ -2 2 ] );
  title( "Bipolar RZ" );
  set(gca,'XTick',[0:(length(array_xqcode) -1) ]);
  xlim( [0 length(array_xqcode)] );
  grid;
  ## end

  AMI = []; #Vector que contiene la representaciï¿½n en xqcodes de la forma AMI
  flag = true;
  cont = 1;

  ## Se hace la conversiï¿½n de UNRZ a AMI
  for i = 1:length( array_xqcode )
    if( array_xqcode( i ) == 1 && flag == true )
      AMI( cont ) = 1;
      AMI( cont + 1 ) = 0;
      flag = false;
    elseif( array_xqcode( i ) == 1 && flag == false )
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
  stairs( [0:0.5:length( array_xqcode ) - 0.5], AMI );
  ylim( [ -2 2 ] );
  title( "AMI" );
  set(gca,'XTick',[0:(length(array_xqcode) -1) ])
  xlim( [0 length(array_xqcode)] );

  grid;
  ## end plot


  manchester = []; #Vector que contiene la representaciï¿½n en xqcodes de la forma manchester
  cont = 1;

  ## Se hace la conversiï¿½n de UNRZ a manchester
  for i = 1:length( array_xqcode )
    if( array_xqcode( i ) == 1 )
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
  stairs( [0:0.5:length( array_xqcode ) - 0.5], manchester );
  ylim( [ -2 2 ] );
  title( "Manchester" );
  set(gca,'XTick',[0:(length(array_xqcode) -1) ])
  xlim( [0 length(array_xqcode)] );
  
  grid;
  ## end plot
  
  Fs2 = 400; Ts2 = 1/Fs2;
  N2 = T/Ts2;
  t3 = [0:Ts2:T];
  x2=[]
  t
  for t2=0:N2
    x2(t2+1) = sum(xq.*(sin(wm*(t*(-1)) +t2 )/(wm*(t*(-1)) +t2 )));
  endfor
  figure(3)
  stem(t3,x2);