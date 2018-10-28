%This m-file will loop over all NCI-60 cell line models and compute their
%blocked reaction and metabolites in each one of them. Then plot it as a line graph.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end


blocked_metabolites.a = [];
blocked_reactions.a = [];

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    model = readCbModel(all_models{i});
    %model = importModel(all_models{i}, false);
    
    deadEndMetabolites = detectDeadEnds(model);
    blockedReactions = findBlockedReaction(model);
    
    model_name = strsplit(folder(i+2).name,'.');
    
    blocked_metabolites.(model_name{1}) = deadEndMetabolites;
    blocked_reactions.(model_name{1}) = blockedReactions;
    
end