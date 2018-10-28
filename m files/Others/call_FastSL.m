folder = dir(uigetdir());

% Load the file which contains threshold for oxygen uptake for each cell
% line
load('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.06.13\Warburg effect verification\o2_lactate_threshold.mat')

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

%for i=1:5%length(all_models)
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
    
    fastSL(model1,0.01,2);
    
end