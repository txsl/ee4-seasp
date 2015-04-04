
addpath('/../')
common.init

N = 1000;
N_IT = 100;

b1 = 1.5 + 1j;
b2 = 2.5 - 0.5j;

x = zeros(N, N_IT);
y = zeros(N, N_IT);

for i = 1:N_IT
    
    x(:, i) = randn(N, 1) + 1j*randn(N, 1);
    
    y(1) = x(1);
    for n = 2:N
        y(n, i) = x(n, i) + b1*x(n-1, i) + b2*conj(x(n-1, i));
    end
end

h_est = 

for i = 1:N_IT
    
end