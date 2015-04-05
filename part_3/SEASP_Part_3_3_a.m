
addpath('../')
common.init

N = 1000;

noise = filter(1, [1 0 0.5], randn(N, 1));

n_corr = xcorr(noise, 'unbiased');

stem(-50:50, n_corr(950:1050));
common.set_graph_params

figure
stem(-20:20, n_corr(980:1020));
common.set_graph_params


