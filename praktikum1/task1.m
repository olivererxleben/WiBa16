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
% erste und letzte Spalte aus A addieren
disp(A(:,1));
disp(A(:, end));
A_1_end_add = A(:,1) + A(:,end);

% zweite und letzte Zeile entfernen und Produkt 
A_orig = A;
A(2,:) = [];
A_t = A;

A(:,end) = [];
A_t = A;

At_A = A * A_t;

% Spalten ersetzen
A = A_orig;
A(3,:) = [1 2 3 4];
A(:,2) = [5; 7; 9; 11];
disp(A_orig);
disp(A);

% Spalten und Zeilen erweitern
A = A_orig;
disp(A);

% Spalte mit 1en 
A = [A,ones(4,1)];
% Spalte mit 2en
% TODO: length() Funktion benutzen
twos = [2;2;2;2];
A = [A,twos];
disp(A);

%% 1c
A = A_orig;
disp(A);
ij = find(A<0);
disp(ij);
negValsA = A(A<0);
disp(negValsA);

%% 1d
% sin in -4 bis 4
x = [-4:0.1:4]; % startval : increment : endval // increment approx 0 gives best figure 
y = sin(x);
plot(x,y)

% 3 func in one plot
y_sin = sin(x);
y_cos = cos(x);
y_add = sin(x) + cos(x);
figure
plot(x,y_sin, '-g');
hold on
plot(x, y_cos, '-r');
hold on
plot(x, y_add, '-b');
print('task1d', '-djpeg'); % save as jpg on disk
hold off
