
addpath('../')
common.init

N = 1000;
N_IT = 100;

ORDER = 4;

sig = zeros(N, N_IT);

sine_wave = sin(0.01*pi*(1:N))';


for j = 1:N_IT
    sig(:, j) = filter(1, [1 0 0.5], randn(N, 1)) + sine_wave;
end

error_tot = zeros(N, N_IT);
for j = 1:N_IT
    e = randn(N, 1);
    [ ~, ~, error_tot(:, j) ] = lms(e, sig(:, j), 5, .01, 0);
end

plot(1:N, mean(error_tot, 2), 1:N, sine_wave)

% mspe(sine_wave, error_tot, 2)
err = mean(mspe(repmat(sine_wave, [1 100]), error_tot))