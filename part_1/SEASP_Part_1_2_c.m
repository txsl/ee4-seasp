
addpath('../')
common.init

L = 256;

%% For the case m = 10

z_10 = zeros(L, 1);

m = 10;

for i = 1:m
    z_10(i) = r(-m+i-2, m);
    z_10(i+m-1) = r(i-1, m);
end


zf_10 = fft(z_10);


figure;

subplot(2, 1, 1)
plot(0:L-1, z_10)
ylabel('Amplitude')
xlabel('Time Delay')
title('ACF Function for M=10')
xlim([0 L-1])

common.set_graph_params

subplot(2, 1, 2)
stem(limspace(1, L), real(fftshift(zf_10)))
axis tight;
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')


common.set_graph_params


%% For the case m = 128

z_128 = zeros(L, 1);

m = 128;

for i = 1:m
    z_128(i) = r(-m+i-2, m);
    z_128(i+m-1) = r(i-1, m);
end


zf_128 = fft(z_128);


figure;

subplot(2, 1, 1)
plot(0:L-1, z_128)
ylabel('Amplitude')
xlabel('Time Delay')
title('ACF Function for M=128')
xlim([0 L-1])

common.set_graph_params

subplot(2, 1, 2)
stem(limspace(1, L), real(fftshift(zf_128)))
axis tight;
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')


common.set_graph_params