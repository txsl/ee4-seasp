function [ w_est, error_sq ] = lms_adaptive(wgn, x, step_method, mu, rho, alpha)

N = length(x);

w_est = zeros(1, N);
error = zeros(N, 1);
x_est = zeros(N, 1);

step = 0;


for n = 3:N
    %% Standard LMS Algorithm
    x_est(n) = w_est(:, n)' * wgn(n-1);
    
    error(n) = x(n) - x_est(n);
    
    w_est(:, n+1) = w_est(:, n) + mu*error(n)*wgn(n-1);
    
    %% GASS Algorithms
    % Benveniste
    if strcmp(step_method, 'benveniste') 
    step = (1 - mu*(wgn(n-2)^2))*step + error(n-1)*wgn(n-2);
    
    %Ang & Farhang
    elseif strcmp(step_method, 'ang')
    step = alpha*step + error(n-1)*wgn(n-2);
    
    % Matthews & Xie
    elseif strcmp(step_method, 'matthews')
    step = error(n-1)*wgn(n-2);
    
    % Standard LMS
    else
    step = 0;
    end
    
    mu = mu + (rho * error(n) * x(n-1) * step);

end

error_sq = error.^2;

end

