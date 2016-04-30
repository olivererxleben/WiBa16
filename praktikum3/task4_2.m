% Aufgabenblatt 3
% Aufgabe 2
%
% Authors:
%   Oliver Erxleben: oliver.erxleben@hs-osnabrueck.de
%   Jens Overmöller: jens.overmoeller@hs-osnabrueck.de

% 0. read data and plot
S = dlmread('wbsa0230c.dat');

plot3(S(:,1), S(:,2), S(:,3)); % X, Y, Z
disp(S);

% save dependecy vector (values vector)
% Note: Script var is t
t = S(:,3);

x = S(:,1);
y = S(:,2);

v_ones = ones(length(S),1); % ones matrix

% build data matrix without variances (Skript S 62f., 5.37)
% bulding values for: 
% p(x,y) = a1*x^2 + a2*x*y + a3*y^2 + a4*x + a5*y + a6;
R = [ x.^2, x .* y, y.^2, x, y, v_ones ];

% build regressions and print p func
a = (R' * R)^(-1) * (R' * t);
fprintf('p(t) = %4.2f*x^2 + %4.2f*x*y + %4.2f*y^2 + %4.2f*x + %4.2f*y + %4.2f\n', a(1,1),a(2,1),a(3,1),a(4,1),a(5,1),a(6,1));

% prepare plotting
[X,Y] = meshgrid(-17:0.1:19,-17:0.1:19); 
Z = a1*X.^2 + a2*(X.*Y) + a3*Y.^2 + a4*X + a5*Y + a6; 

% do plotting
% mesh: equation paraboloid (the actual Fläche :D)
% markers: values of the actual paraboloid plotted in figure 1
fig = figure(2);
set(fig, 'Position', [0,0, 1024, 768]);
mesh(X,Y,Z); % p = Z-axis
hold on;
grid on;
plot3(S(:,1), S(:,2), S(:,3),'LineStyle','none','Marker','x','Color','red');
hold off;