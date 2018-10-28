%This m-file will loop over all any cell line models and compute their
%blocked reaction and metabolites in each one of them. Then plot it as a line graph.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end


mass_balance.a = [];
charge_balance.a = [];

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    model = readCbModel(all_models{i});
    %model = importModel(all_models{i}, false);
    
   [massImbalance, imBalancedMass, imBalancedCharge, imBalancedRxnBool, Elements, missingFormulaeBool, balancedMetBool] = checkMassChargeBalance(model);    
    
    model_name = strsplit(folder(i+2).name,'.');
    
    mass_balance.(model_name{1}) = imBalancedMass;
    charge_balance.(model_name{1}) = imBalancedCharge;
    
end