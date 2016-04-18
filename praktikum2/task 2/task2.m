% Task 2.2

% read raw data
S = dlmread('wbsa0350.dat');

%% Hierachical Clustering

A = pdist(S); % calc distances

%disp(squareform(A)); % check matrix of A, optional
% Baue Clusterbaum aus Abstandsvektor auf
B = linkage(A); % build clustertree

dendrogram(B); % plot cluster tree

% --> Seems to be 4 by interpreting dendogram1

nocl = 4; % number of clusters, var can be used for the rest of script

HC = cluster(B,'maxclust',nocl);
%disp(HC);

HC1 = S(HC==1,:);
HC2 = S(HC==2,:);
HC3 = S(HC==3,:);
HC4 = S(HC==4,:);

% optional plotting, does not work
hold on
plot(HC1(:,1),HC1(:,2), 'ok')
plot(HC2(:,1),HC2(:,2), 'xk')
plot(HC3(:,1),HC3(:,2), '+k')
plot(HC4(:,1),HC4(:,2), 'vk')


[noelHC1,~] = size(HC1);
[noelHC2,~] = size(HC2);
[noelHC3,~] = size(HC3);
[noelHC4,~] = size(HC4);

fprintf('hierachical Clustering: Num Elements in clusters: %i, %i, %i,%i\n',noelHC1,noelHC2,noelHC3,noelHC4);


%% K-mean-Clustering

KM = kmeans(S, nocl); % use clusternum
KM1 = S(KM==1,:);
KM2 = S(KM==2,:);
KM3 = S(KM==3,:);
KM4 = S(KM==4,:);

[noelKM1,~] = size(KM1);
[noelKM2,~] = size(KM2);
[noelKM3,~] = size(KM3);
[noelKM4,~] = size(KM4);

fprintf('K-mean-clustering: num Elementes in clusters: %i, %i, %i,%i\n',noelKM1,noelKM2,noelKM3,noelKM4);


%% fuzzy k-mean clustering

centrS = zscore(S); % centralize data

[Z,U,J] = fcm(centrS,nocl); % do clustering: U := Zuordnungsmatrix
UBiggerThanThird = U(:,(sum(U>0.33) >= 2));

% values from data
SBiggerThanThird = S((sum(U>0.33) >= 2),:);

% data < 1/3 of a cluster
USmallerThanThird = U(:,unique(U<0.33));
%values from Data
SSmallerThanThird = S(unique(U<0.33),:);