% Identify number of reactions, metabolites, subsystems in each model

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2)
    all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

% Reaction storage variable
%CL_cancer = zeros(11,3);
%mCADRE_models = zeros(126,3); 
%INIT_cancer = zeros(11,3);
%Nam_model = zeros(18,3);
Prime_model = zeros(60,3);

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    model = readCbModel(all_models{i});
    
    
    % Store reaction numbers
    %CL_cancer(i,1) = length(model.rxns);
    %mCADRE_models(i,1) = length(model.rxns);
    %INIT_cancer(i,1) = length(model.rxns);
    %Nam_model(i,1) = length(model.rxns);
    Prime_model(i,1) = length(model.rxns);
    
    % Store metabolite numbers
    %CL_cancer(i,2) = length(model.mets);
    %mCADRE_models(i,2) = length(model.mets);
    %INIT_cancer(i,2) = length(model.mets);
    %Nam_model(i,2) = length(model.mets);
    Prime_model(i,2) = length(model.mets);
    
    % Store subsystem numbers
    %CL_cancer(i,3) = length(unique(string(model.subSystems)));
    %mCADRE_models(i,3) = length(unique(string(model.subSystems)));
    %INIT_cancer(i,3) = length(unique(string(model.subSystems)));
    %Nam_model(i,3) = length(unique(string(model.subSystems)));
    Prime_model(i,3) = length(unique(string(model.subSystems)));
    
end                           
