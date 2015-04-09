
addpath('../')
common.init

sig = SEASP_Part_2_2_sig_gen(10500);

SAMP = 4096;
w = limspace(1, SAMP);

true_psd = mag2db(fftshift(abs(fft(sig, SAMP)).^2));

%% Plot the PSD of the Signal - now plotted on the same axes


% plot(w, true_psd)
% xlim([0 1])
% xlabel('Normalised Frequency')
% ylabel('Power (dB)')
% title('Measured PSD of Model')
% common.set_graph_params


%% Test out different model orders

K = [2 4 5 6 8 14];

figure;
hold on
cols = distinguishable_colors(length(K)+1);
leg = cell(length(K)+1, 1);
leg{1} = 'Measured PSD';

plot(w, true_psd, 'color', cols(1,:))


for i = 1:length(K)

    [pxx, w] = pyulear(sig, K(i), w);
    plot(w, mag2db(fftshift(pxx)), 'color', cols(i+1,:))
    leg{i+1} = sprintf('AR(%i) Model', K(i));
    
end

legend(leg)
xlim([0 0.5])
xlabel('Normalised Frequency')
ylabel('Power (dB)')
common.set_graph_params
