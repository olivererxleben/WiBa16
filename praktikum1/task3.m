%% data

xValues = -2:0.5:6;
yValues = -4:0.5:4;

[x,y] = meshgrid(xValues, yValues);

%% function
z = (-0.8*x^3 + 5*x^2 + 5*x + 5) * exp(-0.5*y^2);
t = 2.547428770 - 4.488326882*x - 3.517877826*y;

%% plot
figure
mesh(x,y,z)
hold on
mesh(x,y,z)

% Was fällt auf? 
% Kalkulierte Werte sind identisch
