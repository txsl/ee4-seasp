function [ w_est, error_sq ] = lms_gngd(wgn, x, mu, rho)

N = length(x);

w_est = zeros(1, N);
error = zeros(N, 1);
x_est = zeros(N, 1);
epsilon = zeros(N, 1);

for n = 3:N
    x_est(n) = w_est(n) * wgn(n-1);
    
    error(n) = x(n) - x_est(n);
    
    w_est(n+1) = w_est(n) + (1/(epsilon(n) + wgn(n-1)^2))*error(n)*wgn(n-1);
    
    epsilon(n+1) = epsilon(n) - rho*mu*((error(n)*error(n-1)*wgn(n-1)*wgn(n-2))/((epsilon(n-1) + wgn(n-2)^2 )^2));
end

error_sq = error.^2;

end

