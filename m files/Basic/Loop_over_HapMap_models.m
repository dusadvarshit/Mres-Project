clear all;
%initCobraToolbox;
folder = dir('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Supplementary_files\HapMap_models\Mat models');

all_models = cell(224,1);
for i=3:226
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end
changeCobraSolver('glpk','all');
%load(all_models{1});
%model1 = optimizeCbModel(model, 'max');