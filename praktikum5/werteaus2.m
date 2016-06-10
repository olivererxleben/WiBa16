% Auswertungsfunktion f¸r ein neuronales Netz mit einer inneren Schicht
% Schwellwertfunktion ist Tangens Hyperbolicus tanh() bzw. tansig()
function [d, d0, e1, d1, e2, d2, e3] = werteaus2(W1,W2,W3,e0)
    % Hänge Eingabe des 1-Neuron an Eingabevektor
    d0 = [e0'; 1]; % Gesamtausgabe der 0-ten Schicht
    e1 = W1 * d0; % Gesamteingabe der 1. inneren Schicht
    d1 = [tansig(e1); 1]; % Gesamtausgabe der 1. innere Schicht
    e2 = W2 * d1; % Gesamteingabe in die 2. innere Schicht
    d2 = [tansig(e2); 1]; % Gesamtausgabe der 2. inneren Schicht
    e3 = W3 * d2; % Gesamteingabe in die Ausgangsschicht
    d = tansig(e3); % Gesamtausgabe des Netzes
end 