function [xi, z, idx_x, i] = findmingd(max_iterations)
%findmingd searches for minima at a specific function via gradient
%algorithm 
% 
%   
%   author Oliver Erxleben, Jens Overmöller 

  %% data preperation
  % Intervalls with 0.1 increment
  x = -2:.1:3; 
  y = -2:.1:3;
  
  % 2 dimensianal grid data of rectangle
  [X,Y] = meshgrid(x,y);

  % function values
  Z = ((X+1).^2 + (Y+1).^2) .* ((X-2).^2 + (Y-1).^2) + X + Y;

  % partial derivations fdx
  %deriv_X = (2.*X+2).*((X-2).^2 + (Y-1).^2) + ((X+1).^2 + (Y+1).^2).*(2.*X-4) + 1;
  dx = (2.*x+2).*((x-2).^2 + (y-1).^2) + ((x+1).^2 + (y+1).^2).*(2.*x-4) + 1; 
  
  %% start 

  % plot start
  h = figure(1);
  set(h,'Position',[100 0 1500 768]);
  hMeshFig = subplot(1,2,2); 
  mesh(X,Y,Z);
  hContFig = subplot(1,2,1); 
  contour(X,Y,Z,30);
  hold on;

  % "random" values selected by user input 
  [x_start,y_start] = ginput(1);
  plot3(x_start,y_start,vals(x_start,y_start),'+r');

  % steprange
  %sr = 1.25;
  sr = 0.01;
  i = 0;

  %% loop
      % So lange an Nullpunkt ann?hern bis sich naechster Annaeherungspunkt nicht mehr als 0.01 unterscheidet
      % oder 100 Schleifendruchlaeufe gemacht wurden
  while(i <= max_iterations)
    % iterate max 100 loops or cancel if convergence of points < 0.01
         
    % problems at random start values, need to be rounded
    [~,idx_x] = min(abs(x-x_start));
    [~,idx_y] = min(abs(y-y_start));
          
    % values for x,y
    x_start = x(idx_x);
    y_start = y(idx_y);
    
    % values of functions and gradient at the starting point
    [z, dx_start, dy_start] = vals(x_start,y_start);

    % assume: minima from positive to negative => calc with negative
    % gradient
    xi = x_start - sr*dx_start;
    yi = y_start - sr*dy_start;
    
    [~,idx_x] = min(abs(x-xi));
    [~,idx_y] = min(abs(y-yi));
    xi = x(idx_x);
    yi = y(idx_y);
    
    % function value of x,y at i
    zi = vals(xi,yi);

    % cancel criteria: convergence small enough?
    if(abs((z - zi)) < 0.01)
        break;
    end 

    %% increase or decrease steprange
    if(zi < z)
      % next step is smalle than actual value, increase steprange for next
      % iteration
      
      % plot new point on contour
      subplot(hContFig);
      hold on;
      plot3([x_start xi],[y_start yi],[z zi],'-b');
      plot3(xi, yi, zi, '+r');
      subplot(hMeshFig);
      
      % plot new point on mesh
      hold on;
      plot3([x_start xi],[y_start yi],[z zi],'-b');
      plot3(xi, yi, zi, '+r');
      
      % increase steprange
      sr = 1.25*sr;
      x_start = xi;
      y_start = yi;
      
      % increase counter
      i = i+1;
    else
      % we went too far! Go back, keep calm and continue iterating
      sr = sr / 2;
    end  
  end 
  hold off;

end