
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 1;

x_mat = zeros(N, N_IT);
wgn_mat = zeros(N, N_IT);
for i = 1:N_IT
    
    wgn = randn(N, 1)*sqrt(VAR_PROC);
    
    wgn_mat(:, i) = wgn;

    x = zeros(N, 1);
    diff_x = x;

%     % Generate the signal
    x(1) = wgn(1);

    % Generate the signal
%     x(1:2) = wgn(1:2);

    for n = 2:N
%         x(n) = x(n-1) * 0.9 + wgn(n);
        x(n) = wgn(n) + 0.9*wgn(n-1);
    end
    
%     wgn = randn(N, 1)*sqrt(VAR_PROC);
% 
%     x = zeros(N, 1);
% 
% 
%     
    x_mat(:, i) = x;
end


error_tot = zeros(N, 1);
w_est_tot = zeros(ORDER, N+1);

for i = 1:N_IT
    [ w_est, error] = lms_adaptive(wgn_mat(:, i), x_mat(:, i), 'benveniste', 0.01);
    w_est_tot = w_est_tot + w_est;
    error_tot = error + error_tot;
    %     plot(w_est)
end

w_est_tot = w_est_tot/N_IT;
w_est_shift = 0.9 - w_est_tot;

plot(w_est_shift)
 
% error_tot = error_tot/N_IT;
% figure
% plot(error_tot)

