function [ x, e, n ] = newtonPoly( a, x )
% Task 2b
%   Did not used polyder() or polyvar() 

xt = 0; % temp x (n-1)
e = 0;
for n = 1:100
    xt = x;
    fx = x^5 - x^4 - 13*x^3 + 13*x^2 + 36*x + a;
    dx = 5*x^4 - 4*x^3 - 39*x^2 + 26*x + 36;
    
    x = x - fx/dx;
    if (x - xt < 10^(-10))
        e = 1;
        
        break
    end
    
end

end

