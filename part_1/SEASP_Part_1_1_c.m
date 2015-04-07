
addpath('../')
common.init

FS = 1000;
N = 100;

sig = sine_gen(24, FS, N);

figure;

stem(linspace(-FS/2, FS/2, 100), abs(fftshift(fft(sig, 100))));
xlabel('Frequency Bin (Hz)');
ylabel('Amplitude');
common.set_graph_params
