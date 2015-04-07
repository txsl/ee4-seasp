function [ sig ] = sine_gen( freq, fs, n )

sig = sin(2*pi*freq*(0:(n-1))/fs);

end

