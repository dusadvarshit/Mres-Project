% This m-file is just to prove the point for D vs L-lactate

folder = dir(uigetdir());
destination_folder = uigetdir();

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

page_rank = zeros(7576,1);

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    model = readCbModel(all_models{i});
    model.lb(687) = 0.005;
    model.ub(687) = 0.005;
    
    model2 = optimizeCbModel(model,'max');
    v = model2.v;
    
    model_name = strsplit(folder(i+2).name,'.');
    destination_path = strcat(destination_folder,'\', model_name{1},'.mat');
    
    save(destination_path, 'model', 'model2', 'v', 'page_rank');
    
    
end