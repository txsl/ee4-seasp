
addpath('../')
common.init

%% Setup

N = 1024;
N_IT = 100;

PAD = 1;

fft_len = PAD*N;
psds = zeros(fft_len, N_IT);

% x_ax_scale = [0.1 0.3];
x_ax_scale = [0 0.5];

%% Generate signals and take the FFT

for i = 1:N_IT
    
    noisy_wave = sqrt(0.2)*randn(N, 1) + 0.1*sin(0.2*pi*(1:N))' + 0.1*sin(0.23*pi*(1:N))';

    auto_cor = xcorr(noisy_wave, 'biased');
    
    psds(:, i) = fftshift(abs(fft(bartlett(length(auto_cor)).*auto_cor, fft_len)).^2);
    
end

%% Plot all signals, and the mean

w = limspace(1, fft_len);

figure;
subplot(1, 2, 1);
hold on;

 
for i = 1:N_IT
    ens = plot(w, psds(:,i), ':r');
end

h1 = plot(w, mean(psds, 2));
set(h1, 'LineWidth', 2)
legend([h1 ens], 'Mean', 'Ensemble Iterations')

xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Power')
title('PSD Estimate - Ensemble and Mean')
common.set_graph_params


%% Standard Deviation

% figure

subplot(1, 2, 2);

plot(w, std(psds, 0, 2))
xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Standard Deviation')
title('Standard Deviation of Ensemble')
common.set_graph_params






