function [ z dx dy ] = vals( x1, x2 )
%VALS calculates values of diff for the given function at given x, y
%   Function implements partial deravitions statically and returns the x, y values
%   of the function
%
%   author Oliver Erxleben

  z = ((x1+1).^2 + (x2+1).^2) .* ((x1-2).^2 + (x2-1).^2) + x1 + x2;
  dx = (2.*x1+2).*((x1-2).^2 + (x2-1).^2) + ((x1+1).^2 + (x2+1).^2).*(2.*x1-4) + 1;
  dy = (2.*x2+2).*((x1-2).^2 + (x1-1).^2) + ((x1+1).^2 + (x2+1).^2).*(2.*x2-2) + 1; 
end

