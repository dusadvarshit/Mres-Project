%This m-file will be used to convert all the cell array elements in GSMMs
%converted from SBML format to string array elements which can be used more
%efficiently.
folder_1 = dir(uigetdir());
folder_2 = uigetdir();
list_models_1 = cell(length(folder_1)-2,1);

for i=3:length(folder_1)
% Loading the files
disp(i-2);
list_models_1{i-2} = strcat(folder_1(i).folder,'\',folder_1(i).name);
load(list_models_1{i-2});

% Making string conversions from cell type
model.mets = string(model.mets);
model.rxns = string(model.rxns);
model.genes = string(model.genes);
model.rules = string(model.rules);
model.compNames = string(model.compNames);
model.comps = string(model.comps);
model.metFormulas = string(model.metFormulas);
model.metNames = string(model.metNames);
%model.metSBOTerms = string(model.metSBOTerms); % Not for all cell lines
model.rxnNames = string(model.rxnNames);
% model.rxnSBOTerms = string(model.rxnSBOTerms); % Not for all cell lines

% Saving the files
model_name = strsplit(folder_1(i).name,'.');
destination_path = strcat(folder_2,'\', model_name{1},'.mat');
disp(strcat('Saving file: ',model_name{1},'.mat'));
save(destination_path, 'model');
end
