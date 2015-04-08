
addpath('../')
common.init

N = 256;

ZERO_PAD = 16;


% stem(limspace(1, N*ZERO_PAD), fftshift(mag2db(abs(fft(chebywin, N*ZERO_PAD)))));

A2s = [1 0.1 0.01 0.001];
SIDES = [20 50 100];

for j = 1:length(SIDES)
    chebywin = chebwin(N, SIDES(j));
    figure;
    for i = 1:length(A2s)

        sig = SEASP_Part_1_3_sig_gen(0.2, 1, A2s(i), 0, 0, 4, N, 0);

        sig_corr = xcorr(sig);
        sig_corr = sig_corr.*chebwin(length(sig_corr), SIDES(j))';

        sig_corr_pad = zeros(N*ZERO_PAD, 1);
        sig_corr_pad(1:length(sig_corr)) = sig_corr;
        sig_corr_pad = circshift(sig_corr_pad, -N);

        sig = sig .* chebywin';

        sig_f = fft(sig, ZERO_PAD*N);
        sig_corr_f = fft(sig_corr_pad, ZERO_PAD*N);
        w = limspace(1, N*ZERO_PAD);

        subplot(2, 4, i)
        plot(w, mag2db(abs(sig_f).^2));
        xlabel('Normalised Frequency');
        ylabel('Power (dB)')
        title(sprintf('Chebyshev Filt. Sig., $ a_2=%.2f $, Sidelobe = %idB', A2s(i), SIDES(j)));
        xlim([0.5 0.7])
    %     xlim([0.4 0.8])
    %     axis tight
        common.set_graph_params

        subplot(2, 4, i+4)
        plot(w, mag2db(abs(sig_corr_f).^2));
        xlabel('Normalised Frequency');
        ylabel('Power (dB)')
        title(sprintf('Blackman-Tukey Filt. Sig., $ a_2=%.3f $, Sidelobe = %idB', A2s(i), SIDES(j)));
        xlim([0.5 0.7])
        common.set_graph_params


    end
end


% 
% figure;
% for i = 1:length(A2s)
% 
%     sig = SEASP_Part_1_3_sig_gen(0.2, 1, A2s(i), 0, 0, 12, N, 0);
%     sig = sig .* chebywin';
%     
%     sig_f = fft(sig, ZERO_PAD*N);
%     w = limspace(1, N*ZERO_PAD);
% 
%     subplot(1, 4, i)
%     plot(w, mag2db(abs(sig_f).^2));
%     xlabel('Normalised Frequency');
%     ylabel('Power (dB)')
%     title(sprintf('Periodogram, $ a_2=%.3f $, $ \\alpha= %i$', A2s(i), 12));
% %     xlim([0.45 0.65])
% %     axis tight
%     xlim([0 1])
%     common.set_graph_params
% 
% end