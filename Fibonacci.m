func = @(x) x.^2 - sin(x);
x_start = -4;
x_finish = 6;


n = 20;
n=n+1;

for ii=1:n
    if ii==1||ii==2
        g(ii)=1;   
    else
        g(ii)=g(ii-1)+g(ii-2);
    end
end

L0 = x_finish - x_start; 
L2 = (g(n-2)/g(n))*L0;
x1 = x_start + L2;
x2 = x_finish - L2;

iteration = 1;
%disp('iteration  x_lower  f(x_lower)  x_upper  f(x_upper)')

for k = 2:n
    
    if func(x1) < func(x2)
        x_finish = x2;
        xi = x_start + x2 - x1;
        if xi > x1
            x2 = xi;
        else
            x2 = x1;
            x1 = xi;            
        end
        iteration = iteration + 1;
    elseif func(x1) == func(x2)
        x_start = x1;
        x_finish = x2;
        L2 = (g(n-2)/g(n))*(x_finish-x_start);
        x1 = x_start + L2;
        x2 = x_finish - L2;   
        iteration = iteration + 1;
    else %func(x1) > func(x2)
        x_start = x1;
        xi = x_start + x2 - x1;
        if xi > x2
            x2 = xi;
            x1 = x2;
        else
            xi = x1;
        end
        iteration = iteration + 1;
    end
    Ln = x2 - x1;
    error = abs(Ln/L0);
end
x_opt = Ln/2;
fprintf('\nThe final interval of uncertainity is %f-%f',x1,x2)
fprintf('\nThe total iterations: ',iteration)
fprintf('\nMinimum point is when x = %f\n',x_opt)