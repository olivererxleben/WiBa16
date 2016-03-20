%% data

S = dlmread('wbsa0210.dat');
n = size(S,1); % num lines
disp(n); % 103

%% vector v (4a)
v = S(:,1);
v_min = min(v);
v_max = max(v);
v_mean = mean(v);
v_std = std(v);

%% Historgramm (4b)
% Matlab Documentation suggests usage of 'histogram' not 'hist'
% more info: http://de.mathworks.com/help/matlab/ref/hist.html?searchHighlight=hist
% TODO: num elements in intervall?
histOfVectorV = histogram(S,10);


%% Plot (4c)

plotSplus = plot(S, '+');

%% Histogramm (4d)
a = zeros(103,1);
for i = 1:n
    a = [a;norm(S(i,:))]; % optimization?
end

histOfVectorA = histogram(a,7);

%% 4e
% taken from MatLab Doc: 
% http://de.mathworks.com/help/stats/zscore.html?searchHighlight=zscore#btikeav

% z-scores measure the distance of a data point from the mean in terms of 
% the standard deviation. This is also called standardization of data. 
% The standardized data set has mean 0 and standard deviation 1, and 
% retains the shape properties of the original data set (same skewness 
% and kurtosis).
% 
% You can use z-scores to put data on the same scale before further 
% analysis. This lets you to compare two or more data sets with different 
% units.

% => Datennormalisierung (bei Datenvorverarbeitung)

Z = zscore(S);
% TODO: Error Undefined function or variable 'zscore'. 
