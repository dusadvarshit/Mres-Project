% This is a file to randomize the "EKVX" model by averaging the flux when in both
% the aerobic and anaerobic condition.

%i = 1;
clear all;

for i = 1:100
    %Load the models.
    disp(strcat('Aerobic_',num2str(i)));
    load('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\14.03.2018\Aerobic\NCI60\Mat files\EKVX.mat');
    
    % No optimization required, model already optimized once
    %model1 = optimizeCbModel(model, 'max');
    
    % Run the biomass optimization with no oxygen uptake (set lb = 0)
    %temp_model = model;
    %temp_model.lb(3446) = 0;
    %model1 = optimizeCbModel(temp_model, 'max');
    
    %Store the flux vector
    %v = model1.v;%
    
    % Randomize the flux!
    v_avg = 0;
    v_rand = v(randperm(length(v)));
    
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
    M_random = MFG_cancer(model, model1, v_rand); %Though sending model1 seems redundant
    
    %Run the pagerank function
    page_rank_random = pagerank(M_random);
    %Saving the files
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\18.03.2018\Aerobic\EKVX\Mat files"
    destination_path = strcat(destination_path,'\',num2str(i),'.mat');
    save(destination_path, 'model', 'model1', 'v_rand', 'page_rank_random', 'M_random');
    %save(destination_path, 'model', 'model1', 'v_rand');
end
%i = i+1;

%Anaerobic randomization
for i = 1:100
    %Load the models.
    disp(strcat('Anaerobic_',num2str(i)));
    load('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\14.03.2018\Anaerobic\NCI60\Mat files\EKVX.mat');
    
    % No optimization required, model already optimized once
    %model1 = optimizeCbModel(model, 'max');
    
    % Run the biomass optimization with no oxygen uptake (set lb = 0)
    %temp_model = model;
    %temp_model.lb(3446) = 0;
    %model1 = optimizeCbModel(temp_model, 'max');
    
    %Store the flux vector
    %v = model1.v;%
    
    % Randomize the flux!
    v_avg = 0;
    v_rand = v(randperm(length(v)));
    
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
    M_random = MFG_cancer(model, model1, v_rand); %Though sending model1 seems redundant
    
    %Run the pagerank function
    page_rank_random = pagerank(M_random);
    %Saving the files
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\18.03.2018\Anaerobic\EKVX\Mat files"
    destination_path = strcat(destination_path,'\',num2str(i),'.mat');
    save(destination_path, 'model', 'model1', 'v_rand', 'page_rank_random', 'M_random');
    %save(destination_path, 'model', 'model1', 'v_rand');
end