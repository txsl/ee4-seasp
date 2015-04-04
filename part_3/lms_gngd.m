function [ w_est, error_sq ] = lms_gngd(x, d, order, mu, rho)

N = length(d);

w_est = zeros(order, N);
error = zeros(N, 1);
x_est = zeros(N, 1);
epsilon = zeros(N, 1);

for n = order+2:N

    x_n = flipud(x(n-order:n-1));
    x_n_1 = flipud(x(n-order-1:n-2));

    x_est(n) = w_est(:, n)' * x_n;
    
    error(n) = d(n) - x_est(n);
    
    w_est(:, n+1) = w_est(:, n) + (1/(epsilon(n) + x_n' * x_n))*error(n)*x_n;
    
    epsilon(n+1) = epsilon(n) - rho*mu*((error(n)*error(n-1)*x_n'*x_n_1)/((epsilon(n-1) + x_n_1' * x_n_1 )^2));
end

error_sq = error.^2;

end

