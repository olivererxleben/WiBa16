% Wissensbasierte Methoden - SoSe 2013
% Praktikumsblatt 6 - Neuronale Netze
% Aufgabe 2

%% Lerndatensaetze erzeugen
% Code aus Praktikumsblatt
n = 100;
Mx = 10;
% Erstelle eine 2xn-Matrix mit Werten zufaelligen Werten zw. -5 und 5
E = Mx*rand([2,n])-Mx/2*ones(2,n); % Mittelwert Null
% Ist Wert groe?er als Null? -> 1 oder 0
k1 = E(1,:) >= 0;
k2 = E(2,:) >= 0;

A = [and(k1,k2);            % 1. Quadrant
     and(not(k1),k2);       % 2. Quadrant
     and(not(k1),not(k2));  % 3. Quadrant
     and(k1,not(k2))        % 4. Quadrant
    ];

plot(E(1,A(1,:)),E(2,A(1,:)),'ok'); hold on;
plot(E(1,A(2,:)),E(2,A(2,:)),'*k');
plot(E(1,A(3,:)),E(2,A(3,:)),'sk');
plot(E(1,A(4,:)),E(2,A(4,:)),'pk');
% </Praktikumsblatt-Code>

%% Trainingsphase
%Lernziel: Das neuronale Netz soll erkennen, in welchem Quadranten sich
% ein Punkt P(x,y) mit -5<=x,y<=5 befindet.
% Netz: 2N - 3N - 3N - 4N
W1 = rand(3,3);
W2 = rand(3,4);
W3 = rand(4,4);

[W1trained,W2trained,W3trained,n,sse] = trainiere2(W1,W2,W3,E',A',1000,0.001,0.0001,0.075);

%% auswertung
while(1)
   [x,y] = ginput(1);
   d = werteaus2(W1trained,W2trained,W3trained,[x y]);
   disp(d);
   
   e = sum(d);
   disp(e);
end