%i = 1;
for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    % No dealing with COBRA toolbox
            
    %Run the PFG_cancer function
    P = PFG_cancer(model); %Though sending model1 seems redundant
    
    %Run the pagerank function
    page_rank = pagerank(P);
    %Saving the files
    
    model_name = strsplit(folder(i+2).name,'.');
    destination_path = strcat(destination_folder,'\', model_name{1},'.mat');
    
    save(destination_path, 'model', 'page_rank', 'P');
    %save(destination_path, 'model', 'model1', 'v');
end
%i = i+1;