function [ w_est, error_sq ] = lms_gass(x, d, order, step_method, mu, rho, alpha)

N = length(d);

w_est = zeros(order, N);
error = zeros(N, order);
x_est = zeros(N, order);

mu = mu*ones(N, 1);
phi = zeros(order, 1);

x_n = x(1:order);

for n = order+1:N
    %% Some oft used variables
    
    x_n_1 = x_n;
    x_n = flipud(x(n-order+1:n));
    
    %% Standard LMS Algorithm
    x_est(n) = w_est(:, n)' * x_n;
    
    error(n) = d(n) - x_est(n);
    
    w_est(:, n+1) = w_est(:, n) + mu(n) * error(n) * x_n;

    %% GASS Algorithms
    % Benveniste
    if strcmp(step_method, 'benveniste') 
    phi = (eye(order) - (mu(n-1) * (x_n_1 * x_n_1'))) * phi + error(n-1)*x_n_1;
    
    %Ang & Farhang
    elseif strcmp(step_method, 'ang')
    phi = alpha*phi + error(n-1) * x_n_1;
    
    % Matthews & Xie
    elseif strcmp(step_method, 'matthews')
    phi = error(n-1) * x_n_1;
    
    % Standard LMS
    else
    phi = zeros(order, 1);
    end
    
    mu(n+1) = mu(n) + (rho * error(n) * x_n_1' * phi);

end

error_sq = error.^2;

end

