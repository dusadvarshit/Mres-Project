% This is a file to randomize the models by averaging the flux when in both
% the aerobic and anaerobic condition.

%i = 1;
for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    model.S = full(randomize_S(full(model.S))); %Randomizing the stoichiometric matrix
    
    % No optimization required, model already optimized once
    model1 = optimizeCbModel(model, 'max');
    
    % Run the biomass optimization with no oxygen uptake (set lb = 0)
    %temp_model = model;
    %temp_model.lb(3446) = 0;
    %model1 = optimizeCbModel(temp_model, 'max');
    
    %Store the flux vector
    v_rand = model1.v;%
    
    % Randomize the flux!
    %v_avg = 0;
    %v_rand = v(randperm(length(v)));
    
    %for x = 1:10000
    %    v_rand = abs(v(randperm(length(v))));
    %    v_avg = (v_avg+v_rand);
    %end
    %v_avg = (v_avg+v_rand)/10000;
    % Assign flux sign at random
    %sign_vector = randi(2,3788,1);
    %sign_vector(find(sign_vector==2))=-1;
    
    %v_avg = v_avg.*sign_vector;
    
    %Run the MFG_cancer function
    M_random = MFG_cancer(model, v_rand); %Though sending model1 seems redundant
    
    %Run the pagerank function
    page_rank_random = pagerank(M_random);
    %Saving the files
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today"
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today",'\',folder(i+2).name);
    save(destination_path, 'model', 'model1', 'v_rand', 'page_rank_random', 'M_random');
    %save(destination_path, 'model', 'model1', 'v_rand');
end
%i = i+1;