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
% Aufgabenstellung: Zweidimensionale polynomiale Regression zweiter Ordnung
% Finde Ausgleichs-Paraboloiden 
% der Form: p(x,y) = a1*x^2 + a2*x*y + a3*y^2 + a4*x + a5*y + a6;

% Spalte abhängige Variable ab (werte)
t = S(:,3);

x = S(:,1);
y = S(:,2);

% build data matrix without variances (Skript S 62f., 5.37)
%R = [ x1.^2 x1.*x2 x2.^2 x1 x2 ones(size(S,1),1) ];  


%Nummerierung von 0 bis n-1; => n-Datensätze
dim = 0:1.0:size(S,1)-1;
nums = horzcat(dim');

oners = ones(length(S),1);
x_sq = x.^2;
xy = x .* y;
y_sq = y.^2;

R = [ x.^2, xy, y.^2, x, y, oners];

%R1 = [ S(:,1:2), oners];
%disp(R1);
%R2 = [ S(:,2), S(:,1), oners];
%disp(R2);

a = (R' * R)^(-1) * (R' * t);
disp(a);

%a2 = (R2' * R2)^(-1) * (R2' * t);
%disp(a2);

%tm = mean(t);
%r2 = norm(tm-R*a)^2 / norm(tm-t)^2;
%disp(tm);
fprintf('p = %d %d*t %d*t^2 %d*t^3 %d*t^4 $d*t^5', a(1), a(2), a(3), a(4), a(5), a(6));

p = a(1) + (a(2)*t) + (a(3)*t.^2) + (a(4)*t.^3) + (a(5)*t.^4) + (a(6)*t.^5);
figure(2)
plot(p);
plot3(S(:,1), S(:,2), p);

