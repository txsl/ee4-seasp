function [ out ] = mspe( x, x_est )

intermediate = x - x_est;
intermediate = (intermediate.^2)/length(intermediate);
out = sum(intermediate);

end

