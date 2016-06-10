function [W1,W2,W3,m,F_all] = trainiere2(W1,W2,W3,E,A,n,F_soll,minCrit,startsigma)
% Trainiert ein neuronales Netz 
%     mit den Gewichtsmatrizen W1,W2, den
%     Menge der Lerndatensaetze e_menge und Sollausgabewerten a_menge solange, 
%     bis entweder die Abweichung zwischen Soll- und Istausgabe F_ist <= F_soll 
%     ist oder n Trainingsdurchlauefe durchgefuehrt wurden
%     Falls sich die Fehlerwerte um nicht mehr als minCrit unterscheiden, haben
%     wir das (lokale) Minimum der Fehlerfunktion gefunden und koennen
%     abbrechen.

F_ist_last = Inf();
F_all = [];
sigma = startsigma;
grad1gesamt = 0;
grad2gesamt = 0;
grad3gesamt = 0;

%% training
% Fuehre m Trainingsdurchlaeufe...    
for m = 1:n
    F_ist = 0;

    % Passe (vorlaeufig) Gewichtsmatrizen an
    W1temp = W1 - sigma*grad1gesamt;
    W2temp = W2 - sigma*grad2gesamt;
    W3temp = W3 - sigma*grad3gesamt;
    
    grad1gesamt = 0;
    grad2gesamt = 0;
    grad3gesamt = 0;
    
    % ...mit i Lerndatensaetzen durch 
    for i = 1:size(E,1)
        e = E(i,:);
        a = A(i,:);
        % Werte untrainiertes Netz aus um Anfangsdaten fuer
        % Gradientenverfahren zu bekommen
        [d, d0, e1, d1, e2, d2, e3] = werteaus2(W1temp,W2temp,W3temp,e);
        
        % Ergebnisse der Fehlerfunktion (sse) fuer Lerndatensaetze summieren
        F_ist = F_ist + sum( (d - a').^2);
        
        % Wende jetzt Backpropagation-Verfahren an
        % Berechne dritten Fehlergradienten (vgl. 6.106, 6.111)
        delta3 = 2 * diag(1-tansig(e3).^2) * (d - a');
        grad3 = delta3 * d2';
        grad3gesamt = grad3gesamt + grad3;
        % Berechne zweiten Fehlergradienten
        delta2 =  diag(1-tansig(e2).^2) * W3(:,1:end-1)' * delta3;
        grad2 = delta2 * d1';
        grad2gesamt = grad2gesamt + grad2;
        % Berechne ersten Fehlergradienten (vgl. 6.108, 6.110)
        delta1 = diag(1-tansig(e1).^2) * W2(:,1:end-1)' * delta2;
        grad1 = delta1 * d0';
        grad1gesamt = grad1gesamt + grad1;
    end 
   
    
    % Alle Ist-Ausgabewerte in d_gesamt vorhanden.Fehlerfunktion auswerten.
    if(F_ist <= F_soll)
    % Zielwert erreicht
        fprintf('--> Lernziel nach %i Iterationen erreicht. Groesse des Fehlers: %f\n',m,F_ist);
        F_all = [F_all, F_ist];
        break;
    elseif(abs(F_ist-F_ist_last) <= minCrit )
    % Der Fehler veraendert sich nur noch minimal. Wir habens uns also gut
    % genug an ein (lokales) Minimum der Fehlerfunktion herangearbeitet
        fprintf('--> (Lokales) Minimum nach %i Iterationen erreicht. Groesse des Fehlers: %f\n',m,F_ist);
        W1 = W1temp;
        W2 = W2temp;
        W3 = W3temp;
        F_all = [F_all, F_ist];
        break;
    elseif(F_ist > F_ist_last)
    % Wir haben das Minimum der Fehlerfunktion bereits durchschritten
    % --> Verringere Sigma und nehme den Schritt zurueck
        if(sigma > 0.001)
            sigma = sigma * 0.5;
        end

    else
    % Wir naehern uns weiter einem Minimum an
    % --> Erhoehe Sigma und benutze neue Gewichtsmatrizen
        sigma = sigma * 1.1;
        W1 = W1temp;
        W2 = W2temp;
        W3 = W3temp;
        F_ist_last = F_ist;
        F_all = [F_all, F_ist];
        %fprintf('Erhoehe Sigma auf %f\n',sigma);
    end % elseif
    
    % all 50 iterations: join 
    if(mod(m,50) == 0)
        fprintf('Anzahl Iterationen: %i. Groesse des Fehlers: %f\n',m,F_ist);
    end % if
end % outer for
end % function