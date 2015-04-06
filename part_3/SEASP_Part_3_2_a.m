
addpath('../')
common.init

N = 1000;
N_IT = 10;
VAR_PROC = 0.5;
ORDER = 2;

%% Generate and save the signal
x_mat = zeros(N, N_IT);
wgn_mat = zeros(N, N_IT);

for i = 1:N_IT
    wgn_mat(:, i) = randn(N, 1)*sqrt(VAR_PROC);
    x_mat(:, i) = filter([1 0.9], 1, wgn_mat(:, i));
end


%% Main plot comparing all methods, some rho values and the LMS

methods = { 'benveniste', 'ang', 'matthews'}; % ,  
method_names = containers.Map(methods, { 'Benveniste', 'Ang & Farhang', 'Matthews & Xie'});
rhos = [ 0.01 0.001 ];
no_lines = length(rhos)*length(methods) + 2;
cols = distinguishable_colors(no_lines);
col_idx = 1;
leg = cell(no_lines, 1);
figure;
hold on;

for mu = [0.01 0.1]
    w_est_tot = zeros(ORDER, N+1);
    
    for i=1:N_IT
        [ w_est, ~ ] = lms_gass(wgn_mat(:, i), x_mat(:, i), ORDER, 'none', mu, 0, 0);
        w_est_tot = w_est_tot + w_est;
    end
    
    w_est_tot = w_est_tot/N_IT;
    w_est_shift = 0.9 - w_est_tot(1, :);
    plot(w_est_shift, 'Color', cols(col_idx, :));
    leg{col_idx} = sprintf('LMS: \\mu = %0.3f', mu);
    col_idx = col_idx + 1;
end

for method = methods
    for rho = rhos
        w_est_tot = zeros(ORDER, N+1);

        for i = 1:N_IT
            [ w_est, ~ ] = lms_gass(wgn_mat(:, i), x_mat(:, i), ORDER, method, 0, rho, 0.9);
            w_est_tot = w_est_tot + w_est;
        end

        w_est_tot = w_est_tot/N_IT;
        w_est_shift = 0.9 - w_est_tot(1, :);
        plot(w_est_shift, 'Color', cols(col_idx, :));
        leg{col_idx} = sprintf('%s: \\rho = %0.3f', method_names(method{1}), rho);
        col_idx = col_idx + 1;
    end
end
disp(leg)
legend(leg, 'interpreter', 'tex')
title('GASS Methods tested across $\rho$ values, and LMS reference', 'interpreter', 'latex')
xlabel('Iteration')
ylabel('Weight Error ($\widehat{w}(n)$)', 'interpreter', 'latex')
xlim([0 350])
common.set_graph_params


%% Let's explore the value of alpha

alphas = [ 0.01 0.5 0.8 0.9 ];
cols = distinguishable_colors(length(alphas) + 2);
col_idx = 1;
figure;
hold on;
leg = cell(length(alphas) + 2, 1);

for mu = [0.01 0.1]
    w_est_tot = zeros(ORDER, N+1);
    
    for i=1:N_IT
        [ w_est, ~ ] = lms_gass(wgn_mat(:, i), x_mat(:, i), ORDER, 'none', mu, 0, 0);
        w_est_tot = w_est_tot + w_est;
    end
    
    w_est_tot = w_est_tot/N_IT;
    w_est_shift = 0.9 - w_est_tot(1, :);
    plot(w_est_shift, 'Color', cols(col_idx, :));
    leg{col_idx} = sprintf('LMS: \\mu =%0.3f', mu);
    col_idx = col_idx + 1;
end

for alpha = alphas
    w_est_tot = zeros(ORDER, N+1);
    
    for i = 1:N_IT
        [ w_est, ~ ] = lms_gass(wgn_mat(:, i), x_mat(:, i), ORDER, 'ang', 1, 0.001, alpha);
        w_est_tot = w_est_tot + w_est;
    end
    
    w_est_tot = w_est_tot/N_IT;
    w_est_shift = 0.9 - w_est_tot(1, :);
    plot(w_est_shift, 'Color', cols(col_idx, :));
    leg{col_idx} = sprintf('\\alpha = %0.3f', alpha);
    col_idx = col_idx + 1;
end

xlabel('Iteration')
ylabel('Weight Error ($\widehat{w}(n)$)', 'interpreter', 'latex')
title('Ang \& Farhang method for varying $\alpha$ values, and LMS reference', 'interpreter', 'latex')
xlim([1 N])
legend(leg, 'interpreter', 'tex')
common.set_graph_params

