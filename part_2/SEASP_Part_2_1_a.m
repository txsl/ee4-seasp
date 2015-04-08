
addpath('../')
common.init

N = 1000;

%% Generate Signals

wgn = randn(N, 1);
filt_wgn = filter([1 0 0.9], 1, randn(N, 1));
noisy_wave = randn(N, 1) + sin(0.2*pi*(1:N))';

cor_range = -(N-1):(N-1);

%% WGN


[ unbiased, biased ] = compute_acf(wgn);

w = limspace(1, length(unbiased));
figure;
subplot(2, 3, 1)
plot(cor_range, unbiased, cor_range, biased)
legend('Unbiased', 'Biased')
xlabel('Delay ($\tau$)')
ylabel('Autocorrelation')
title('Autocorrelation of WGN')
xlim([0 N-1])
common.set_graph_params

subplot(2, 3, 4)
plot(w, fftshift(real(fft(unbiased))), w, fftshift(real(fft(biased))))
legend('Unbiased', 'Biased')
xlim([0 1])
xlabel('Normalised Frequency')
ylabel('Power')
title('Correlogram of WGN')
common.set_graph_params


%% Filtered WGN

[ unbiased, biased ] = compute_acf(filt_wgn);

subplot(2, 3, 2)
plot(cor_range, unbiased, cor_range, biased)
legend('Unbiased', 'Biased')
xlabel('Delay ($\tau$)')
ylabel('Autocorrelation')
title('Autocorrelation of Filtered WGN')
xlim([0 N-1])
common.set_graph_params

subplot(2, 3, 5)
plot(w, fftshift(real(fft(unbiased))), w, fftshift(real(fft(biased))))
legend('Unbiased', 'Biased')
xlim([0 1])
xlabel('Normalised Frequency')
ylabel('Power')
title('Correlogram of Filtered WGN')
common.set_graph_params

%% Noisey Sinusoid

[ unbiased, biased ] = compute_acf(noisy_wave);

subplot(2, 3, 3)
plot(cor_range, unbiased, cor_range, biased)
legend('Unbiased', 'Biased')
xlabel('Delay ($\tau$)')
ylabel('Autocorrelation')
title('Autocorrelation of Noisy Sinusoid')
xlim([0 N-1])
common.set_graph_params

subplot(2, 3, 6)
plot(w, fftshift(real(fft(unbiased))), w, fftshift(real(fft(biased))))
legend('Unbiased', 'Biased')
xlim([0 1])
xlabel('Normalised Frequency')
ylabel('Power')
title('Correlogram of Noisy Sinusoid')
common.set_graph_params

