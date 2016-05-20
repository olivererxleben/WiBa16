%% preperation and data
%Intervall

x = -2:.1:3; 
y = -2:.1:3;
[X,Y] = meshgrid(x,y);

% Funktionswert f¸r Zeichnung
Z = ((X+1).^2 + (Y+1).^2) .* ((X-2).^2 + (Y-1).^2) + X + Y;

% derivations
%deriv_X = (2.*X+2).*((X-2).^2 + (Y-1).^2) + ((X+1).^2 + (Y+1).^2).*(2.*X-4) + 1;
dx = (2.*x+2).*((x-2).^2 + (y-1).^2) + ((x+1).^2 + (y+1).^2).*(2.*x-4) + 1; 
%deriv_Y = (2.*Y+2).*((X-2).^2 + (X-1).^2) + ((X+1).^2 + (Y+1).^2).*(2.*Y-2) + 1;
dy = (2.*y+2).*((x-2).^2 + (x-1).^2) + ((x+1).^2 + (y+1).^2).*(2.*y-2) + 1; 

gradientXY = [dx ; dy];

h = figure(1);
set(h,'Position',[200 200 1500 768]);
hMeshFig = subplot(1,2,2); 
mesh(X,Y,Z);
hContFig = subplot(1,2,1); 
contour(X,Y,Z,30);



%% a) random start value and stepRange min(1, 1/delta(f(x0))

startVal = 0; % TODO randomize 
disp(startVal);
vecX = [startVal startVal];

[z, gdx0, gdy0] = vals(startVal, startVal);
disp([gdx0 gdy0]);

vecGd = [gdx0 gdy0];
stepRange = [min(1, 1/gdx0) min(1, 1/gdy0)];
%%  loop
i = 1;

while i < 100

  % b) 
 
  xi_1 = [ vecX(i, 1) - (stepRange(1,1) * vecGd(i,1)) vecX(i, 2) - (stepRange(1,2) * vecGd(i,2))]; % xi + 1
  
  vecX = [vecX; xi_1];
 
  % c)
  fxi = vals(vecX(i,1), vecX(i,2));
  fxi_1 = vals(vecX(i+1,1), vecX(i+1,2));
  
  % e)
  one = (pdist(fxi(1)) - pdist(fxi_1(1)));
  disp(one);
  disp('----');
  if ( (pdist(fxi(1)) - pdist(fxi_1(1))) > -0.01) && ((pdist(fxi(1)) - pdist(fxi_1(1))) < 0.01)
    disp(vecX);
    disp(fxi_1);
    disp(i);
  end
    
  
  
  if fxi_1(1) < fxi(1)
    stepRange = stepRange * 1.01;
      
    % iterate 
    i = i + 1;
    
    
  else
    % d)
    vecX(end) = [];
    stepRange = stepRange / 2;
  end
    
end
