function [ a ] = AprioriGen( T,z )
%APRIORIGEN Summary of this function goes here
%   Detailed explanation goes here

 %T20 = dlmread('wbsa0206_20.dat');
 %T100 = dlmread('wbsa0206_100.dat');
 
    % I = Itemvorrat { I1, I2, ... }
    % t = Transaktion { I_i_1, I_i_2, ...}
    % T = Datenbasis {t1, t2, ...}
    % support(X) 
    
    % Anzahl Item-Mengen 
    function a = Anzahl(T,z)
        a = sum((T*z') == sum(z));
    end

    % 
    function a = AnfangGleich(z1,z2)
        k = sum(z1);
        if k == 0
            a = 1;
            return;
        end
        
        s = min(find(z1,1,'last'), find(z2,1,'last') ) - 1;
        if sum(and(z1(1:s), z2(1:s))) == k - 1
            a = 1;
        else
            a = 0;
        end
    end
 
    function x = support()
        size = Anzahl(T,z);
        disp(size);
        numT = 0;
       for i = 1:sum(size(:, end))
           numT = numT + sum(:,i);
       end
       for i = 1:sum(size(:,end))
           size(:,i) / numT
       end
    end

a = support();
end

