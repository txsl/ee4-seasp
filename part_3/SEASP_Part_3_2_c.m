
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
    
    wgn = randn(N, 1)*sqrt(VAR_PROC);
    wgn_mat(:, i) = wgn;

    x = zeros(N, 1);
    x(1) = wgn(1);

    for n = 2:N
        x(n) = wgn(n) + 0.9*wgn(n-1);
    end

    x_mat(:, i) = x;
end

%% Reference against Benveniste's Algorithm

ro = 0.01;
mus = 1;

no_lines = length(mus)*2;
cols = distinguishable_colors(no_lines);
col_idx = 1;
leg = cell(no_lines, 1);
figure;
hold on;

for mu = mus
    w_est_tot = zeros(ORDER, N+1);
    
    for i=1:N_IT
        [ w_est, ~ ] = lms_gass(wgn_mat(:, i), x_mat(:, i), ORDER, 'benveniste', 0.01, 0.00001, 0);
        w_est_tot = w_est_tot + w_est;
    end
    
    w_est_tot = w_est_tot/N_IT;
    w_est_shift = 0.9 - w_est_tot(1, :);
    plot(w_est_shift, 'Color', cols(col_idx, :));
    leg{col_idx} = sprintf('Benveniste: \\mu=%f', mu);
    col_idx = col_idx + 1;
end

%% GNGD Algorithm

for mu = mus
    w_est_tot = zeros(ORDER, N+1);
    
    for i=1:N_IT
        [ w_est, ~ ] = lms_gngd(wgn_mat(:, i), x_mat(:, i), ORDER, 1, 1);
        w_est_tot = w_est_tot + w_est;
    end
    
    w_est_tot = w_est_tot/N_IT;
    w_est_shift = 0.9 - w_est_tot(1, :);
    plot(w_est_shift, 'Color', cols(col_idx, :));
    leg{col_idx} = sprintf('GNGD: \\mu=%f', mu);
    col_idx = col_idx + 1;
end

xlabel('Iteration')
ylabel('Weight Error ($\widehat{w}(n)$)', 'interpreter', 'latex')
xlim([1 N])
legend(leg)
common.set_graph_params


