
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.5;
ORDER = 1;

x_mat = zeros(N, N_IT);

for i = 1:N_IT
    wgn = randn(N, 1)*sqrt(VAR_PROC);

    x = zeros(N, 1);

    % Generate the signal
    x(1) = wgn(1);

    for n = 2:N
        x(n) = wgn(n) + 0.9*wgn(n-1);
    end
    
    x_mat(:, i) = x;
end


error_tot = zeros(N, 1);
w_est_tot = zeros(ORDER, N+1);

figure
hold all
    
for i = 1:N_IT
    [ w_est, ~] = lms_adaptive(x_mat(:, i), 1, 'matthews', 0.01);
    w_est_tot = w_est_tot + w_est;
    plot(w_est)
end

w_est_tot = w_est_tot/N_IT;
plot(0.9 - w_est_tot)