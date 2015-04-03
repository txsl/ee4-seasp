
addpath('../')
common.init
load 'data/EEG_Data_Assignment2.mat'

N = length(Cz);
N_IT = 1000;

sine_wave = sin(100*pi*(1:N))';
noise_sig = zeros(N, N_IT);

for i = 1:N_IT
    noise_sig(:, i) = 2*randn(N, 1) + sine_wave;
end

% tic
% parfor i = 1:N_IT
%     [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, 8, .01, 0);
% end
% toc
%% Step Sizes

mus = [ 0.001 0.01 0.1 ];

figure;
subplot(2, 2, 1);
specgram(Cz, [], fs)

mus_errors = cell(length(mus), 1);

for j = length(mus)
    
    errors = zeros(N, N_IT);
    
    parfor i = 1:N_IT
        [ ~, ~, errors(:, i) ] = lms(noise_sig(:, i), Cz, 8, mus(j), 0);
    end
    mus_errors{j} = mean(errors, 2);
%     save(sprintf('mu_%f.mat', mus(j)), mean(errors,2));
%     subplot(2, 2, j)
%     specgram(mean(errors, 2), [], fs)
%     title(sprintf('\\mu = %f', mus(j)))
end

%% Filter Orders

orders = [ 0.001 0.01 0.1 ];

figure;
subplot(2, 2, 1);
specgram(Cz, [], fs)

orders_errors = cell(length(orders), 1);
for j = length(mus)
    
    errors = zeros(N, N_IT);
    
    parfor i = 1:N_IT
        [ ~, ~, orders(:, i) ] = lms(noise_sig(:, i), Cz, 8, mus(j), 0);
    end
    orders_errors{j} = mean(errors, 2);
%     subplot(2, 2, j)
%     specgram(mean(orders, 2), [], fs)
%     title(sprintf('\\mu = %f', mus(j)))
end

%% Save

save('ecg_noise_removal.mat', 'orders_errors', 'mus_errors');

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

