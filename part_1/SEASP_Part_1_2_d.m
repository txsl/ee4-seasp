
addpath('../')
common.init

set(0,'DefaultFigureVisible','off')
SEASP_Part_1_2_a
set(0,'DefaultFigureVisible','on');

%% Demo of using limspace and good spacing. Commented out since the other plots use it too
% figure;
% w = limspace(pi, L);
% 
% stem(w, fftshift(abs(xf_10)))
% axis tight;
% 
% common.set_graph_params

%% Experiment with the ifft

n = limspace(L, L);
figure;
stem(n, fftshift(ifft(xf_128)), 'marker', 'none');
xlabel('Time Delay')
title('ACF Function regenerated from its from IFFT, $M = 128$')
axis tight;

common.set_graph_params

figure;
stem(n, fftshift(ifft(xf_10)), 'marker', 'none');
xlabel('Time Delay')
title('ACF Function regenerated from its IFFT, $M = 10$')
axis tight;

common.set_graph_params

%% Let's try odd numbers out

L = 255;

x_10 = zeros(L, 1);

m = 10;

for i = 1:m
    x_10(i) = r(i-1, m);
    x_10(end-i+1) = r(-i, m);
end

xf_10 = fft(x_10);

figure;

w=limspace(pi, L);

stem(w, fftshift(real(xf_10)))
xlabel('Frequency')
ylabel('Power')
axis tight;
common.set_graph_params
title('DFT of ACF (ie the PSD)')

figure

n = limspace(L, L);
stem(n, fftshift(ifft(xf_10)), 'marker', 'none');
xlabel('ACF Function regenerated from its IFFT')
axis tight;
common.set_graph_params



