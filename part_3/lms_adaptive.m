function [ w_est, error_sq ] = lms_adaptive(x, order, step_method, ro )

N = length(x);

w_est = zeros(order, N);
error = zeros(N, 1);
x_est = zeros(N, 1);

step = 0;
mu = 0;

alpha = 0.1;

for n = order+2:N
    
    x_est(n) = w_est(:, n)' * x(n-1);
    
    error(n) = x(n) - x_est(n);
    
    w_est(:, n+1) = w_est(:, n) + mu*error(n)*x(n);
    
    % Benveniste
    if strcmp(step_method, 'benveniste') 
    step = (1 - mu*(x(n-2)^2))*step + error(n-1)*x(n-2);
    
    %Ang & Farhang
    elseif strcmp(step_method, 'ang')
    step = alpha*step + error(n-1)*x(n-2);
    
    % Matthews & Xie
    elseif strcmp(step_method, 'matthews')
    step = error(n-1)*x(n-2);

    end
    
    mu = mu + (ro * error(n) * x(n-1) * step);
    mu
    pause
%     disp(mu)
%     mu = 0.1;
    
end

error_sq = error.^2;

end

