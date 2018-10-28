% This m-file will loop over all NCI-60 cell line models and compute their
% Synthetic lethalitys in each one of them. Then plot it as a line graph.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end


for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    fastSL(model1);
end