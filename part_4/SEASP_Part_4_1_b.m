
addpath('../')
common.init

%% Load Data

v = zeros(5000, 3);

load('../data/high-wind.mat')
v(:, 3) = v_north + 1j*v_east;

load('../data/medium-wind.mat')
v(:, 2) = v_north + 1j*v_east;

load('../data/low-wind.mat')
v(:, 1) = v_north + 1j*v_east;

%% Plot Data

titles = {'Low Wind', 'Medium Wind', 'High Wind'};

figure

for i = 1:3

    subplot(1, 3, i)
    scatter(real(v(:, i)), imag(v(:, i)), 'marker', '.');
    title(titles{i});
    xlabel('$ \mathfrak{R} a $');
    ylabel('$ \mathfrak{I} $');
    
    low = min(min(real(v(:, i))), min(imag(v(:, i))));
    high = max(max(real(v(:, i))), max(imag(v(:, i))));
    
    axis([low high low high])

end

%% Let's try modelling it

figure;
hold on;

plots = { 'oy', '+m', '*c', '.r', 'xg', 'sb' };

for w = 1:3
    clms_errs = zeros(20, 1);
    aclms_errs = zeros(20, 1);
    for i = 1:20
        [ ~, ~, error ] = clms(v(:, w), v(:, w), i, 0.01);
        clms_errs(i) = mean(abs(error).^2);
        
        [ ~, ~, ~, ~ ] = aclms(v(:, w), v(:, w), i, 0.01);
        aclms_errs(i) = mean(abs(error).^2);
    end
    plot(clms_errs, plots{w})
    plot(aclms_errs, plots{w+3})
end

legend('CLMS - Low Speed Wind', 'ACLMS - Low Speed Wind', 'CLMS - Med. Speed Wind', 'ACLMS - Med. Speed Wind', 'CLMS - Hi. Speed Wind', 'ACLMS - Hi. Speed Wind');



