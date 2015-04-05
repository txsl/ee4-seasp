
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 2;

w = [0.1; 0.8];

x_mat = zeros(N, N_IT);

for i = 1:N_IT
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
colours = hsv(12);
n = 1;

for mu = [ 0.01 0.05 ]
    
    for leak = [0 0.2 0.5 0.8]
        error_tot = zeros(N, 1);
        w_est_tot = zeros(ORDER, N+1);
        
        for i = 1:N_IT
            	[ w_est, ~, error_sq ] = lms(x_mat(:, i), x_mat(:, i), ORDER, mu, leak);
                error_tot = error_tot + error_sq;
                w_est_tot = w_est_tot + w_est;
        end
        
        error_tot = error_tot/N_IT;
        error_db = 10*log10(error_tot);
        plot(error_db, 'DisplayName', sprintf('mu = %f, gamma = %f', mu, leak), 'color', colours(n,:))
        n = n + 1;
        
        w_est_tot = w_est_tot/N_IT;
        w_est_tot = mean(w_est_tot(:, 800:end), 2);
        
        fprintf('mu=%f, leak=%f, a1=%f, a2=%f\n', mu, leak, w_est_tot(1), w_est_tot(2));
    end
end

legend(gca, 'show')
grid on;
title('LMS filter with different step sizes and leak parameters');
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')