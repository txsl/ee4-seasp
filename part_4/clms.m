function [ h_est, x_est, error ] = clms(x, d, order, mu )

N = length(x);

h_est = zeros(order, N);
error = zeros(N, 1);
x_est = zeros(N, 1);

for n = order+1:N
    
    x_n = flipud(x(n-order:n-1));
    
    x_est(n) = h_est(:, n)' * x_n;
    
    error(n) = d(n) - x_est(n);
    
    h_est(:, n+1) = h_est(:, n) + mu*error(n)*x_n;
    
end

end

