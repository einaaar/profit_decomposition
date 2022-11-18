function [c,tau,currency] = read_from_excel_new()
% TODO: skapa funktion för att räkna hur många assets vi har
file_name = "Excel_test.xlsx";
sheet_index= ["Inköp och Råvarulager" "Produktion och Färdigvarulager" "Finansiering"];

N = readmatrix(file_name, 'sheet', 'info', 'Range', 'C2:C2');

T_start = readmatrix(file_name, 'sheet', 'Inköp och Råvarulager', 'Range', 'D1:D1');
T_end = readmatrix(file_name, 'sheet', 'Inköp och Råvarulager', 'Range', 'D2:D2');
T_cashflow = zeros(N,2);
currency = strings([N,1]);
c = zeros(N,2);
tau = mat2cell(repmat(zeros(size(c,2),T_end-T_start+1),1,N),size(c,2),repmat(T_end-T_start+1,1,N)); 

index=1;
for i = 1:size(sheet_index,2)
    sheet_name = sheet_index(i);
    Asset_index = 4;
    while true
        %Check if all cash flows have been read
        check_index = strcat('B',int2str(Asset_index));
        check_location = strcat(check_index,':',check_index);
        check_value = readmatrix(file_name, 'sheet', sheet_name, 'Range', check_location);
        if isnan(check_value)
            break
        end
        % Read cash flow
        first_index = strcat('D',int2str(Asset_index));
        second_index = strcat('E',int2str(Asset_index));
        location = strcat(first_index,':',second_index);
        c(index,:) = readmatrix(file_name, 'sheet', sheet_name, 'Range', location);

        % Assign which currency
        currency_index = strcat('B', int2str(Asset_index+1));
        currency_location = strcat(currency_index, ':', currency_index);
        [~,text] = xlsread(file_name, sheet_name, currency_location);
        currency(index,1) = string(text);

        % Read date associated with cash flow
        first_index = strcat('D',int2str(Asset_index+1));
        second_index = strcat('E',int2str(Asset_index+1));
        location = strcat(first_index,':',second_index);
        T_cashflow(index,:) = readmatrix(file_name, 'sheet', sheet_name, 'Range', location);

        %Calculate tau
        tau(1,index) = mat2cell(calculate_tau(c(index,:), T_cashflow(index,:), T_start, T_end), size(c,2),T_end-T_start+1);
        index = index+1;
        Asset_index = Asset_index +2;
    end
end

end