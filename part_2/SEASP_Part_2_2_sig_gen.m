function [ x ] = SEASP_Part_2_2_sig_gen ( N )

% Generate signal
x = filter(1, [ 1 -2.76 +3.81 -2.65 +0.92 ],  randn(N, 1));

% Remove transients from the start
x = x(500:end);

end

