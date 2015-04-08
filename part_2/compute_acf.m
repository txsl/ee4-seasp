function [ unbiased, biased ] = compute_acf ( x )

biased = xcorr(x, 'biased');
unbiased = xcorr(x, 'unbiased');


end

