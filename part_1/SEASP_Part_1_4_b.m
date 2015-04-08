
addpath('../')
common.init

load('../data/EEG_Data_Assignment1.mat');

N = length(POz);
N_S = N/fs;

SAMP = 5;
high_lim = 60;

w = limspace(fs/2, fs*SAMP);

%% Periodogram for full length of data

full_f = fft(POz, fs*SAMP);

plot(w, mag2db(fftshift(abs(full_f).^2)))
xlim([0 high_lim])

%% FFT for varying sample means

MEANS = [ 10 5 1 ];

for i = 1:length(MEANS)
    n_samps = N_S/MEANS(i);
    input_split = repmat(N/n_samps, [1 n_samps]);
    arrays = mat2cell(POz, input_split);

    output_f_hamming = zeros(fs*SAMP, n_samps);
    output_f_bartlett = zeros(fs*SAMP, n_samps);
    output_f = zeros(fs*SAMP, n_samps);
    
    for j = 1:n_samps
        output_f(:, j) = abs(fft(bartlett(input_split(1)).*arrays{j}, fs*SAMP)).^2;
        output_f_bartlett(:, j) = abs(fft(bartlett(input_split(1)).*arrays{j}, fs*SAMP)).^2;
        output_f_hamming(:, j) = abs(fft(hamming(input_split(1)).*arrays{j}, fs*SAMP)).^2;
    end
    psd_hamming = mag2db(mean(output_f_bartlett, 2));
    psd_bartlett = mag2db(mean(output_f_bartlett, 2));
    psd = mag2db(mean(output_f_bartlett, 2));
    
    figure
    subplot(3, 1, 1)
    plot(w, fftshift(psd));
    title(sprintf('Averaged Periodogram for Window Length %is', MEANS(i)));
    xlim([0 high_lim])    
    
    subplot(3, 1, 2)
    plot(w, fftshift(psd_bartlett));
    title(sprintf('Averaged Periodogram for Window Length %is', MEANS(i)));
    xlim([0 high_lim])
    
    subplot(3, 1, 3)
    plot(w, fftshift(psd_hamming));
    title(sprintf('Averaged Periodogram for Window Length %is', MEANS(i)));
    xlim([0 high_lim])       
    
end



