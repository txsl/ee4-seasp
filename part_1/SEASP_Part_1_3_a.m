
addpath('../')
common.init

sizes = arrayfun(@(x) 2.^x, 4:12);
wind = zeros(length(sizes), 1);

for m =  1:length(sizes)

    L = sizes(m);

    b = bartlett(L);

    b_f = fft(b, 4*L);

    abs_b_f = fftshift(10*log10(eps + abs(b_f)));
    w = limspace(L, L);

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

    disp(1/L)
    wind(m) = 2*pi*(found_3db - pk_idx)/L;

end

plot(sizes, wind, sizes, (2*pi)./sizes)

% plot(w, abs_b_f);


