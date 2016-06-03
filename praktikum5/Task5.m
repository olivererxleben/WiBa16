%% Matrix + Eingang
% eingang
e = [ 0, 0, 0;
      1, 0, 1;
      0, 1, 1;
      1, 1, 0];
    
% "Zufallsgewichtungen"  
W1 = [  3.0085, 3.0044, 3.0050, -4.3934
       0.8199, 0.8194, 0.8196, -1.1468
      ];
W2 = [-2.8077, 4.2396, 0.6678];

%% training
F_last = Inf(); 

fprintf('Trainiere Netz...\n');
figure('Name','Fehlerrate in Abhaenigigkeit der Iterationsschritte jedes Lernvorgangs');

for j = 1:10
    F = 0;
    
    % Trainiere Netz
    [W1trained,W2trained,n,F_all] = trainiere(W1,W2,e,e(:,3),1000,0.001,0.00001,0.75);
    % Teste jetzt das trainierte Netz
    for i = 1:size(e,1)
        d = werteaus(W1trained, W2trained, e(i,:));
        F = F + (d - e(i,3)).^2;
    end % for
    fprintf('Gesamtfehler im %i ten Durchlauf: %f\n',j,F);
 
    % Zeichne Entwicklung des Fehlers
    subplot(3,4,j);
    plot((1:size(F_all,2)),F_all);
    
    if(F < F_last)
        W1best = W1;
        W2best = W2;
        Fbest = F;
        nr = j;
    end 
    F_last = F;
end

%% auswertung
for i = 1:size(e,1)
    d = werteaus(W1, W2, e(i,:));
    fprintf('Eingabedaten: %i %i - Sollausgabe: %i - Istausgabe: %f\n',e(i,1),e(i,2),e(i,3),d);
end
