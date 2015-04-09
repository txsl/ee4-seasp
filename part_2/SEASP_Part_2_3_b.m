
addpath('../')
common.init

load('../data/EEG_Data_Assignment2.mat')

%spectrogram(x, hamming(64), 32, FFTs(i), 1000, 'yaxis')
% spectrogram(POz, 4096, 3726, 4096, 1200, 'yaxis')
% ylim([ 0 60 ])

figure
spectrogram(POz, hanning(4096), 3000, 4096, 1200, 'yaxis')
ylim([ 0 60 ])