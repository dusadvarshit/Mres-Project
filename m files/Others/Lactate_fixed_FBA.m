clear all;
changeCobraSolver('glpk', 'all')
%initCobraToolbox;
folder = dir(uigetdir());

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end
clear i;

for i =1:length(all_models)
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    model1 = model;
    model1 = changeRxnBounds(model,model.rxns(941),FVA_max.f,'b');
    model1.lb(3446) = -1; %Very low oxygen
    model1.lb(1372) = -10; %Very high L-glutamine
    model1.lb(968) = -20; %Very high D-Glucose uptake
    
    
    model2 = optimizeCbModel(model1,'max');
    v = model2.v;
    
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today"
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today",'\',folder(i+2).name);
    save(destination_path, 'model', 'model1', 'model2', 'FVA_min', 'FVA_max', 'v');
end
