
addpath('../')
common.init

N = 1000;
N_IT = 10;

DELAY = 5;
ORDER = 4;

sig = zeros(N, N_IT);

sine_wave = sin(0.01*pi*(1:N))';


for j = 1:N_IT
    v = randn(N, 1);
    
    sig(1:2, j) = sine_wave(1:2);

    for i = 3:N
        sig(i, j) = v(i) + 0.5*v(i-2) + sine_wave(i);
    end
end

%% For varying filter orders

orders = [ 5 10 15 20 ];
cols = common.distinguishable_colors(length(orders));
leg_text = cell(length(orders), 1);

x_est_tot = zeros(N, 1);

figure;
hold on;

for j = 1:length(orders)
    for i = 1:N_IT
        u = zeros(N, 1);
        u(DELAY+1:end) = sig(1:end-DELAY, i);

        [ ~, x_est, error_sq ] = lms(u, sig(:, i), orders(j), .01, 0);

        x_est_tot = x_est_tot + x_est;
    end
    err = mspe(sine_wave, x_est_tot/N_IT);
    
    plot(10*log10(err), 'color', cols(j, :));
    leg_text{j} = sprintf('Order: %i', orders(j));
    
end

legend(leg_text);
common.set_graph_params;

% 
% plot(1:N, x_est_tot, 1:N, mean(sig, 2), 1:N, sin(0.01*pi*(1:N)))
% legend('X estimated', 'Input Signal', 'Reference Sinusoid')
% common.set_graph_params
% 
% figure
% plot(mspe(sine_wave, x_est_tot))
% common.set_graph_params
