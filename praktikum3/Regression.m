classdef Regression
    %REGRESSION Summary of this class goes here
    %   authors Oliver Erxleben, Jens Overmöller
    
    properties
        data1 = dlmread('Daten\wbsa0239s.dat');
        data2 = dlmread('Daten\wbsa0230c.dat');
    end
    
    methods
        function this = Regression(file1,file2)
            % Constructor function - creates a Regression object
            % params:   file1: Path to Inputfile1
            %           file2: Path to Inputfile2
            %
            % return: a Regression object
                        
            if(nargin >= 1)
                data1 = dlmread(file1);
                disp(sprintf('Daten aus Datei "%s" geladen', file1))
            end
            
            if(nargin >= 2)
                data2 = dlmread(file2);
                disp(sprintf('Daten aus Datei "%s" geladen', file2))
            end  
        end
    end
    
     methods (Access = public)
         
         function [t R a] = DoReg(this)
             
            t = this.Renumber();    
            [R a] = this.LinearReg(t);
                        
         end
             
        %Aufbau der Daten:  [1 1 10 0 -2.24818181818182]
        %Ergebnis:  [(Nummer 0 bis n-1) 1 1 10 0 -2.24818181818182]
        function t = Renumber(this) 
           
            %Nummerierung von 0 bis n-1; => n-Datensätze
            dim = 0:1.0:size(this.data1,1)-1;
            %disp(dim);
            %horzcat -> Kombiniert die Nummerierung und Matrix
            %v = horzcat(dim', this.data1);
            t = horzcat(dim');
            %disp(this.v);
            
        end
        
        function [R a xt] = LinearReg(this, t)
            % Skript S.60
            % konstantes Glied anfügen
            R = [t ones(size(t,1),1)];
            %1.0000 ;; -0.0000
            a = (R' * R)^-1 * R' * t; 
            xt = a(1) * t + a(2);
            %plot(xt);
        end
        
    end
    
end

