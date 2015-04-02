
addpath('../')
common.init

N = 1000;

M = 3;

v = randn(N, 1);
noise = zeros(N, 1);

for i = 3:N
    noise(i) = v(i) + 0.5*v(i-2);
end

sig = noise + sin(0.01*pi*1:N)';

u = zeros(N, 1);
u(1:end-M) = sig(M+1:end);

[ w_est, x_est, error_sq ] = lms(u, sig, M, .01, 0);