
addpath('../')
common.init

N = 1000;
N_IT = 100;

DELAY = 5;
ORDER = 4;

sig = zeros(N, N_IT);
sine_wave = sin(0.01*pi*(1:N))';

for j = 1:N_IT
    sig(:, j) = filter(1, [1 0 0.5], randn(N, 1)) + sine_wave;
end

%% For varying filter orders

orders = [ 5 10 15 20 ];
cols = distinguishable_colors(length(orders) + 1);
leg_text = cell(length(orders), 1);

figure(1);
hold on;

figure(2);
hold on;

for j = 1:length(orders)
    
    error_tot = zeros(N, N_IT);
    x_est_tot = zeros(N, N_IT);
    
    for i = 1:N_IT
        u = zeros(N, 1);
        u(DELAY+1:end) = sig(1:end-DELAY, i);

        [ ~, x_est_tot(:,i), error_tot(:,i) ] = lms(u, sig(:, i), orders(j), .01, 0);

    end
    
    err = mean(mspe(repmat(sine_wave, [1 100]), x_est_tot));
    
    figure(1);
    plot(mean(x_est_tot, 2), 'color', cols(j, :));
    
    figure(2);
    plot(orders(j), err, '*');
    leg_text{j} = sprintf('Order: %i', orders(j));
    
end

figure(1);
plot(sine_wave, 'color', cols(end, :));
leg_text{end+1} = 'Reference Signal';
legend(leg_text);
common.set_graph_params;

figure(2);
common.set_graph_params;
xlabel('Filter order');
ylabel('MSPE (Mean Square Prediction Error');


%% For varying delay

figure(3);
hold on;

figure(4);
hold on;


delays = 0:25; %[ 0 1 5 10 15 20 25 ];
cols = distinguishable_colors(length(delays));
leg_text = cell(length(delays), 1);

for j = 1:length(delays)
    
    error_tot = zeros(N, N_IT);
    x_est_tot = zeros(N, N_IT);
    
    for i = 1:N_IT
        u = zeros(N, 1);
        u(delays(j)+1:end) = sig(1:end-delays(j), i);

        [ ~, x_est_tot(:,i), error_tot(:,i) ] = lms(u, sig(:, i), 5, .01, 0);
    end
    
    err = mean(mspe(repmat(sine_wave, [1 100]), x_est_tot));
    
    figure(3);
    hold on;
    plot(mean(x_est_tot, 2), 'color', cols(j, :));

    figure(4);
    hold on;
    plot(delays(j), err, '*')
    leg_text{j} = sprintf('Delay: %i', delays(j));
    
end
figure(3);
hold on;
legend(leg_text);
common.set_graph_params;

figure(4);
common.set_graph_params;
xlabel('Delay (delta)');
ylabel('MSPE (Mean Square Prediction Error');


%% Optimal Results

D = 4;
ORD = 5;

error_tot = zeros(N, N_IT);
x_est_tot = zeros(N, N_IT);

for i = 1:N_IT
    u = zeros(N, 1);
    u(D+1:end) = sig(1:end-D, i);

    [ ~, x_est_tot(:,i), error_tot(:,i) ] = lms(u, sig(:, i), ORD, .01, 0);
end
    
err = mean(mspe(repmat(sine_wave, [1 100]), x_est_tot))

figure
plot(1:N, mean(x_est_tot, 2), 1:N, mean(sig, 2), 1:N, sin(0.01*pi*(1:N)))
legend('X estimated', 'Input Signal', 'Reference Sinusoid')
common.set_graph_params

% figure
% plot(mspe(sine_wave, x_est_tot))
% common.set_graph_params
