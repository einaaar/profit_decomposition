function [theoretical_price_xi_tilde_tminus1] = create_theoretical_price_xi_tilde_tminus1(c,tau,spot_rates,T)
N = size(c,1);
theoretical_price_xi_tilde_tminus1 = zeros(N,1);
sum = 0;
for i = 1:N
    tau_asset = cell2mat(tau(1,i));
    spot_rates_asset = cell2mat(spot_rates(1,i));
    for j = 1:size(c,2)
        if round(tau_asset(j,T)*365) > 0
            sum = sum + c(i,j)*exp(-spot_rates_asset(T,round(tau_asset(j,T)*365))*(tau_asset(j,T)+1/365));
        end
    end
    theoretical_price_xi_tilde_tminus1(i,T) = sum;
    sum = 0; %nollställd
end
end