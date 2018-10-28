% This m-file will process on already loaded .mat file and not load any new
% files. Here, the number of mass and charge unbalanced reactions will be
% calculated.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2)
   all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

unbalanced_subsystem.a = [];

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(string(all_models{i}));
    
    model_name = strsplit(folder(i+2).name,'.');
    
    % Store lower bound unique count 
    %CL_cancer(i,1)= length(unique(model.lb));
    %mCADRE_models(i,1) = length(unique(model.lb));
    %INIT_cancer(i,1) = length(unique(model.lb));
    %Nam_model(i,1) = length(unique(model.lb));
    Prime_model(i,1) = length(unique(model.lb));
    
    % Store charge unbalanced reaction numbers
    %CL_cancer(i,2)= length(unique(model.ub));
    %mCADRE_models(i,2) = length(unique(model.ub));
    %INIT_cancer(i,2) = length(unique(model.ub));
    %Nam_model(i,2) = length(unique(model.ub));
    Prime_model(i,2) = length(unique(model.ub));
    
    % Identify the subsystem
    %unbalanced_subsystem.(model_name{1}) = string(model.subSystems(find(~strcmp(mass_balance.(model_name{1}),''))));    
    
end