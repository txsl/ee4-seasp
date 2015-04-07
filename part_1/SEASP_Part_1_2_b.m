
addpath('../')
common.init

set(0,'DefaultFigureVisible','off')
SEASP_Part_1_2_a
set(0,'DefaultFigureVisible','on');

figure;

stem(0:L-1, real(xf_10))
xlim([0 L-1])
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD), $M=10$')


stem(0:L-1, real(xf_128))
xlim([0 L-1])
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD), $M=128$')