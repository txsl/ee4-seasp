
addpath('../')
common.init

set(0,'DefaultFigureVisible','off')
SEASP_Part_1_2_a
set(0,'DefaultFigureVisible','on');

%% M = 10

fprintf('M=10, Imaginary Component = %e\n', sum(imag(xf_10)));

% Plot in case we are interested
figure;

stem(limspace(1, L), real(fftshift(xf_10)))
axis tight;
xlabel('Normalised Frequency')
ylabel('Real Power')
title('DFT of ACF (ie the PSD), $M=10$')
common.set_graph_params

%% M = 128

fprintf('M=128, Imaginary Component = %e\n', sum(imag(xf_128)));

% Plot in case we are interested
figure;

stem(limspace(1, L), real(fftshift(xf_128)))
axis tight;
xlabel('Normalised Frequency')
ylabel('Real Power')
title('DFT of ACF (ie the PSD), $M=128$')
common.set_graph_params
