% This m-file will process on already loaded .mat file and not load any new
% files. Here, the number of dead metabolites and reactions will be
% calculated.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2)
   all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(string(all_models{i}));
    
    model_name = strsplit(folder(i+2).name,'.');
    
    % Store reaction numbers
    %dead_CL_cancer(i,1) = length(blocked_reactions.(model_name{1}));
    %dead_mCADRE_models(i,1) = length(blocked_reactions.(model_name{1}));
    %dead_INIT_cancer(i,1) = length(blocked_reactions.(model_name{1}));
    %dead_Nam_model(i,1) = length(blocked_reactions.(model_name{1}));
    dead_Prime_model(i,1) = length(blockedReactions);
    
    % Store metabolite numbers
    %dead_CL_cancer(i,2) = length(blocked_metabolites.(model_name{1}));
    %dead_mCADRE_models(i,2) = length(blocked_metabolites.(model_name{1}));
    %dead_INIT_cancer(i,2) = length(blocked_metabolites.(model_name{1}));
    %dead_Nam_model(i,2) = length(blocked_metabolites.(model_name{1}));
    dead_Prime_model(i,2) = length(deadEndMetabolites);
    
    % Identify active reactions
    active_rxns = setdiff(model.rxns, (blocked_reactions.(model_name{1}))')); %blockedReactions'; 

    % Make a function call to get subsystems of only active reactions
    active_subsystem = get_rxn_subsystem(model,active_rxns);
    
    % Store subsystem numbers
    %dead_CL_cancer(i,3) = length(unique(string(active_subsystem)));
    %dead_mCADRE_models(i,3) = length(unique(string(active_subsystem)));
    %dead_INIT_cancer(i,3) = length(unique(string(active_subsystem)));
    %dead_Nam_model(i,3) = length(unique(string(active_subsystem)));
    dead_Prime_model(i,3) = length(unique(string(active_subsystem)));
    
end