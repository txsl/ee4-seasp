
addpath('../')
common.init

load sunspot.dat

sunspots = sunspot(:, 2);
N = length(sunspots);
ZERO_PAD = 4;

cols = distinguishable_colors(5);
% plot(detrend(sunspots))
% 
% figure
% plot(sunspots - mean(sunspots))

ss_f = fft(sunspots, N*ZERO_PAD);
w = limspace(1, N*ZERO_PAD);

figure;
hold on
plot(w, mag2db(fftshift(abs(ss_f).^2)), 'color', cols(1,:))

%% Mean Centred Version

ss_mean = sunspots - mean(sunspots);
ss_f = fft(ss_mean, N*ZERO_PAD);

% figure;
plot(w, mag2db(fftshift(abs(ss_f).^2)), 'color', cols(2,:))
% xlim([-1 287])

%% Mean & Detrended version

% figure

% plot(1:288, detrend(ss_mean), 1:288, ss_mean)

ss_detrend = detrend(ss_mean);
ss_f = fft(ss_detrend, N*ZERO_PAD);

% figure;
plot(w, mag2db(fftshift(abs(ss_f).^2)), 'color', cols(3,:));
% xlim([-1 287])

%% Detrended Version

ss_detrend = detrend(sunspots);
ss_f = fft(ss_detrend, N*ZERO_PAD);
plot(w, mag2db(fftshift(abs(ss_f).^2)), 'color', cols(4,:));



%% Log Version

ss_log = log10(ss_mean);
ss_f = fft(ss_log, N*ZERO_PAD);
plot(w, mag2db(fftshift(abs(ss_f).^2)), 'color', cols(5,:));

legend({'Original Data', 'Mean Centred', 'Mean Centred and Detrended', 'Detrended', '$ \\log_{10} $ of Mean Centred$'}, 'Interpreter', 'latex');
title('Sunspot Periodogram, with various preprocessing methods applied');
ylabel('Power (dB)');
xlabel('Normalised Frequency');
common.set_graph_params
ylim([-10 170]);
xlim([0 1])

