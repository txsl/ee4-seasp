
addpath('../')
common.init

%% Setup

N = 100000;
N_IT = 100;
MU = 0.01;
ORDER = 2;

b1 = 1.5 + 1j;
b2 = 2.5 - 0.5j;

%% Generate Signals

x = zeros(N, N_IT);
y = zeros(N, N_IT);

for i = 1:N_IT
    
    % Normalisation factor to keep the noise with the correct amplitude
    x(:, i) = sqrt(1/2) * (randn(N, 1) + 1j*randn(N, 1));

    y(1, i) = x(1, i);
    for n = 2:N
        y(n, i) = x(n, i) + b1*x(n-1, i) + b2*conj(x(n-1, i));
    end
end

%% CLMS

h_est = zeros(ORDER, N, N_IT);
error = zeros(N, N_IT);

for i = 1:N_IT
    [ h_est(:, :, i), ~, error(:, i) ] = clms(x(:,i), y(:,i), ORDER, MU); 
end

figure
plot(10*log10(mean(abs(error).^2, 2)))
title('CLMS Error for WLMA(1) process')
xlabel('Iteration')
ylabel('Learning Curve (dB)')
common.set_graph_params

figure;
hold on;
plot(1:N, mean(real(h_est(1,:,:)), 3)', 1:N, mean(imag(conj(h_est(1,:,:))), 3)')
plot(1:N, mean(real(h_est(2,:,:)), 3)', 1:N, mean(imag(conj(h_est(2,:,:))), 3)');
title('Estmated Weights using CLMS');
xlabel('Iteration');
ylabel('Estimated Weight');
legend('$\Re \mathbf{h}_1^H$', '$\Im {\mathbf{h}_1^H}$', '$\Re {\mathbf{h}_2^H}$', '$\Im {\mathbf{h}_2^H}$')
common.set_graph_params

%% ACLMS

h_est = zeros(ORDER, N, N_IT);
g_est = zeros(ORDER, N, N_IT);
error = zeros(N, N_IT);

for i = 1:N_IT
    [ h_est(:, :, i), g_est(:, :, i), ~, error(:, i) ] = aclms(x(:,i), y(:,i), ORDER, MU); 
end

figure;
plot(10*log10(mean(abs(error).^2, 2)))
title('ACLMS Error for WLMA(1) process')
xlabel('Iteration')
ylabel('Learning Curve (dB)')
common.set_graph_params

figure;
hold on;
plot(1:N, mean(real(h_est(1,:,:)), 3)', 1:N, mean(imag(conj(h_est(1,:,:))), 3)', 1:N, mean(real(g_est(1,:,:)), 3)', 1:N, mean(imag(conj(g_est(1,:,:))), 3)');
plot(1:N, mean(real(h_est(2,:,:)), 3)', 1:N, mean(imag(conj(h_est(2,:,:))), 3)', 1:N, mean(real(g_est(2,:,:)), 3)', 1:N, mean(imag(conj(g_est(2,:,:))), 3)');
title('Estmated Weights using ACLMS');
xlabel('Iteration');
ylabel('Estimated Weight');
legend('$\Re \{ \mathbf{h}_1^H \}$', '$\Im \{\mathbf{h}_1^H \}$','$\Re \{ \mathbf{g}_1^H \}$', '$\Im \{ \mathbf{g}_1^H \}$', '$\Re \{ \mathbf{h}_2^H \}$', '$\Im \{ \mathbf{h}_2^H \}$','$\Re \{  \mathbf{g}_2^H \}$', '$\Im \{ \mathbf{g}_2^H \}$')
common.set_graph_params
