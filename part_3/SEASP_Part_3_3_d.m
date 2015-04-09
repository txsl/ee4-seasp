
addpath('../')
common.init

load('../data/EEG_Data_Assignment2.mat')

N = length(Cz);
N_IT = 1;

sine_wave = sin(100*pi*(1:N)/fs)';
noise_sig = zeros(N, N_IT);

for i = 1:N_IT
    noise_sig(:, i) = randn(N, 1) + 2*sine_wave;
end

eeg_spcgm = @(sig) spectrogram(sig, hanning(4096), 3000, 4096, fs, 'yaxis');


%% Step Sizes - Generate Data!

figure;
subplot(1, 4, 1);
eeg_spcgm(Cz)
ylim([0 120])
title('Original Signal')

mus = [ 0.001 0.01 0.05 ];

mus_errors = cell(length(mus), 1);

for j = 1:length(mus)
    
    errors = zeros(N, N_IT);
    
    m = mus(j);
    
    for i = 1:N_IT
        [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, 10, m, 0);
    end
    
    subplot(1, 4, j+1)
    eeg_spcgm(mean(errors, 2));
	ylim([0 120])
    title(sprintf('$ \\mu = %.3f$', mus(j)))

end


%% Filter Orders - Generate Data!

orders = [ 2 5 10 15 20 ];

figure;
subplot(2, 3, 1);
eeg_spcgm(Cz);
ylim([0 120])

orders_errors = cell(length(orders), 1);
for j = 1:length(orders)
    
    errors = zeros(N, N_IT);
    o = orders(j);
    for i = 1:N_IT
        [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, o, 0.002, 0);
    end

    subplot(2, 3, j+1)
    eeg_spcgm(mean(errors, 2));
	ylim([0 120])
    title(sprintf('M = %i', orders(j)))
end


