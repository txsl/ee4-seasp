
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

