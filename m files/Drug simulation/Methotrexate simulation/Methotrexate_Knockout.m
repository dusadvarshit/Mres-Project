% Load files from FVA_Lactate
% This is simulation of drug methotrexate and constructing MFG thereafter.
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
    
    % Setting up of constraints
    model1 = model;
    
    model1 = changeRxnBounds(model,model.rxns(941),FVA_max.f,'b'); % Fixing L-Lactate value
    model1 = changeRxnBounds(model,model.rxns(2941),0,'b'); % Knockout of dihydrofolate reductase
    
    model1.lb(3446) = -1; %Very low oxygen
    model1.lb(1372) = -10; %Very high L-glutamine
    model1.lb(968) = -20; %Very high D-Glucose uptake
    
    
    % Optimization of the model.
    model2 = optimizeCbModel(model1,'max');
    v = model2.v;
    
    % Calling the MFG algorithm
    M = MFG_cancer(model1, v); 
    
    %Run the pagerank function
    page_rank = pagerank(M);
    
    % Saving the final results
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today"
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today",'\',folder(i+2).name);
    save(destination_path, 'model', 'model1', 'model2', 'M', 'page_rank', 'v');
end
