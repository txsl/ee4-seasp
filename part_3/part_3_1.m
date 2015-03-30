
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 2;

w = [0.1; 0.8];

mu_1 = 0.01;
mu_2 = 0.05;
leak = [0.2 0.8];

e_mu1_sum = zeros(N, 1);
e_mu2_sum = zeros(N, 1);
e_leaky_sum = zeros(N, 1);

w_est_mu1_sum = zeros(2, 1);
w_est_mu2_sum = zeros(2, 1);
w_leaky_est_sum = zeros(2, 1);

error_tot = zeros(N, 1);
w_est_tot = zeros(ORDER, N+1);

for i = 1:N_IT

    wgn = randn(N, 1)*sqrt(VAR_PROC);

    x = zeros(N, 1);
    diff_x = x;

    % Generate the signal
    x(1:2) = wgn(1:2);
%     diff_x(1:2) = wgn(1:2);

    for n = 3:N
        x(n) = fliplr(x(n-2:n-1)') * w + wgn(n);
%         diff_x(n) = x(n-2)*0.8 + x(n-1)*0.1 + wgn(n);
    end

	[ w_est, error_sq ] = lms(x, ORDER, 0.05, 0);
    error_tot = error_tot + error_sq;
    w_est_tot = w_est + w_est_tot;
%     plot(10*log10(error_sq))
    
%     mean_tot = mean(x) + mean_tot;
%     
%     w_est_mu1 = zeros(2, N);
%     w_est_mu2 = zeros(2, N);
%     w_leaky_est = zeros(2, N);
%     
%     x_est_mu1 = zeros(N, 1);
%     x_est_mu2 = zeros(N, 1);
%     x_est_leaky = zeros(N, 4);
% 
%     e_mu1 = zeros(N, 1);
%     e_mu2 = zeros(N, 1);
%     e_leaky = zeros(N, 1);
% 
% 
%     for n=3:N
%         for m=1:length(leak)*2
%             x_est = w_leaky_est(:, n)' * flipud(x(n-2:n-1));
%         end
%         x_est_mu1(n) = w_est_mu1(:, n)' * flipud(x(n-2:n-1));
%         x_est_mu2(n) = w_est_mu2(:, n)' * flipud(x(n-2:n-1));
%         x_est_leaky(n) = 
% 
%         e_mu1(n) = x(n) - x_est_mu1(n);
%         e_mu2(n) = x(n) - x_est_mu2(n);
%         e_leaky(n) = x(n) - x_est_leaky(n);
% 
%         w_est_mu1(:, n+1) = w_est_mu1(:, n) + mu_1 * e_mu1(n) * flipud(x(n-2:n-1));
%         w_est_mu2(:, n+1) = w_est_mu2(:, n) + mu_2 * e_mu2(n) * flipud(x(n-2:n-1));
%         w_leaky_est(:, n+1) = (1 - mu_2*leak)*w_leaky_est(:, n) + mu_2 * e_leaky(n) * flipud(x(n-2:n-1));
%     end
    
    % Computing the misadjustment for 3.1.e
%     r_xx = xcorr(x, 'unbiased');
%     R_xx = toeplitz(r_xx(1000:1000+length(w)));
%     
%     M_lms_mu1 = mu_1 * trace(R_xx) / 2;
%     M_lms_mu2 = mu_2 * trace(R_xx) / 2;

    % Converting to dB and saving the error for each trial
%     e_mu1 = e_mu1.^2;
%     e_mu2 = e_mu2.^2;
%     e_leaky = e_leaky.^2;
%     
%     e_mu1_sum = e_mu1_sum + e_mu1;
%     e_mu2_sum = e_mu2_sum + e_mu2;
%     e_leaky_sum = e_leaky_sum + e_leaky;
    
    % Saving the coefficient estimates 
%     w_est_mu1_sum = w_est_mu1_sum + w_est_mu1(:,1001);
%     w_est_mu2_sum = w_est_mu2_sum + w_est_mu2(:,1001);
    
end

% Average Coefficient Estimates
w_est_tot = w_est_tot/N_IT;
% w_est_mu2_sum = w_est_mu2_sum/N_IT

% Average Error (for each iteration)
error_tot = error_tot/N_IT;
% e_mu1_sum = e_mu1_sum/N_IT;
% e_mu2_sum = e_mu2_sum/N_IT;
% e_leaky_sum = e_leaky_sum/N_IT;

% pause

% Manual misadjustment computation
% avg_e_mu1 = e_mu1_sum(900:1000);
% avg_e_mu2 = e_mu2_sum(N/2:N);


% emse_mu1 = (mean(e_mu1_sum(500:end)) - VAR_PROC)/VAR_PROC
% emse_mu2 = (mean(e_mu2_sum(500:end)) - VAR_PROC)/VAR_PROC

% Convert error to dB
error_tot = 10*log10(error_tot);
% e_mu2_sum = 10*log10(e_mu2_sum);
% e_leaky_sum = 10*log10(e_leaky_sum);

% figure
% subplot(1,2,1)
% plot(e_mu1_sum);
% grid on;
% xlabel('Iteration')
% ylabel('Average Squared Prediction Error (dB)')
% title('LMS Error for $$\mu=0.01$$', 'interpreter', 'latex')
% 
% subplot(1,2,2)
% plot(e_mu2_sum);
% grid on;
% xlabel('Iteration')
% ylabel('Squared Prediction Error (dB)')
% title('LMS Error for $$\mu=0.05$$', 'interpreter', 'latex')

figure
% plot(1:N, e_mu1_sum, 1:N, e_mu2_sum, 1:N, e_leaky_sum)
plot(1:N, error_tot)
legend('\mu = 0.01', '\mu = 0.05')
grid on;
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')

