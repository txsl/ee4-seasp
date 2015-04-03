function [ out ] = mspe( x, x_est )

out = x - x_est;
out = (out.^2)/length(out);

end

