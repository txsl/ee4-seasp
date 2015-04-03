
addpath('../')
common.init

N = 1000;

M = 1;

v = randn(N, 1);
noise = zeros(N, 1);

for i = 3:N
    noise(i) = v(i) + 0.5*v(i-2);
end

n_corr = xcorr(noise, 'unbiased');

stem(-50:50, n_corr(950:1050));
common.set_graph_params
pause

sig = noise + sin(0.01*pi*(1:N))';

