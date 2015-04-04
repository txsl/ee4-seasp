
addpath('../')
common.init

%% Setup

N = 1000;
N_IT = 100;
MU = 0.01;
ORDER = 3;

b1 = 1.5 + 1j;
b2 = 2.5 - 0.5j;

%% Generate Signals

x = zeros(N, N_IT);
y = zeros(N, N_IT);

for i = 1:N_IT
    
    x(:, i) = randn(N, 1) + 1j*randn(N, 1);
    
    y(1) = x(1);
    for n = 2:N
        y(n, i) = x(n, i) + b1*x(n-1, i) + b2*conj(x(n-1, i));
    end
end

%% CLMS

h_est = zeros(ORDER, N, N_IT);

for i = 1:N_IT
    [ h_est(:, :, i) , ~, ~ ] = clms(x(:,i), y(:,i), ORDER, MU); 
end


plot(mean(real(h_est), 3)')

figure
plot(mean(imag(h_est), 3)')

%% ACLMS

h_est = zeros(ORDER, N, N_IT);
for i = 1:N_IT
    
end