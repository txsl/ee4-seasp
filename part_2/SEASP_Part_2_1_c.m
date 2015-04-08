
addpath('../')
common.init

SEASP_Part_2_1_b

%% Power in dB

figure;

subplot(1, 2, 1);

xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Power (dB)')
title('PSD Estimate - Ensemble and Mean (dB)')
common.set_graph_params

hold on

for i = 1:N_IT
    ens = plot(w, mag2db(psds(:,i)), ':r');
end

h1 = plot(w, mag2db(mean(psds, 2)));
set(h1, 'LineWidth', 2)
legend([h1 ens], 'Mean', 'Ensemble Iterations')


%% Std Dev in dB

% figure;

subplot(1, 2, 2);

plot(w, mag2db(std(psds, 0, 2)))
xlim(x_ax_scale)
xlabel('Normalised Frequency')
ylabel('Standard Deviation (dB)')
title('Standard Deviation of Ensemble (dB)')
common.set_graph_params