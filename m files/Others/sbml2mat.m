%Convert sbml model to mat model

folder_1 = dir(uigetdir());
folder_2 = uigetdir();
list_models_1 = cell(length(folder_1)-2,1);

for i=3:length(folder_1)
disp(i-2);
list_models_1{i-2} = strcat(folder_1(i).folder,'\',folder_1(i).name);
model = readCbModel(list_models_1{i-2});
model_name = strsplit(folder_1(i).name,'.');
destination_path = strcat(folder_2,'\', model_name{1},'.mat');
save(destination_path, 'model');
end