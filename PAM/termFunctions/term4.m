function [T4] = term4(s_b, x_b, f)
%TERM4 fourth term of PAM -> vector[nC]
%   s_b = transaction costs per unit of currency bought array[nC]
%   x_b = number of unit bought of each currency array[nC]
%   f = FX-rates array[nC]

T4 = s_b .* x_b .* f;
end

