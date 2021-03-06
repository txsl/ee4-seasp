function [ w_est, error_sq ] = lms_gass(x, d, order, step_method, mu, rho, alpha)

N = length(d);

w_est = zeros(order, N);
error = zeros(N, 1);
x_est = zeros(N, 1);

mu = mu*ones(N, 1);

% No need to save all the values in time since we only use the previous value for calculating the new one
psi = zeros(order, 1);

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
    psi = (eye(order) - (mu(n-1) * (x_n_1 * x_n_1'))) * psi + error(n-1)*x_n_1;
    
    %Ang & Farhang
    elseif strcmp(step_method, 'ang')
    psi = alpha*psi + error(n-1) * x_n_1;
    
    % Matthews & Xie
    elseif strcmp(step_method, 'matthews')
    psi = error(n-1) * x_n_1;
    
    % Standard LMS
    else
    psi = zeros(order, 1);
    end
    
    mu(n+1) = mu(n) + (rho * error(n) * x_n_1' * psi);

end

error_sq = error.^2;

end

