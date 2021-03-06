% This m-file will loop over all NCI-60 cell line models and compute their
% gene essentiallity in each one of them. Then plot it as a line graph.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

cellname = cell(60,1);
essential_gene = [];

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    model = readCbModel(all_models{i});
    record = zeros(3788,1);    
    
    % Identify unblocked reactions
    unblocked = setdiff(string(model.rxns),string(blockedReactions));
    
    % Run the biomass optimization
    for j=1:length(unblocked)
        model1 = model;
        %model1.lb(j) = 0; --> Poor method to change bounds
        %model1.ub(j) = 0; --> Poor method to change bounds
        model1 = changeRxnBounds(model1, unblocked(j), 0, 'b');
        
        model2 = optimizeCbModel(model1, 'max');
        if model2.v(3745)<0.00001
            record(j) = 1;
        end
    end
    essential_gene = [essential_gene;[find(record==1)]']; 
    
    model_name = strsplit(folder(i+2).name,'.');
    cellname{i} = model_name{1};
    
end