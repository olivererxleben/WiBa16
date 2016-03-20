%% Newtonverfahren 2a

function y = newtonCos(x)

s = 1; % start val
e = 100; % max end val
xt = 0;

for i = s:e
    xt = x;
    fx = 2*cos(x)-x;
    dx = -2*sin(x)-1;
    x = x - fx / dx;
    
    if ((x - xt) < 10^(-10))
        disp(i);
        y = x;
        break
    end  
end
end
