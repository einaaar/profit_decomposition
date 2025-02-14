%Get data from excel
[c, tau, currency] = read_from_excel_new();

%Get forwardrate curves by running get_forward_rates.m
if (~exist('forward_rates','var'))
    %forward_rates = create_curve();
    forward_rates = get_forward_rates();
end

%% Run get_PCA_data.m and receive gradient,  hessian and riskfactors and plot for shift, twist and butterfly
for i=1:size(c,1)
    index = find(strcmp(forward_rates(:,1),currency(i)));
    [risk_factors_temp, gradient_temp, hessian_temp, spot_rates_temp,AE_temp] = get_PCA_data(c(i,:)', cell2mat(tau(i)), cell2mat(forward_rates(index,2)));
    risk_factors(i) = {risk_factors_temp};
    gradient(i) = {gradient_temp};
    hessian(i) = {hessian_temp};
    spot_rates(i) = {spot_rates_temp};
    AE(i) = {AE_temp};
end

%% Calculate P(xi_tilde), P_s
T = 1;
%for t=1:T
theoretical_price_xi_tilde = create_theoretical_price_xi_tilde(c,tau,spot_rates,T);
theoretical_price_xi_tilde_tminus1 = create_theoretical_price_xi_tilde_tminus1(c,tau,spot_rates,T);

theoretical_price_s = create_theoretical_price_s(c,tau,spot_rates,T,AE,risk_factors);
%end


