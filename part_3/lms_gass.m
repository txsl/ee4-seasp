function [ w_est, error_sq ] = lms_gass(x, d, order, step_method, mu, rho, alpha)

N = length(d);

w_est = zeros(order, N);
error = zeros(N, order);
x_est = zeros(N, order);

step = zeros(order, 1);


for n = order+2:N
    %% Standard LMS Algorithm
    x_est(n) = w_est(:, n)' * flipud(x(n-order:n-1));
    
    error(n) = d(n) - x_est(n);
    
    w_est(:, n+1) = w_est(:, n) + mu*error(n)*flipud(x(n-order:n-1));

    %% GASS Algorithms
    % Benveniste
    if strcmp(step_method, 'benveniste') 
    step = (eye(order) - mu*(flipud(x(n-order-1:n-2)) * flipud(x(n-order:n-1))'))*step + error(n-1)*flipud(x(n-order-1:n-2));
    
    %Ang & Farhang
    elseif strcmp(step_method, 'ang')
    step = alpha*step + error(n-1)*flipud(x(n-order:n-1));
    
    % Matthews & Xie
    elseif strcmp(step_method, 'matthews')
    step = error(n-1)*flipud(x(n-order:n-1));
    
    % Standard LMS
    else
    step = zeros(order, 1);
    end
    
    mu = mu + (rho * error(n) * flipud(x(n-order:n-1))' * step);

end

error_sq = error.^2;

end

