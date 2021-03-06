
addpath('../')
common.init

% Get data from 4.2.a
SEASP_Part_4_2_a

N = 1500;

x = exp(1j*(2*(0:N-1)*pi)/N)/N;

[ h_est, y_est, error ] = clms(x, y, 1024, 1);

surf(1:N, 1:1024, abs(h_est), 'LineStyle', 'none')
view(2)
xlabel('Iteration ($n$)')
ylabel('Frequency')
ylim([0 1024])


