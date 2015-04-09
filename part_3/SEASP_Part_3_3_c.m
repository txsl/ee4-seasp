
addpath('../')
common.init

% Set up parameters
N = 1000;
N_IT = 100;

ORDER = 4;
DELAY = 5;

% Generate input signals
sig = zeros(N, N_IT);
sine_wave = sin(0.01*pi*(1:N))';

for j = 1:N_IT
    sig(:, j) = filter([1 0 0.5], 1, randn(N, 1)) + sine_wave;
end

% Get output
error_tot_anc = zeros(N, N_IT);
x_est_tot_ale = zeros(N, N_IT);

for j = 1:N_IT
    
    % For the ANC configuration
    e = randn(N, 1);
    [ ~, ~, error_tot_anc(:, j) ] = lms(e, sig(:, j), ORDER, .01, 0);

    % For the ALE Configuration
    u = zeros(N, 1);
    u(DELAY+1:end) = sig(1:end-DELAY, j);

    [ ~, x_est_tot_ale(:,j), ~ ] = lms(u, sig(:, j), ORDER, .01, 0);
end

figure
plot(1:N, ((mean(error_tot_anc, 2) - sine_wave).^2), 1:N, ((mean(x_est_tot_ale, 2) - sine_wave).^2));
legend('ANC - Adaptive Noise Cancellation', 'ALE - Adaptive Line Enhancement');
xlabel('Iteration');
ylabel('Squared Prediction Error')
common.set_graph_params

fprintf('ANC MSPE = %f, ALE MSPE = %f', mean(mspe(repmat(sine_wave, [1 N_IT]), error_tot_anc)), mean(mspe(repmat(sine_wave, [1 N_IT]), x_est_tot_ale)))