classdef Apriori
    %APRIORI Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       T20 = dlmread('wbsa0206_20.dat');
       T100 = dlmread('wbsa0206_100.dat');
    end
    
    methods
        % task 1: apriori 
        function transactions = getTransactions(T, z)
            transactions = sum((T*z')==sum(z));
        end
            
    end
    
end

