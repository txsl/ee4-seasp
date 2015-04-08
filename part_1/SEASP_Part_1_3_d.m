
addpath('../')
common.init

N = 256;

OVERSAMP = 16;

A2s = [1 0.1 0.01];

for i = 1:length(A2s)

    sig = SEASP_Part_1_3_sig_gen(0.2, 1, A2s(i), 0, 0, 4, N, 0);

    sig_f = fft(sig, OVERSAMP*N);
    w = limspace(1, N*OVERSAMP);

    figure;
    plot(w, mag2db(abs(sig_f).^2));
    xlabel('Normalised Frequency');
    ylabel('Power')
    title(sprintf('Periodogram, $ a_2=%.2f $, $ \\alpha= %i$', A2s(i), 4));
    xlim([0.54 0.64])
%     axis tight
    common.set_graph_params

end

% A2s = [ 1 0.75 ];
for i = 1:length(A2s)

    sig = SEASP_Part_1_3_sig_gen(0.2, 1, A2s(i), 0, 0, 12, N, 0);

    sig_f = fft(sig, OVERSAMP*N);
    w = limspace(1, N*OVERSAMP);

    figure;
    plot(w, mag2db(abs(sig_f).^2));
    xlabel('Normalised Frequency');
    ylabel('Power')
    title(sprintf('Periodogram, $ a_2=%.3f $, $ \\alpha= %i$', A2s(i), 12));
    xlim([0.45 0.64])
%     axis tight
    common.set_graph_params

end