
addpath('../')
common.init

N = 1000;
V = 330;

fo = 50;
fs = 5000;

delta_b = pi/8;
delta_c = -pi/2.5;

n = 1:N;
mults = n*2*pi*fo/fs;
 
% v_bal = zeros(N, 3);
% 
% v_bal(:,1) = V*cos(mults);
% v_bal(:,2) = V*cos(mults - 2*pi/3);
% v_bal(:,3) = V*cos(mults + 2*pi/3);
% 
% plot(v_bal)

%% Balanced scenario

v_bal = sqrt(3/2) * V * exp(1j*(mults));

plot(real(v_bal), imag(v_bal), '+');

%% Unbalanced scenario

A_n = (sqrt(6)/6)*(V + V*exp(1j*delta_b) + V*exp(1j*delta_c));
B_n = (sqrt(6)/6)*(V + V*exp(-1j*(delta_b+(2*pi/3))) + V*exp(-1j*(delta_c - (2*pi/3))));

v_unbal = A_n * exp(1j*mults) + B_n * exp(-1j*mults);

max_r = max(real(v_unbal));
max_i = max(imag(v_unbal));

if max_r > max_i
    max_ax = max_r;
else
    max_ax = max_i;
end

min_r = min(real(v_unbal));
min_i = min(imag(v_unbal));

if min_r < min_i
    min_ax = min_r;
else
    min_ax = min_i;
end

figure;
plot(real(v_unbal), imag(v_unbal), '+');
axis([ min_ax max_ax min_ax max_ax ])
