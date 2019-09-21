
%Lista de funciones:

my_fun1 = '-1*((x > -pi/2) & (x < 0 )) +  ((x > 0 ) & x < pi/2)  ';
my_fun2 = 'x.^2';
my_fun3 = '-abs(x) + 1';
my_fun4 = '(x > -pi/2) & (x < pi/2)';
my_fun5 = '-abs(x) + pi/2';



my_funcs = {my_fun1,my_fun2,my_fun3,my_fun4, my_fun5};

%Rangos para funciones

my_range1 = [0,pi];
my_range2 = [-pi, pi];
my_range3 = [0,1]
my_range4 = [0,2*pi];
my_range5= [-pi/2,pi/2];
my_range6= [0,pi/2];
my_range7= [0,pi/4];
my_range8= [-pi/4,pi/4];

my_ranges = {my_range1, my_range2,my_range3, my_range4, my_range5,my_range6,my_range7,my_range8};

clc;

%my_ranges{1}(2)
%columns(my_ranges)

%Listar todas las funciones
for i = [1:columns(my_funcs)]
    disp(strcat(num2str(i),') ' , my_funcs{i} ));
end
disp('6) Otro')

option = input('Cual funcion desea usar?');

if option >  0 & option < 6
    xt = inline(my_funcs{option},'x');
    my_title = my_funcs{option};
else
    clc
    new_func = input("Escriba la funcion  que desea usar\n" , "s");

    xt = inline(new_func,'x');
    my_title = new_func;
end

%Listar todos los rangos
for i = [1:columns(my_ranges)]
      txt =  strcat(' [' , num2str(my_ranges{i}(1)),',  ', num2str(my_ranges{i}(2)) , ']');
    disp(strcat(num2str(i),')' ,txt ));
end
option = input("Seleccione el rango para el periodo:\n");

txt =  strcat(' [' , num2str(my_ranges{option}(1)),',  ', num2str(my_ranges{option}(2)) , ']');
from_a = my_ranges{option}(1);
to_b = my_ranges{option}(2);


t = [-2.5*pi:0.01:3*2.5];


T = to_b - from_a;
w = 2*pi/T;




%  Ejemplo para calcular el k-eisimo termino correspondiente%
%%________________________________________________________
%%a_k = 2/T*quadl( @(x) my_cos(x,1,w,xt) , from_a,to_b); /
%%b_k = 2/T*quadl( @(x) my_sin(x,3,w,xt) , from_a,to_b);/
%______________________________________________________/
disp("running plot 1")
k = 1;
sub_k = strcat('x_{', int2str(k),'}(t)');
subplot(4,1,1);plot(t,xt(t)-0.1,'-r',t,my_sum(t,k,w,xt,from_a,to_b), '-g',[from_a,from_a],[-5,5],'-b',[to_b,to_b],[-5,5],'-b'  );title(my_title);
xlabel('t');ylabel('x(t)');grid;legend('x(t)', sub_k,txt) ;ylim([-2 2]);
clc

disp("running plot 2")
k = 5;
sub_k = strcat('x_{', int2str(k),'}(t)');
subplot(4,1,2);plot(t,xt(t),'-r',t,my_sum(t,k,w,xt,from_a,to_b), '-g');
xlabel('t');ylabel('x(t)');grid; legend('x(t)', sub_k);ylim([-2 2]);
clc

disp("running plot 3")


k = 10;
sub_k = strcat('x_{', int2str(k),'}(t)');
subplot(4,1,3);plot(t,xt(t),'-r',t,my_sum(t,k,w,xt,from_a,to_b), '-g');
xlabel('t');ylabel('x(t)');grid;legend('x(t)', sub_k);ylim([-2 2]);

clc

disp("running plot 4")

k = 50;
sub_k = strcat('x_{', int2str(k),'}(t)');
subplot(4,1,4);plot(t,my_sum(t,k,w,xt,from_a,to_b), '-g');
xlabel('t');ylabel('x(t)');grid;legend( sub_k);ylim([-2 2]);

disp("ok")



