
addpath('../')
common.init

L = 256;

%% For the case m = 10

z_10 = zeros(L, 1);

m = 10;

for i = 1:m
    disp(i)
    disp(-m+i-2)
    disp(i+m-1)
    disp(i-1)
%     disp(r(-i-1, m)m)
%     disp(i+m-1)
    z_10(i) = r(-m+i-2, m);
    z_10(i+m-1) = r(i-1, m);
%     z(end-i+1) = r(-i, m);
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
stem(0:L-1, abs(zf_10))
xlim([0 L-1])
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')


common.set_graph_params


%% For the case m = 128

z_10 = zeros(L, 1);

m = 128;

for i = 1:m
    disp(i)
    disp(-m+i-2)
    disp(i+m-1)
    disp(i-1)
%     disp(r(-i-1, m)m)
%     disp(i+m-1)
    z_10(i) = r(-m+i-2, m);
    z_10(i+m-1) = r(i-1, m);
%     z(end-i+1) = r(-i, m);
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
stem(0:L-1, abs(zf_10))
xlim([0 L-1])
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')


common.set_graph_params