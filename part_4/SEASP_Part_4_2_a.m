
addpath('../')
common.init

VAR = 0.05;
FS = 500;

f = zeros(1500, 1);

f(1:500) = 100;
f(501:1000) = 100 + ((501:1000)-500)/2;
f(1001:1500) = 100 + (((1001:1500)-1000)/25).^2;

y = exp(1j*(f*2*pi/FS)) + sqrt(VAR)*randn(1500, 1) + 1j*sqrt(VAR)*randn(1500, 1);

ary = aryule(y, 1);

[h, w] = freqz(1, ary, 1500);


h_y = fftshift(abs(fft(y, 3000)).^2);

addpath('../part_1');
w_y = limspace(pi, 3000);

figure;
plot(w, mag2db(abs(h).^2), w_y(1501:end), mag2db(h_y(1501:end)))
axis tight
xlabel('Frequency $rads^{-1}$');
ylabel('Power (dB)');
common.set_graph_params