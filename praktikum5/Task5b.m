%% Aufgabe5_1_b
% #Spalten = #Neuronen in Vorgaengerschicht (inkl. 1-Neuron)
% #Zeilen = #Neuronen in Nachfolgerschicht
% Uebergangsgewichte von der Eingabeschicht (0-te) in die innere Schicht (1-ste)

%% data
b = [0 1 0 0 1 1 0 1 
     0 0 1 0 1 0 1 1 
     0 0 0 1 0 1 1 1];
W1 = rand(2,4);
W2 = rand(1,3);

%% train
[W1trained,W2trained,n,sse] = trainiere(W1,W2,b(:,1:3),b(:,4),1000,0.005,0.0001,0.075);

%% evaluate
for i = 1:size(b,1)
    d = werteaus(W1trained,W2trained,b(i,1:3));
    fprintf('Sollausgabe: %i - Istausgabe: %f\n',b(i,4),d);
end 