function [W1,W2,m,F_all] = trainiere(W1,W2,E,A,n,F_soll,minCrit,startsigma)

F_ist_last = Inf();
F_all = [];
sigma = startsigma;
grad1gesamt = 0;
grad2gesamt = 0;

% num Anzahl Trainingsdurchläufe 
for m = 1:n
    F_ist = 0;
    
    W1tmp = W1 - sigma*grad1gesamt;
    W2tmp = W2 - sigma*grad2gesamt;
    
    grad1gesamt = 0;
    grad2gesamt = 0;
    
    % ...mit i Lerndatensaetzen durch 
    for i = 1:size(E,1)
        
        e = E(i,:);
        a = A(i,:);
        % Werte untrainiertes Netz aus um Anfangsdaten fuer
        % Gradientenverfahren zu bekommen
        
        [d, d0, e1, d1, e2] = werteaus(W1tmp,W2tmp,e);
        
        % Ergebnisse der Fehlerfunktion (sse) fuer Lerndatensaetze summieren
        F_ist = F_ist + sum( (d - a').^2);
        
        % Wende jetzt Backpropagation-Verfahren an
        % Berechne zweiten Fehlergradienten (vgl. 6.106, 6.111)
        delta2 = 2 * diag(1-tanh(e2).^2) * (d - a');
        grad2 = delta2 * d1';
        grad2gesamt = grad2gesamt + grad2;
        % Berechne ersten Fehlergradienten (vgl. 6.108, 6.110)
        delta1 = diag(1-tanh(e1).^2) * W2(:,1:end-1)' * delta2;
        grad1 = delta1 * d0';
        grad1gesamt = grad1gesamt + grad1;
    end % inner for
    
    if(F_ist <= F_soll)
    % Zielwert erreicht
        fprintf('--> Lernziel nach %i Iterationen erreicht. Groesse des Fehlers: %f\n',m,F_ist);
        F_all = [F_all, F_ist];
        break;
        
    elseif(abs(F_ist-F_ist_last) <= minCrit )
    % Der Fehler veraendert sich nur noch minimal. Wir habens uns also gut
    % genug an ein (lokales) Minimum der Fehlerfunktion herangearbeitet
        fprintf('--> (Lokales) Minimum nach %i Iterationen erreicht. Groesse des Fehlers: %f\n',m,F_ist);
        W1 = W1tmp;
        W2 = W2tmp;
        F_all = [F_all, F_ist];
        break;
    elseif(F_ist > F_ist_last)
    % Wir haben das Minimum der Fehlerfunktion bereits durchschritten
    % --> Verringere Sigma und nehme den Schritt zurueck
        if(sigma > 0.001)
            sigma = sigma * 0.5;
        end
        %fprintf('Verringere Sigma auf %f\n',sigma);
    else
    % Wir naehern uns weiter einem Minimum an
    % --> Erhoehe Sigma und benutze neue Gewichtsmatrizen
        sigma = sigma * 1.1;
        W1 = W1tmp;
        W2 = W2tmp;
        F_ist_last = F_ist;
        F_all = [F_all, F_ist];
        %fprintf('Erhoehe Sigma auf %f\n',sigma);
    end % elseif
    
    if(mod(m,250) == 0)
        fprintf('Anzahl Iterationen: %i. Groesse des Fehlers: %f\n',m,F_ist);
    end % if
end % outer for
end % function