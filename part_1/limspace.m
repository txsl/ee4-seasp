function [ w ] = limspace( R, L )
% LIMSPACE Generate linear spacing for use in FFT plots
%   Inputs:
%    R: Range of desired output. Eg pi. Output would range from -pi to pi
%    L: Length of data. Determines how many results are returned
%
if mod(L, 2) == 0
    w = 2*R*((0:(L-1))/L) - R;
else
    w = linspace(-R, R, L);
%     w = 2*R*((0:(L-1))/L) - R;
end
end

