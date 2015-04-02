function [ w_est, x_est, error_sq ] = lms(x, d, order, mu, leak )

N = length(x);

w_est = zeros(order, N);
error = zeros(N, 1);
x_est = zeros(N, 1);

for n = order+1:N
    
    x_est(n) = w_est(:, n)' * flipud(x(n-order:n-1));
    
    error(n) = d(n) - x_est(n);
    
    w_est(:, n+1) = (1-mu*leak)*w_est(:, n) + mu*error(n)*flipud(x(n-order:n-1));
    
end

error_sq = error.^2;

end

