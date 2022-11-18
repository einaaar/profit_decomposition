function [theoretical_price_s] = create_theoretical_price_s(c,tau,spot_rates,T,AE,riskfactors)
N = size(c,1);
theoretical_price_s = zeros(N,1);
sum = 0;

for i=1:N
    tau_asset = cell2mat(tau(1,i));
    spot_rates_asset = cell2mat(spot_rates(1,i));
    AE_asset = cell2mat(AE(1,i));
    riskfactors_asset = cell2mat(riskfactors(1,i));
    for j = 1:size(c,2)
        if round(tau_asset(j,T)*365) > 0
            sum = sum + c(i,j)*exp(-spot_rates_asset(T,round(tau_asset(j,T)*365))+AE_asset(round(tau_asset(j,T)*365),:)*riskfactors_asset(:,T));
        end
        theoretical_price_s(i,T) = sum;
        sum = 0; %nollställd
    end

end
    

end