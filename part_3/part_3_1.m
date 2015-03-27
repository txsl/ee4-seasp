
% init

N = 1000;
w = [0.1; 0.8];

wgn = randn(N, 1)*0.25;

x = zeros(N, 1);
diff_x = x;

% Generate the signal

x(1:2) = wgn(1:2);
diff_x(1:2) = wgn(1:2);

for n = 3:N
    x(n) = fliplr(x(n-2:n-1)') * w + wgn(n);
    diff_x(n) = x(n-2)*0.8 + x(n-1)*0.1 + wgn(n);
end

w_est_mu1 = zeros(2, N);
w_est_mu2 = w_est_mu1;

mu_1 = 0.01;
mu_2 = 0.05;
x_est_mu1 = zeros(N, 1);
x_est_mu2 = x_est_mu1;

e_mu1 = zeros(N, 1);
e_mu2 = e_mu1;


for n=3:N
    x_est_mu1(n) = w_est_mu1(:, n)' * flipud(x(n-2:n-1));
    x_est_mu2(n) = w_est_mu2(:, n)' * flipud(x(n-2:n-1));
    
    e_mu1(n) = x(n) - x_est_mu1(n);
    e_mu2(n) = x(n) - x_est_mu2(n);
    
    w_est_mu1(:, n+1) = w_est_mu1(:, n) + mu_1 * e_mu1(n) * flipud(x(n-2:n-1));
    w_est_mu2(:, n+1) = w_est_mu1(:, n) + mu_2 * e_mu2(n) * flipud(x(n-2:n-1));
end

plot(1:N, e_mu1, 1:N, e_mu2)

figure

e_mu1 = 10*log(e_mu1.^2);
e_mu2 = 10*log(e_mu2.^2);
plot(1:N, e_mu1, 1:N, e_mu2);

[ y, e, w ] = lms(x', x', 0.01, 2)
figure
plot(e)

