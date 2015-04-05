
% addpath('../')
% common.init

SEASP_Part_4_2_a

N = 1500;

x = exp(1j*(2*(0:N-1)*(N-1)*pi)/N)/N;

[ h_est, y_est, error ] = clms(x, y, N, 1);

surf(1:N, 1:N, h_est, 'LineStyle', 'none')
view(2)

