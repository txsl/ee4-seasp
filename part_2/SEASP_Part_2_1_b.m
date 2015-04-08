
addpath('../')
common.init

%% Setup

N = 512;
N_IT = 100;

PAD = 1;

% psds = zeros((2*(N-1))+1, N_IT);
fft_len = PAD*N;
psds = zeros(fft_len, N_IT);

% x_ax_scale = [0.1 0.3];
x_ax_scale = [0 1];

%% Generate signals and take the FFT

for i = 1:N_IT
    
    noisy_wave = sqrt(0.2)*randn(N, 1) + 0.1*sin(0.2*pi*(1:N))' + 0.1*sin(0.23*pi*(1:N))';

    auto_cor = xcorr(noisy_wave, 'biased');
    
    psds(:, i) = fftshift(abs(fft(bartlett(length(auto_cor)).*auto_cor, fft_len)).^2);
    
end

%% Plot all signals, and the mean

w = limspace(1, fft_len);

figure;
hold on;

 
for i = 1:N_IT
    plot(w, psds(:,i), ':g')
end

h1 = plot(w, mean(psds, 2));
set(h1, 'LineWidth', 2)
legend(h1, 'Mean')

xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Power')
title('PSD Estimate - Mean of Ensemble and all signals')
common.set_graph_params


%% Standard Deviation

figure
plot(w, std(psds, 0, 2))
xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Standard Deviation')
title('Standard Deviation of Ensemble')
common.set_graph_params






