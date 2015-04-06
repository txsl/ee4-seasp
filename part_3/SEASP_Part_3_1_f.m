
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.25;
ORDER = 2;

x_mat = zeros(N, N_IT);

for i = 1:N_IT

    % Generate the signal
    x_mat(:, i) = filter(1, [1 -0.1 -0.8], randn(N, 1)*sqrt(VAR_PROC));

end

figure
hold on
colours = distinguishable_colors(8);
n = 1;

for mu = [ 0.01 0.05 ]
    
    for leak = [0 0.2 0.5 0.8]
        error_tot = zeros(N, N_IT);
        w_est_tot = zeros(ORDER, N+1, N_IT);
        
        for i = 1:N_IT
            % Shift our input by 1 to give it the delay it needs
            x_in = circshift(x_mat(:, i), 1);
            x_in(1) = 0;
            
            [ w_est_tot(:, :, i), ~, error_tot(:, i) ] = lms(x_in, x_mat(:, i), ORDER, mu, leak);
        end
        
        error_db = 10*log10(mean(error_tot.^2, 2));
        plot(error_db, 'DisplayName', sprintf('mu = %f, gamma = %f', mu, leak), 'color', colours(n,:))
        n = n + 1;
        
        w_est_tot = mean(mean(w_est_tot(:, 800:end, :), 3), 2);
        
        fprintf('mu=%f, leak=%f, a1=%f, a2=%f\n', mu, leak, w_est_tot(1), w_est_tot(2));
    end
end

legend(gca, 'show')
title('LMS filter with different step sizes and leak parameters');
xlabel('Iteration')
ylabel('Squared Prediction Error (dB)')
common.set_graph_params

