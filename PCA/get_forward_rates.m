function [forward_rates] = get_forward_rates()

%forward_rates: antal celler: 2 x antal valutor 
%               varje cell rad 1: Vilket valuta
%               varje cell rad 2: 90ish dagar x 10 år ish

myDir = "C:\Users\eirik\Documents\CDIO\PCA\PCA\3MonthCurves\";
myFiles = dir(fullfile(myDir,'*.mat'));
for k =1:length(myFiles)
    baseFileName = myFiles(k).name;
    currency_temp = erase(baseFileName, ".mat");
    fullFileName = fullfile(myDir, baseFileName);
    forward_rate_temp= load(fullFileName);
    forward_rates(k,:)={currency_temp;forward_rate_temp.f'};
    
end

end