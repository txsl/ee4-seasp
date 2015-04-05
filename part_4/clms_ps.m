function [ h_est, H, y_est, error ] = clms_ps(x, d, order, mu)

N = length(x);

h_est = zeros(order, N);
error = zeros(N, 1);
y_est = zeros(N, 1);
H = zeros(N);
for n = order+1:N-1
    
    x_n = flipud(x(n-order:n-1));
    
    y_est(n) = h_est(:, n)' * x_n;
    
    error(n) = d(n) - y_est(n);
    
    [ h, ~ ] = freqz(1, [1; h_est(:, n)], 1024);
    H(:, n) = abs(h).^2;
    
    h_est(:, n+1) = h_est(:, n) + mu*conj(error(n))*x_n;
    
end

end

