function tau = calculate_tau(c,T,T_start,T_end)

n_days=datenum(T_end)-datenum(T_start)+1;
tau=zeros(length(c),n_days);

for i=1:length(c)
    for j=1:n_days
        tau(i,j)=(datenum(T(i))-(datenum(T_start)+j-1))/365;
    end
end

end