
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 2;

w = [0.1; 0.8];

mu_1 = 0.01;
mu_2 = 0.05;

% e_mu1_sum = zeros(N, 1);
% e_mu2_sum = zeros(N, 1);
% e_leaky_sum = zeros(N, 1);
% 
% w_est_mu1_sum = zeros(2, 1);
% w_est_mu2_sum = zeros(2, 1);
% w_leaky_est_sum = zeros(2, 1);
% 
error_tot_mu_5 = zeros(N, 1);
w_est_tot_mu_5 = zeros(ORDER, N+1);

error_tot_mu_1 = zeros(N, 1);
w_est_tot_mu_1 = zeros(ORDER, N+1);

for i = 1:N_IT

    wgn = randn(N, 1)*sqrt(VAR_PROC);

    x = zeros(N, 1);
    diff_x = x;

    % Generate the signal
    x(1:2) = wgn(1:2);

    for n = 3:N
        x(n) = fliplr(x(n-2:n-1)') * w + wgn(n);
    end

	[ w_est, error_sq ] = lms(x, ORDER, 0.05, 0);
    error_tot_mu_5 = error_tot_mu_5 + error_sq;
    w_est_tot_mu_5 = w_est_tot_mu_5 + w_est;

    [ w_est, error_sq ] = lms(x, ORDER, 0.01, 0);
    error_tot_mu_1 = error_tot_mu_1 + error_sq;
    w_est_tot_mu_1 = w_est_tot_mu_1 + w_est;
    
end


% Average filter coefficient values - steady state
w_est_tot_mu_5 = w_est_tot_mu_5/N_IT;
w_est_tot_mu_1 = w_est_tot_mu_1/N_IT;

w_est_ss_mu_5 =  mean(w_est_tot_mu_5(:, 900:1000), 2)
w_est_ss_mu_1 =  mean(w_est_tot_mu_1(:, 900:1000), 2)


% Average Error (for each iteration)
error_tot_mu_5 = error_tot_mu_5/N_IT;
error_tot_mu_1 = error_tot_mu_1/N_IT;


% Manual misadjustment computation
emse_mu_5 = mean(error_tot_mu_5(800:end))/VAR_PROC - 1
emse_mu_1 = mean(error_tot_mu_1(800:end))/VAR_PROC - 1

% Turn error to dB
error_tot_mu_5_db = 10*log10(error_tot_mu_5);
error_tot_mu_1_db = 10*log10(error_tot_mu_1);

figure
plot(1:N, error_tot_mu_1_db, 1:N, error_tot_mu_5_db)
legend('\mu = 0.01', '\mu = 0.05')
grid on;
title('LMS filter with different coefficients');
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')

