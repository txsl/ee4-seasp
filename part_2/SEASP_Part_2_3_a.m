
addpath('../')
common.init

t = -2:0.001:2;
x = chirp(t, 100, 1, 200, 'quadratic');

%spectrogram(x, 64, 2, 64, 'yaxis');

WINDOWS = [ 64 128 256 512 ];

figure;
for i = 1:length(WINDOWS)
    subplot(1, length(WINDOWS), i)
    spectrogram(x, hamming(WINDOWS(i)), round(0.8*WINDOWS(i)), WINDOWS(i), 1000, 'yaxis')
    title(sprintf('Window Size: %i, FFT: %i', WINDOWS(i), WINDOWS(i)));
end

FFTs = [ 64 128 512 1024 ];
figure;
for i = 1:length(WINDOWS)
    subplot(1, length(WINDOWS), i)
    spectrogram(x, hamming(64), 32, FFTs(i), 1000, 'yaxis')
    title(sprintf('FFT Length: %i', FFTs(i)));
end


figure;
OVERLAPS = [ 0.2 0.4 0.6 0.8 ];
for i = 1:length(OVERLAPS)
    subplot(1, length(OVERLAPS), i)
    spectrogram(x, hamming(512), round(OVERLAPS(i)*512), 512, 1000, 'yaxis')
    title(sprintf('Overlap: %i%%', 100*OVERLAPS(i)), 'interpreter', 'none');
end


figure;
WINDOW_TYPES = [ hamming(512), hanning(512), bartlett(512), chebwin(512) ];
WINDOW_NAMES = {'Hamming', 'Hanning', 'Bartlett', 'Chebyshev'};
for i = 1:size(WINDOW_TYPES, 2)
    subplot(1, size(WINDOW_TYPES, 2), i)
    spectrogram(x, WINDOW_TYPES(:,i), 400, 512, 1000, 'yaxis')
    title(sprintf('%s Window', WINDOW_NAMES{i}));
end






