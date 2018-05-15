clear all;
%initCobraToolbox;
folder = dir(uigetdir());

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end
changeCobraSolver('glpk','all');
%load(all_models{1});
%model1 = optimizeCbModel(model, 'max');