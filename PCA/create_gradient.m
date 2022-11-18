function gradient = create_gradient(c,tau,AE,spot_rates)
gradient = zeros(size(tau,2),size(AE,2));
sum = zeros(1,size(AE,2));
    for i=1:size(tau,2)
        for j=1:size(c)
            if round(tau(j,i)*365)>0
                 sum = sum + -AE(round(tau(j,i)*365),:)*tau(j,i)*c(j)*exp(-(spot_rates(i,round(tau(j,i)*365))*tau(j,i)));
            end
        end
        gradient(i,:) = sum;
        sum = zeros(1,size(AE,2));
    end
end