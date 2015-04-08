
addpath('../')
common.init

N_SAMP = 4096;
N = 31;
w = limspace(1, N_SAMP);

Ns = [ 31 40 80 100];

%% Testing various sizes of N

figure;
for i = 1:length(Ns)

    % From the coursework handout
    n = 0:Ns(i)-1;
    noise = 0.2/sqrt(2) * (randn(size(n))+1j * randn(size(n)));
    x = exp(1j * 2 * pi * 0.3 * n)+exp(1j * 2 * pi * 0.32 * n)+ noise;

    subplot(1, 4, i)
    plot(w, mag2db(fftshift(abs(fft(x, N_SAMP)).^2)))
    xlim([0 1])
    xlabel('Normalised Frequency')
    ylabel('Power (dB)')
    title(sprintf('N=%i', Ns(i)))
    common.set_graph_params
    
end

%% Testing frequencies

Fs = [ 0.32 0.34 0.36 0.38 ];

figure;
for i = 1:length(Fs)
    
    % From the coursework handout
    n = 0:N-1;
    noise = 0.2/sqrt(2) * (randn(size(n))+1j * randn(size(n)));
    x = exp(1j * 2 * pi * 0.3 * n)+exp(1j * 2 * pi * Fs(i) * n)+ noise;

    subplot(1, 4, i)
    plot(w, mag2db(fftshift(abs(fft(x, N_SAMP)).^2)))
    xlim([0 1])
    xlabel('Normalised Frequency')
    ylabel('Power (dB)')
    title(sprintf('Frequency=%.2f', Fs(i)))
    common.set_graph_params
    
end

