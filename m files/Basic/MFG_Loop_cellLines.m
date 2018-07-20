% This m-file will calculate MFG for NCI-60 cell lines

folder = dir(uigetdir());
destination_folder = uigetdir();

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
    load(all_models{i});
    
    % Set model constraints
    model1 = model;
    
    % When using Yizhak et al. suggested constraints
    %model1 = changeRxnBounds(model1,model.rxns(1372),-1,'b'); %L-Glutamine
    %model1 = changeRxnBounds(model1,model.rxns(968),-5,'b'); % D-Glucose
    %model1 = changeRxnBounds(model1,model.rxns(687),0.05,'b'); %D-Lactate release
    
    % When using Jain et al, suggested experimental values
    model1 = changeRxnBounds(model1,model.rxns(1372),glutamine(i),'b'); %L-Glutamine
    model1 = changeRxnBounds(model1,model.rxns(968),glucose(i),'b'); % D-Glucose
    model1 = changeRxnBounds(model1,model.rxns(941),lactate(i),'b'); %L-Lactate release
    

    % Optimize model for biomass optimization
    model2 = optimizeCbModel(model1,'max');
    
    % Methotrexate knockout
    %model_Methotrexate = changeRxnBounds(model1,Methotrexate,zeros(length(Methotrexate),1),'b'); 
    %model2 = optimizeCbModel(model_Methotrexate,'max');
    
    % Succinate Dehydrogenase knockout
    %model_SDH = changeRxnBounds(model1,Succinate_Dehydrogenase,zeros(length(Succinate_Dehydrogenase),1),'b'); 
    %model2 = optimizeCbModel(model_SDH,'max');
    
    % Fumarase knockout
    %model_Fumarase = changeRxnBounds(model1,Fumarase,zeros(length(Fumarase),1),'b'); 
    %model2 = optimizeCbModel(model_Fumarase,'max');
    
    %Store the flux vector
    
    v = model2.v;
    
    %Run the MFG_cancer function
    M = MFG_cancer_temp(model1, v); 
    
    %Run the pagerank function
    page_rank = pagerank(M);
    
    %Saving the files
    model_name = strsplit(folder(i+2).name,'.');
    destination_path = strcat(destination_folder,'\', model_name{1},'.mat');
    
    save(destination_path, 'model', 'model1', 'model2','v', 'page_rank', 'M');
    %save(destination_path, 'model', 'model1', 'v');
end