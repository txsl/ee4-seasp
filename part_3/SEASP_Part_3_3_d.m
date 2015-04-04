
addpath('../')
common.init
load 'data/EEG_Data_Assignment2.mat'

N = length(Cz);
N_IT = 1;

sine_wave = sin(100*pi*(1:N)/fs)';
noise_sig = zeros(N, N_IT);

for i = 1:N_IT
    noise_sig(:, i) = randn(N, 1) + 2*sine_wave;
end

% tic
% parfor i = 1:N_IT
%     [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, 8, .01, 0);
% end
% toc
%% Step Sizes - Generate Data!

mus = [ 0.001 0.01 0.1 ];

mus_errors = cell(length(mus), 1);

for j = 1:length(mus)
    
    errors = zeros(N, N_IT);
    
    m = mus(j)
    
    for i = 1:N_IT
        [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, 10, m, 0);
    end
end

save('mu.mat', 'mus_errors');

%% Filter Orders - Generate Data!

% orders = [ 2 5 10 15 20 ];
% 
% figure;
% subplot(2, 3, 1);
% specgram(Cz, [], fs)
% % 
% % orders_errors = cell(length(orders), 1);
% for j = 1:length(orders)
%     
%     errors = zeros(N, N_IT);
%     o = orders(j)
%     for i = 1:N_IT
%         [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, o, 0.01, 0);
%     end
% %     orders_errors{j} = errors;
%     subplot(2, 3, j+1)
%     specgram(mean(orders, 2), [], fs)
%     title(sprintf('M = %i', orders(j)))
% end

%% Step Sizes - Plot Data

load('mu.mat');

figure;
subplot(2, 2, 1);
specgram(Cz, [], fs)
title('Original Signal')

for j = 1:length(mus)
    
    subplot(2, 2, j+1)

    specgram(mean(mus_errors{j}, 2), [], fs)
    title(sprintf('$\mu$ = %f', mus(j)))
end

%% Filter Orders - Plot Data!


%% Old

% figure
% stem(linspace(-fs/2, fs/2, length(Cz)), abs(fftshift(fft(Cz))), 'marker', 'none');
% 
% figure
% stem(linspace(-fs/2, fs/2, length(Cz)), abs(fftshift(fft(mean(errors, 2)))), 'marker', 'none');
% 
% 
% figure
% specgram(Cz, [], fs)
% 
% figure 
% specgram(mean(errors, 2), [], fs)

