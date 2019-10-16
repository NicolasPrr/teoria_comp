function y = my_sum(t, N, w,f , from_a, to_b)
    T = to_b - from_a;
    y = 0;
    a_0 = 2/T*quad(f, from_a,to_b);

    for i = [1:N]
        
        a_i = 2/T*quadl( @(x) my_cos(x,i,w,f) , from_a,to_b);
        b_i = 2/T*quadl( @(x) my_sin(x,i,w,f) , from_a,to_b);
        y = y + a_i*cos(t*w*i)  + b_i*sin(t*w*i);
    end 
    y = y + a_0/2;
end