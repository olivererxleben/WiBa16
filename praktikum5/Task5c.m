%% Aufgabe 1c
% #Spalten = #Neuronen in Vorgaengerschicht (inkl. 1-Neuron)
% #Zeilen = #Neuronen in Nachfolgerschicht
% Neuronales Netz mit einer inneren Schicht, d.h. zwei Uebergangsmatrizen

%% data
% c - zwei binaere Eingaenge e1,e2 und vier Ausgaenge mit e1ORe2, e1ANDe2, NICHTe1 und NICHTe2
c = [ 0, 0, 0, 0, 1, 1;
      1, 0, 1, 0, 0, 1;
      0, 1, 1, 0, 1, 0;
      1, 1, 1, 1, 0, 0 
    ];
  
% Zufaellige Initialisierung der Gewichtsmatrizen
W1 = rand(2,3); % Zwei Neuronen (+1-Neuron) in der Eingangsschicht, zwei innere Neuronen
W2 = rand(4,3); % Zwei Neuronen (+1-Neuron) in innerer Schicht, 4 in Ausgangsschicht

%% train
[W1trained,W2trained,n,sse] = trainiere(W1,W2,c(:,1:2),c(:,3:6),1000,0.001,0.0001,0.75);

%% eval
for i = 1:size(c,1)
    d = werteaus(W1trained,W2trained,c(i,1:2));
    fprintf('Sollausgabe: ');
    disp(c(i,3:6));
    fprintf('Istausgabe: ');
    disp(d');
    fprintf('\n');
end 