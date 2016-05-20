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
startVal = rand(1);

%stepRange = min(1, 1/gradientXY);

%% 