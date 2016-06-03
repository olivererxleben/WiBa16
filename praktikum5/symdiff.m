function [fxdx, dy] = symdiff( f, range )
% SYMDIFF creates diff for given symbolic expression and evaluates the y
% values 
% 
%   PARAMETER f function of type (@x)(x^2 + 3x + 1)
%   PARAMS range x-vector

syms x y; 
fxdx = diff(sym(f), x);
dy = subs(fxdx, range);

end