
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
    title(sprintf('Circularity Plot: %s', titles{i}));
    xlabel('$ \mathfrak{R}{v[n]} $');
    ylabel('$ \mathfrak{I}{v[n]} $');
    
    low = min(min(real(v(:, i))), min(imag(v(:, i))));
    high = max(max(real(v(:, i))), max(imag(v(:, i))));
    
    axis([low high low high])

end

%% Let's try modelling it

figure;

plots = { 'or', '+b' };

ORDER_TOP = 30;

for w = 1:3
    
    clms_errs = zeros(ORDER_TOP, 1);
    aclms_errs = zeros(ORDER_TOP, 1);
    
    for i = 1:ORDER_TOP
        [ ~, ~, error ] = clms(v(:, w), v(:, w), i, 0.01);
        clms_errs(i) = 10*log10(mean(abs(error).^2));
        
        [ ~, ~, ~, error ] = aclms(v(:, w), v(:, w), i, 0.01);
        aclms_errs(i) = 10*log10(mean(abs(error).^2));
    end
    
    subplot(1, 3, w)
    hold on;
    
    plot(clms_errs, plots{1})
    plot(aclms_errs, plots{2})
    
    xlabel('Model Order')
    ylabel('Mean Squared Error (dB)')
    title(sprintf('Prediction Error: %s', titles{w}));
    legend('CLMS Model', 'ACLMS Model');
    
    common.set_graph_params
end



