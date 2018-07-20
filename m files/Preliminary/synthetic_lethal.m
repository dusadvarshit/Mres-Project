% This m-file will loop over all NCI-60 cell line models and compute their
% gene essentiallity in each one of them. Then plot it as a line graph.

folder = dir(uigetdir());


all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

cellname = cell(60,1);
essential_gene = [];

for i=1:length
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    lethal_record = [];
    % Run the biomass optimization
    model1 = model;
    model2 = optimizeCbModel(model1, 'max');
    v_active = find(model2.v~=0);
    v2use = setdiff(v_active,record);
    v_passive = setdiff([1:3788]',record);
    
    for j=1:length(v2use)
        model3 = model1;
        model3.lb(v2use(j)) = 0;
        model3.ub(v2use(j)) = 0;
        for k=1:length(v_passive)
            model4 = model3;
            model4.lb(v_passive(k)) = 0;
            model4.ub(v_passive(k)) = 0;
            
            model5 = optimizeCbModel(model4,'max');
            if model5.v(3745)<0.00001
                lethal_record = [lethal_record;[j,k]];
            end
        end
    end
    
  
    
    model_name = strsplit(folder(i+2).name,'.');
    cellname{i} = model_name{1};
    
end