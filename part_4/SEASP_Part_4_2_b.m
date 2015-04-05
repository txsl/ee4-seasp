
addpath('../')
common.init

SEASP_Part_4_2_a


MU = 0.01;

[ h_est, ~, ~ ] = clms(y, y, 1, MU);

H = zeros(1024, 1500);

for n = 1:1500
    [ h, ~ ] = freqz(1, [1; -h_est(:, n)], 1024);
    H(:,n) = abs(h).^2;
end

medianH = 50*median(median(H));
H(H > medianH) = medianH;

surf(1:1500, 1:1024, H, 'LineStyle', 'none')

