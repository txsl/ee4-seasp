
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 2;


%% 3_1_b

mu_1 = 0.01;
mu_2 = 0.05;
 
error_tot_mu_5 = zeros(N, N_IT);
w_est_tot_mu_5 = zeros(ORDER, N+1, N_IT);

error_tot_mu_1 = zeros(N, N_IT);
w_est_tot_mu_1 = zeros(ORDER, N+1, N_IT);

start = 0;
for i = 1:N_IT
    wgn = randn(N, 1)*sqrt(VAR_PROC);
    
    % Generate the signal
    x = filter(1, [1 -0.1 -0.8], randn(N, 1)*sqrt(VAR_PROC));

	[ w_est_tot_mu_5(:, :, i), ~, error_tot_mu_5(:, i) ] = lms(x, x, ORDER, 0.05, 0);

    [ w_est_tot_mu_1(:, :, i), ~, error_tot_mu_1(:, i) ] = lms(x, x, ORDER, 0.01, 0);
    
    if start == 0
        plot(1:N, 10*log10(error_tot_mu_1(:,1).^2), 1:N, 10*log10(error_tot_mu_5(:,1).^2))
        legend('$\mu$ = 0.01', '$\mu$ = 0.05')
        common.set_graph_params
        title('LMS filter with differing step sizes');
        xlabel('Iteration')
        ylabel('Squared Prediction Error (dB)');
        start = 1;
    end
end

% Square the error
error_tot_mu_5 = error_tot_mu_5.^2;
error_tot_mu_1 = error_tot_mu_1.^2;

% Turn error to dB
error_tot_mu_5_db = 10*log10(mean(error_tot_mu_5, 2));
error_tot_mu_1_db = 10*log10(mean(error_tot_mu_1, 2));

figure
plot(1:N, error_tot_mu_1_db, 1:N, error_tot_mu_5_db)
legend('$\mu$ = 0.01', '$\mu$ = 0.05')
common.set_graph_params
title('Mean Error of 100 iterations of LMS filter');
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')

%% 3_1_c

% EMSE Calculations
emse_mu_5 = mean(mean(error_tot_mu_5(800:end, :), 2)) - VAR_PROC;
emse_mu_1 = mean(mean(error_tot_mu_1(800:end, :), 2)) - VAR_PROC;

% Misadjustment computation
misadj_mu_5 = emse_mu_5/VAR_PROC
misadj_mu_1 = emse_mu_1/VAR_PROC


%% 3_1_d
% Average filter coefficient values - steady state
w_est_ss_mu_5 =  mean(mean(w_est_tot_mu_5(:, 800:end, :), 3), 2)
w_est_ss_mu_1 =  mean(mean(w_est_tot_mu_1(:, 800:end, :), 3), 2)

