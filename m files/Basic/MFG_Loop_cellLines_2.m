% This m-file will calculate MFG for NCI-60 cell line
% THIS VERSION DOES NOT DO RANDOM SAMPLING and COMPUTE KNOCKOUT VIA MOMA
% Using Cobra in-built functions preferably for genes

folder = dir(uigetdir());
destination_folder = uigetdir();

% Load the file which contains threshold for oxygen uptake for each cell
% line
load('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.06.13\Warburg effect verification\o2_lactate_threshold.mat')

Methotrexate = {'DHFR'};
Succinate_Dehydrogenase = {'SUCD1m'};
Fumarase = {'FUM';'FUMm'};

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    model = readCbModel(all_models{i});
    
    % Add model.rev term
    model.rev = zeros(length(model.rxns),1);
    for j=1:length(model.rxns)
        if model.ub(j)>0 & model.lb(j)<0
            model.rev(j) =1;
        end
    end
    clear j;
    
    % Set model constraints
    model1 = model;
    
    % When using Yizhak et al. suggested constraints
    model1 = changeRxnBounds(model1,model.rxns(1372),-1,'b'); %L-Glutamine
    model1 = changeRxnBounds(model1,model.rxns(968),-5,'b'); % D-Glucose
    model1 = changeRxnBounds(model1,model.rxns(687),0.005,'b'); %D-Lactate release
    model1 = changeRxnBounds(model1,model.rxns(3446),o2_flux(i),'b'); %O2 uptake
    %model1 = changeRxnBounds(model1,model.rxns(3446),o2_flux(i)/3,'b'); % Anaerobic condition 
        
    % When using Jain et al, suggested experimental values
    %model1 = changeRxnBounds(model1,model.rxns(1372),glutamine(i),'b'); %L-Glutamine
    %model1 = changeRxnBounds(model1,model.rxns(968),glucose(i),'b'); % D-Glucose
    %model1 = changeRxnBounds(model1,model.rxns(941),lactate(i),'b'); %L-Lactate release
    

    % Optimize model for biomass optimization
    %model2 = optimizeCbModel(model1,'max');
    
    % Methotrexate knockout
    %model_Methotrexate = changeRxnBounds(model1,Methotrexate,zeros(length(Methotrexate),1),'b'); 
    %model2 = MOMA(model1, model_Methotrexate, 'max', false,true); %optimizeCbModel(model_Methotrexate,'max');
    
    % Succinate Dehydrogenase knockout
    %model_SDH = changeRxnBounds(model1,Succinate_Dehydrogenase,zeros(length(Succinate_Dehydrogenase),1),'b'); 
    %model2 = MOMA(model1, model_SDH, 'max', false,true); %optimizeCbModel(model_SDH,'max');
    
    % Fumarase knockout
    %model_Fumarase = changeRxnBounds(model1,Fumarase,zeros(length(Fumarase),1),'b'); 
    %model2 = MOMA(model1, model_Fumarase, 'max', false,true); %optimizeCbModel(model_Fumarase,'max');
    
    % Random sampling using Raven toolbox
    % Randomized sampling done no more
    
    %Store the flux vector
    v = model2.x;
    
    %Run the MFG_cancer function
    %M = MFG_cancer_temp(model1, v); % MFG_cancer_temp used because it uses "model.rev = 1" instead of relying on bounds
    M = MFG_cancer_sparse(model1, v); % Using sparse version of MFG to make it faster.
    
    %Run the pagerank function
    page_rank = pagerank(M);
    
    %Saving the files
    model_name = strsplit(folder(i+2).name,'.');
    destination_path = strcat(destination_folder,'\', model_name{1},'.mat');
    
    save(destination_path, 'model', 'model1', 'model2', 'v', 'page_rank', 'M');
    %save(destination_path, 'model', 'model1', 'v');
    clc
end