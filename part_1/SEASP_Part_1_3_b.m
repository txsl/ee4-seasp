
addpath('../')
common.init

N = 256;

OVERSAMP = 16;

ALPHAS = [0.6 0.65 0.8 0.9];

for i = 1:length(ALPHAS)

    sig = SEASP_Part_1_3_sig_gen(0.2, 1, 1, 0, 0, ALPHAS(i), N, 0);

    sig_f = fft(sig, OVERSAMP*N);
    w = limspace(1, N*OVERSAMP);

    figure;
    plot(w, abs(sig_f).^2);
    xlabel('Normalised Frequency');
    ylabel('Power')
    title(sprintf('Periodogram, $ \\alpha=%.2f $', ALPHAS(i)));
    xlim([0.54 0.64])
    common.set_graph_params

end
