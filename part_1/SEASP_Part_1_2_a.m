
addpath('../')
common.init

L = 256;

%% For the case m = 10

x_10 = zeros(L, 1);

m = 10;

for i = 1:m
    x_10(i) = r(i-1, m);
    x_10(end-i+1) = r(-i, m);
end

xf_10 = fft(x_10);


figure;

subplot(2, 1, 1)
plot(0:L-1, x_10)
ylabel('Amplitude')
title('ACF Function for M=10')
xlim([0 L-1])

common.set_graph_params

subplot(2, 1, 2)
stem(limspace(1, L), fftshift(real(xf_10)))
axis tight;
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')

common.set_graph_params

%% For the case m = 128

x_128 = zeros(L, 1);

m = 128;

for i = 1:m
    x_128(i) = r(i-1, m);
    x_128(end-i+1) = r(-i, m);
end

xf_128 = fft(x_128);
figure;

subplot(2, 1, 1)
plot(0:L-1, x_128)
ylabel('Amplitude')
title('ACF Function for M=128')
axis tight;

common.set_graph_params

subplot(2, 1, 2)
stem(limspace(1, L), fftshift(real(xf_128)))
axis tight;
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')

common.set_graph_params
