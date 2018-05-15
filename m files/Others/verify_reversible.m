% Verification of my reversible vector with that of original papers.
clear all

% Making the check variable to store logical true or false result
check = zeros(60,1);

% Reading the folders containing the individual mat files.
folder1 = dir('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Supplementary_files\Supplementary_b\NCI60_Warburg_models');
folder2 = dir('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Supplementary_files\NCI60_models\NCI60_Mat_models');

% Creating variables for storing original mat models and SBML derived mat
% models
original_models = cell(60,1);
developed_models = cell(60,1);

%Storing path names for all the models.
for i=3:62
 original_models{i-2} = strcat(folder1(i).folder,'\',folder1(i).name);
 developed_models{i-2} = strcat(folder2(i).folder,'\',folder2(i).name);
end

%Comparing the models for their "rev" variable or reversibility vector.
for j = 1:60
    model1 = load(original_models{j});
    model2 = load(developed_models{j});
    % Check Indexes having values = 1, are the indexes where the model has
    % same rev vector.
    check(j) = isequal(model1.model.rev,model2.model.rev);
end
