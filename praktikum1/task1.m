%% data

A = [1 -1 1 1; 2 1 -3 2; -1 3 2 -1; -1 0 3 3];
v = [-6; 13; 7; -2];

%% 1a

% Determinante
detA = det(A);

% Spur
trA = trace(A);

% Länge Vektor
norm_v = norm(v);

%  A * v
w = A * v;

% Transponieren und Multiplizieren
A_transpA = A * A';

% Scalarprodukt
scalar_v_w = v .* w;

% Exponent
A3 = A^3;

% Umkehrfunktione
umkA = A^(-1);

% Lineares Gleichungssystem A * x = v
% A * x = v / : A
% x = v / A
x = v \ A;

%% 1b
A
