
addpath('../')
common.init

SEASP_Part_2_1_b

figure;
plot(w, mag2db(mean(psds, 2)))
xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Standard Deviation (dB)')
title('Standard Deviation of Ensemble (dB)')
common.set_graph_params