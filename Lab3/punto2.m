disp("punto 2")
warning('off', 'all');
clc

#La funcion nos permite verificar si los inputs del archivo p(x) estan bien
function y = verification_p(array)
  sum = 0;
  for i = array
    sum = sum + i;
  end
  if sum == 1
    y = true;
    return
  endif
  y = false;
endfunction

file_name = "P(X)Huffman.TXT";
Px = load (file_name, "R")

allow = verification_p(Px);

if allow

  PX_sorted = fliplr(sort(Px));
  long = length(PX_sorted); 
  long2 = long - 2;
  prob_matrix = zeros(long,long - 1);
  prob_matrix(1:long)=PX_sorted;
  counter = 1 ;
  counter2 = 0;
  last_pos = long;
  marked = zeros(1,last_pos - 2);

  for i = 1 : 1 : long2 

    sum = prob_matrix(last_pos + (long * counter2 )) + prob_matrix(last_pos + (long * counter2 ) - 1);
    aux_arr = zeros(1,last_pos);
    aux_arr = prob_matrix(1 + (long * counter2 ):(last_pos - 2) + (long * counter2 ));

    aux_arr(last_pos - 1) = sum;
    last_pos = last_pos - 1;
    arr_final = fliplr(sort(aux_arr));
    prob_matrix(1 + (long * counter)  : last_pos + (long * counter ) ) = arr_final;
    pos_marc = find(arr_final==sum);

      if length(pos_marc) == 1
         marked(counter) = pos_marc(1);
       else
        marked(counter) = pos_marc(length(pos_marc));
       endif

    counter = counter + 1;
    counter2 = counter2 + 1;
  endfor

  prob_matrix
  codification = cell(1,last_pos);
  aux_arr = zeros(1,last_pos);
    codification(1) = "0";
    codification(2) = "1";
  codification
  counter = counter -1 ;
  counter3 = 2;


  for i = 1 : 1 : long2 

    visited = marked(counter);
    carry = codification(1,visited);
    counter = counter - 1;
    aux_arr = zeros(1,last_pos);
    aux_arr = prob_matrix(((long * (counter+1)) - (long - 1) : (long*(counter+1)) - (long - (counter3+1))));
    aux_cod = cell(1,last_pos + 1);
   
    
        aux_cod(length(aux_cod) - 1) =strcat(carry,"0");
        aux_cod(length(aux_cod) ) = strcat(carry, "1");
    

     if visited != last_pos
        ignore = codification(visited + 1:last_pos);
        aux_cod(last_pos - length(ignore):(visited + length(ignore)) - 1) = ignore;
        if visited - length(ignore) > 1
        aux_cod(1:visited - length(ignore) ) = codification(1:visited - length(ignore));
       endif
     else

        aux_cod(1:visited - 1) = codification(1, visited - 1);
    endif  
     
        aux_cod
        codification = cell(1,last_pos + 1);
        codification = aux_cod;
     
     counter3 = counter3 + 1;
    last_pos = last_pos + 1;
  endfor

  codes = aux_cod 
  

else
  disp("P(X) FORMAT: wrong input")
endif

