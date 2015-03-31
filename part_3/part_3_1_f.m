
addpath('../')
common.init

N = 1000;
N_IT = 1000;
VAR_PROC = 0.25;
ORDER = 2;

w = [0.1; 0.8];

x_mat = zeros(N, N_IT);

parfor i = 1:N_IT
    wgn = randn(N, 1)*sqrt(VAR_PROC);

    x = zeros(N, 1);
    diff_x = x;

    % Generate the signal
    x(1:2) = wgn(1:2);

    for n = 3:N
        x(n) = fliplr(x(n-2:n-1)') * w + wgn(n);
    end
    
    x_mat(:, i) = x;
end

figure
hold on
for mu = [0.01 0.05]
    error_tot = zeros(N, 1);
    w_est_tot = zeros(ORDER, N+1);
    
    for leak = [0 0.2 0.8]
        for i = 1:N_IT
            	[ w_est, error_sq ] = lms(x_mat(:, i), ORDER, mu, leak);
                error_tot = error_tot + error_sq;
                w_est_tot = w_est_tot + w_est;
        end
        error_tot = error_tot/N_IT;
        error_db = 10*log10(error_tot);
        plot(error_db, 'DisplayName', sprintf('mu = %f, gamma = %f', mu, leak))
    end
end

legend(gca, 'show')
grid on;
title('LMS filter with different step sizes and leak parameters');
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')