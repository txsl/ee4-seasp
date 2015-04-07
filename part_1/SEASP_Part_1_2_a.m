
addpath('../')
common.init

L = 256;

%% For the case m = 10

x = zeros(L, 1);

m = 10;

% for i = 1:length(x)/2
%     if i <= m - 1 
%         x(i) = (m - i)/m;
%     end
% end
% 
% x((end/2)+1:end) = flipud(x(1:(end/2)));

for i = 1:m
    x(i) = r(i-1, m);
    x(end-i+1) = r(-i,m );
%     disp(i)
%     disp(end-i+1)
%     x(i) = (m - i)/m;
%     x(end-i+1) = x(i);
end

xf = fft(x);


figure;

subplot(2, 1, 1)
plot(0:L-1, x)
ylabel('Amplitude')
xlabel('Time Delay')
title('ACF Function for M=10')
xlim([0 L-1])

common.set_graph_params

subplot(2, 1, 2)
stem(0:L-1, abs(xf))
xlim([0 L-1])
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')


common.set_graph_params

%% For the case m = 128

x = zeros(L, 1);

m = 128;

for i = 1:m
    x(i) = r(i-1, m);
    x(end-i+1) = r(-i,m );
%     disp(i)
%     disp(end-i+1)
%     x(i) = (m - i)/m;
%     x(end-i+1) = x(i);
end

% x((end/2):end) = flipud(x(1:(end/2)-1));


% for i = 1:length(x)/2
%     if i <= m - 1 
%         x(i) = (m - i)/m;
%     end
% end
% 
% x((end/2)+1:end) = flipud(x(1:(end/2)));


xf = fft(x);

figure;

subplot(2, 1, 1)
plot(0:L-1, x)
ylabel('Amplitude')
xlabel('Time Delay')
title('ACF Function for M=128')
xlim([0 L-1])

common.set_graph_params

subplot(2, 1, 2)
stem(0:L-1, abs(xf))
xlim([0 L-1])
xlabel('Normalised Frequency')
ylabel('Power')
title('DFT of ACF (ie the PSD)')

common.set_graph_params
