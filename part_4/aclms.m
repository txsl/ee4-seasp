function [ h_est, g_est, y_est, error ] = aclms(x, d, order, mu)

N = length(x);

g_est = zeros(order, N);
h_est = zeros(order, N);
error = zeros(N, 1);
y_est = zeros(N, 1);

for n = order+1:N-1
    
    x_n = flipud(x(n-order:n-1));
    
    y_est(n) = h_est(:, n)' * x_n + g_est(:, n)' * conj(x_n);
    
    error(n) = d(n) - y_est(n);
    
    h_est(:, n+1) = h_est(:, n) + mu*conj(error(n))*x_n;
    g_est(:, n+1) = g_est(:, n) + mu*conj(error(n))*conj(x_n);
    
end

end

