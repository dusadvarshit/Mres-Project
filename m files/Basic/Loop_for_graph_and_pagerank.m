%i = 1;
for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    % Run the biomass optimization
    model1 = optimizeCbModel(model, 'max');
    
    % Run the biomass optimization with bounds set by computational warbug study
    %temp_model = model;
    %temp_model.lb(3446) = -1;
    %temp_model.lb(968) = -20;
    %temp_model.lb(3446) = -1;
    %temp_model.lb(1372) = -10;
    %model1 = optimizeCbModel(temp_model, 'max');
    
    %Store the flux vector
    v = model1.v;
    
    %Run the MFG_cancer function
    M = MFG_cancer_temp(model, v); 
    
    %Run the pagerank function
    page_rank = pagerank(M);
    %Saving the files
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today"
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today",'\',folder(i+2).name);
    save(destination_path, 'model', 'model1', 'v', 'page_rank', 'M');
    %save(destination_path, 'model', 'model1', 'v');
end
%i = i+1;