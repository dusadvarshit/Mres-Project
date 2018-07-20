clear all;
%initCobraToolbox;
folder = dir(uigetdir());
destination_folder = uigetdir();

all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

%changeCobraSolver('glpk','all');
%load(all_models{1});
%model1 = optimizeCbModel(model, 'max');