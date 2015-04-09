
addpath('../')
common.init

n = 0:30;
noise = 0.2/sqrt(2) * (randn(size(n))+1j * randn(size(n)));
x = exp(1j * 2 * pi * 0.3 * n)+exp(1j * 2 * pi * 0.32 * n)+ noise;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[ ],1,'corr');
plot(F,S,'linewidth',2); set(gca,'xlim',[0.25 0.40]);
grid on; xlabel('Hz'); ylabel('Pseudospectrum');

common.set_graph_params
