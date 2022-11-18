
function theoretical_price_xi_tilde = create_theoretical_price_xi_tilde(c,tau,spot_rates,T)

%T = size(cell2mat(tau(1,1)),2);
N = size(c,1);
theoretical_price_xi_tilde = zeros(N,1);
sum = 0;

%for t = 1:T
    for i = 1:N
        tau_asset = cell2mat(tau(1,i));
        spot_rates_asset = cell2mat(spot_rates(1,i));
        for j = 1:size(c,2)
            if round(tau_asset(j,T)*365) > 0
                %spot_rates(t,round(tau(j,t)*365))
                sum = sum + c(i,j)*exp(-spot_rates_asset(T,round(tau_asset(j,T)*365))*tau_asset(j,T));
            end
        end
        theoretical_price_xi_tilde(i,T) = sum;
        sum = 0; %nollställd
    end
%end
end