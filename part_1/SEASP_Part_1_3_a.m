
addpath('../')
common.init

sizes = arrayfun(@(x) 2.^x, 4:12);
window = zeros(length(sizes), 1);
sidelobe_level = zeros(length(sizes), 1);
OVERSAMP = 4;
plots = [ 16 64 128 512 ];

for m =  1:length(sizes)
    %% Generate the window, and take the FFT
    L = sizes(m);

    b = bartlett(L);

    b_f = fft(b, OVERSAMP*L);

    abs_b_f = fftshift(10*log10(eps + abs(b_f)));
    w = limspace(1, OVERSAMP*L);

    
    %% Look for the 3dB point
    [~, i] = max(abs_b_f);

    pk_idx = i;
    pk_val = abs_b_f(i);

    while 1
    cur_v = abs_b_f(i);
        if cur_v <= pk_val - 3
            found_3db = i;
            break
        end
    i = i + 1;
    end
    
    window(m) = 2*pi*(found_3db - pk_idx)/L;

    
    %% Look for the sidelobe peak
    [ sidelobe_dbs , sidelobe_locs ] = findpeaks(abs_b_f(pk_idx:end));
    
    sidelobe_level(m) = pk_val - sidelobe_dbs(1);
    
    %% Plot some examples
    if any(L == plots)
        
        % Combining them on one plot
%         figure;
%         [hAx,hLine1,hLine2] =  plotyy(w, abs_b_f, w, abs(fftshift(b_f)));
%         title(sprintf('Bartlett Window for $N=%i$', L));
%         xlabel('Normalised Frequency');
%         ylabel(hAx(1), 'Magnitude (dB)')
%         ylabel(hAx(2), 'Magnitude (linear)')
%         axis tight;

        figure;
        subplot(2, 1, 1);
        plot(w, abs_b_f)
        title(sprintf('Bartlett Window for $N=%i$', L));
        xlabel('Normalised Frequency')
        ylabel('Magnitude (dB)')
        axis tight
        common.set_graph_params
        
        subplot(2, 1, 2);
        plot(w, fftshift(abs(b_f)))
%         title(sprintf('Bartlett Window for $N=%i$', L));
        xlabel('Normalised Frequency')
        ylabel('Magnitude')
        axis tight
        common.set_graph_params
        
    end
    
end


%% Plots

figure;
plot(sizes, window, sizes, (2*pi)./sizes)
xlabel('N')
ylabel('3dB Width (Radians)')
title('3dB Width \& Window Length')
legend('Measured Result', '\frac{1}{N}');
axis tight;
common.set_graph_params

figure;
plot(sizes, sidelobe_level)
title('Sidelobe Level \& Window Length');
xlabel('N')
ylabel('Sidelobe Level (dB)')
axis tight;
common.set_graph_params



