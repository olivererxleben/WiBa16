function [d, d0, e1, d1, e2] = werteaus(W1,W2,e0)
    d0 = [e0'; 1]; % Gesamtausgabe der 0-ten Schicht
    e1 = W1 * d0; % Gesamteingabe der inneren Schicht
    d1 = [tansig(e1); 1]; % Gesamtausgabe der inneren Schicht (mit Aktivierungsfunktion)
    e2 = W2 * d1; % Gesamteingabe in die Ausgangsschicht
    d = tansig(e2); % Gesamtausgabe des Netzes
end
