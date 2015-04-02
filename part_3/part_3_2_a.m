
addpath('../')
common.init

N = 1000;
N_IT = 100;
VAR_PROC = 0.5;
ORDER = 1;

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

%% Main plot comparing 

methods = {'benveniste', 'ang', 'matthews'};
rhos = [ 0.0001 0.001 ];
no_lines = length(rhos)*length(methods) + 2;
cols = common.distinguishable_colors(no_lines);
col_idx = 1;
leg = cell(no_lines, 1);
figure;
hold on;

for mu = [0.01 0.1]
    w_est_tot = zeros(ORDER, N+1);
    
    for i=1:N_IT
        [ w_est, ~ ] = lms_adaptive(wgn_mat(:, i), x_mat(:, i), 'none', mu, 0, 0);
        w_est_tot = w_est_tot + w_est;
    end
    
    w_est_tot = w_est_tot/N_IT;
    w_est_shift = 0.9 - w_est_tot;
    plot(w_est_shift, 'Color', cols(col_idx, :));
    leg{col_idx} = sprintf('LMS: \\mu=%f', mu);
    col_idx = col_idx + 1;
end

for method = methods
    for rho = rhos
        w_est_tot = zeros(ORDER, N+1 );

        for i = 1:N_IT
            [ w_est, ~ ] = lms_adaptive(wgn_mat(:, i), x_mat(:, i), method, 0, rho, 0.95);
            w_est_tot = w_est_tot + w_est;
        end

        w_est_tot = w_est_tot/N_IT;
        w_est_shift = 0.9 - w_est_tot;
        plot(w_est_shift, 'Color', cols(col_idx, :));
        leg{col_idx} = sprintf('%s: \\rho = %f', method{1}, rho);
        col_idx = col_idx + 1;
    end
end

% for method = {'benveniste', 'ang', 'matthews'}
%     w_est_tot = zeros(ORDER, N+1);
%     
%     for i = 1:N_IT
%         [ w_est, ~ ] = lms_adaptive(wgn_mat(:, i), x_mat(:, i), method, 0, 0.001, 0.95);
%         w_est_tot = w_est_tot + w_est;
%     end
%     
%     w_est_tot = w_est_tot/N_IT;
%     w_est_shift = 0.9 - w_est_tot;
%     plot(w_est_shift, 'Color', cols(col_idx, :));
%     col_idx = col_idx + 1;
% end
% 
xlim([1 N])
% legend('LMS, \mu = 0.01', 'LMS, \mu = 0.1', 'Benveniste', 'Ang & Farhang', 'Matthews & Xie')
legend(leg)
grid on
 
%% Let's explore the value of alpha

% alphas = [ 0.01 0.2 0.5 0.8 0.95 ];
% cols = common.distinguishable_colors(length(alphas));
% col_idx = 1;
% figure;
% hold on;
% leg = cell(length(alphas), 1);
% 
% for alpha = alphas
%     w_est_tot = zeros(ORDER, N+1);
%     
%     for i = 1:N_IT
%         [ w_est, ~ ] = lms_adaptive(wgn_mat(:, i), x_mat(:, i), 'ang', 0, 0.001, alpha);
%         w_est_tot = w_est_tot + w_est;
%     end
%     
%     w_est_tot = w_est_tot/N_IT;
%     w_est_shift = 0.9 - w_est_tot;
%     plot(w_est_shift, 'Color', cols(col_idx, :));
%     leg{col_idx} = sprintf('\\alpha = %f', alpha);
%     col_idx = col_idx + 1;
% end
% 
% xlabel('Iteration')
% ylabel(['Weight Error ($\widehat{w}(n)$)'], 'interpreter', 'latex')
% xlim([1 N])
% legend(leg)
% grid on

%% Let's explore the value of rho

% 
% cols = common.distinguishable_colors(length(rhos)*3);
% col_idx = 1;
% 
% figure;
% hold on;
% leg = cell(length(rhos*3), 1);
% 
% for method = {'benveniste', 'ang', 'matthews'}
%     for rho = rhos
%         w_est_tot = zeros(ORDER, N+1);
% 
%         for i = 1:N_IT
%             [ w_est, ~ ] = lms_adaptive(wgn_mat(:, i), x_mat(:, i), method, 0, rho, 0.95);
%             w_est_tot = w_est_tot + w_est;
%         end
% 
%         w_est_tot = w_est_tot/N_IT;
%         w_est_shift = 0.9 - w_est_tot;
%         plot(w_est_shift, 'Color', cols(col_idx, :));
%         leg{col_idx} = sprintf('%s: \\rho = %f', method{1}, rho);
%         col_idx = col_idx + 1;
%     end
% end
%     
% xlabel('Iteration')
% ylabel('Weight Error ($\widehat{w}(n)$)', 'interpreter', 'latex')
% xlim([1 N])
% legend(leg)
% grid on

