function [ r ] = r(k, m )
%r - generates triangle wave
if abs(k) <= (m-1)
    r = (m - abs(k))/m;
else
    r = 0;
end

end

