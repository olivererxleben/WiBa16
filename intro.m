%% Setup
import helpers.*
%addpath('helpers');
h = helpers;
h.OUTFILE = 'intro.txt';
h.log('hello ');
%%  Data

A = [1, -1, 1, 1 ; 2, 1, -3, 2 ; -1, 3, 2, -1; -1, 0, 3, 3];
v = [-6 13 7 -2];

%%  task a
A;
d = det(A);
tr = trace(A);
answer = ['Determinante von A = ',num2str(d), ', trace = ', num2str(tr)];
disp(answer);

v_norm = norm(v);
answer = ['Länger des Vektors v = ' num2str(v_norm)];
disp(answer);

