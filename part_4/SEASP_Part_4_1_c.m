
addpath('../')
common.init

N = 1000;
V = 1;

fo = 50;
fs = 5000;

delta_b = pi/8;
delta_c = -pi/7;

n = 1:N;
mults = n*2*pi*fo/fs;


%% Balanced scenario

v_bal = sqrt(3/2) * V * exp(1j*(mults));

figure;
hold on
plot(real(v_bal), imag(v_bal), 'ob');

%% Unbalanced scenario

A_n = (sqrt(6)/6)*(V + V*exp(1j*delta_b) + V*exp(1j*delta_c));
B_n = (sqrt(6)/6)*(V + V*exp(-1j*(delta_b+(2*pi/3))) + V*exp(-1j*(delta_c - (2*pi/3))));

v_unbal = A_n * exp(1j*mults) + B_n * exp(-1j*mults);

max_r = max(real(v_unbal));
max_i = max(imag(v_unbal));

max_ax = max([max_r; max_i]);

min_r = min(real(v_unbal));
min_i = min(imag(v_unbal));

min_ax = min([min_r; min_i]);


plot(real(v_unbal), imag(v_unbal), '+r');
axis([ min_ax max_ax min_ax max_ax ])
xlabel('$ \Re \{ v(n) \} $');
ylabel('$ \Im \{ v(n) \} $');
legend('Balanced System', 'Unbalanced System')

