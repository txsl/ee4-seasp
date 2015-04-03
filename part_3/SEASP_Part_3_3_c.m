
addpath('../')
common.init

N = 1000;
N_IT = 100;

ORDER = 4;

sig = zeros(N, N_IT);

sine_wave = sin(0.01*pi*(1:N))';


for j = 1:N_IT
    
    sig(:, j) = filter(1, [1 0 0.5], randn(N, 1)) + sine_wave;
%     for i = 3:N
%         sig(i, j) = v(i) + 0.5*v(i-2) + sine_wave(i);
%     end
end

error_tot = zeros(N, N_IT);
for j = 1:N_IT
    
    e = randn(N, 1);
    
    [ ~, ~, error_tot(:, j) ] = lms(e, sig(:, j), 8, .01, 0);
    
end

plot(1:N, mean(error_tot, 2), 1:N, sine_wave)

mspe(sine_wave, mean(error_tot, 2))