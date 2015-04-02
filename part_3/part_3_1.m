
addpath('/../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 2;

w = [0.1; 0.8];

mu_1 = 0.01;
mu_2 = 0.05;
 
error_tot_mu_5 = zeros(N, 1);
w_est_tot_mu_5 = zeros(ORDER, N+1);

error_tot_mu_1 = zeros(N, 1);
w_est_tot_mu_1 = zeros(ORDER, N+1);

start = 0;
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
    
    if start == 0
        plot(1:N, 10*log10(error_tot_mu_1), 1:N, 10*log10(error_tot_mu_5))
        legend('\mu = 0.01', '\mu = 0.05')
        grid on;
        title('LMS filter with differing step sizes');
        xlabel('Iteration')
        ylabel('Squared Prediction Error (dB)');
        start = 1;
    end
    
end


% Average filter coefficient values - steady state
w_est_tot_mu_5 = w_est_tot_mu_5/N_IT;
w_est_tot_mu_1 = w_est_tot_mu_1/N_IT;

w_est_ss_mu_5 =  mean(w_est_tot_mu_5(:, 900:1000), 2)
w_est_ss_mu_1 =  mean(w_est_tot_mu_1(:, 900:1000), 2)


% Average Error (for each iteration)
error_tot_mu_5 = error_tot_mu_5/N_IT;
error_tot_mu_1 = error_tot_mu_1/N_IT;

emse_mu_5 = mean(error_tot_mu_5(800:end)) - VAR_PROC
emse_mu_1 = mean(error_tot_mu_1(800:end)) - VAR_PROC

% Manual misadjustment computation
misadj_mu_5 = emse_mu_5/VAR_PROC
misadj_mu_1 = emse_mu_1/VAR_PROC

% Turn error to dB
error_tot_mu_5_db = 10*log10(error_tot_mu_5);
error_tot_mu_1_db = 10*log10(error_tot_mu_1);

figure
plot(1:N, error_tot_mu_1_db, 1:N, error_tot_mu_5_db)
legend('= 0.01', ' = 0.05')
grid on;
title('Mean Error of 100 iterations of LMS filter');
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')

