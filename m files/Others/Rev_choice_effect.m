%This mat file will be used to compare the difference in MFG and pagerank
%analysis caused due to different choice of "rev" or "reversibility
%matrix".

% model1 will always be Aerobic analysis done as on 14.03.2018
% model2 will always be only analysis done as on 09.06.2018

%Folder for Aerobic: 14.03.2018 cancer cell matfiles
folder_1 = dir(uigetdir()); 

list_models_1 = cell(length(folder_1)-2,1);

%Folder for 09.06.2018 cancer cell matfiles
folder_2 = dir(uigetdir()); 

list_models_2 = cell(length(folder_2)-2,1);

% Filename for xls file
filename = 'C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today';
filename = strcat(filename,'\','Rev_choice_effects.','xlsm')
xlswrite(filename,{'Cell Line', 'Is Flux Same','Pagerank Similarity','MFG_diff_min','MFG_diff_max','MFG_distance','MFG_distance_elementwise'},'Anaerobic','A1');

% Storage variable for export
similarity = zeros(60,1);
angluar_distance = zeros(60,1);
M_diff_max = zeros(60,1);
M_diff_min = zeros(60,1);
M_dist = zeros(60,1);
M_diff_elementwise_sum = zeros(60,1);
cellLine = cell(60,1);

for i=3:length(folder_2)
    disp(i-2);
    list_models_1{i-2} = strcat(folder_1(i).folder,'\',folder_1(i).name);
    load(list_models_1{i-2});
    
    cellLine{i-2} = folder_1(i).name; %Store cell line name
    
    M1 = M;
    pr1 = page_rank;
    v1 = v;
    clear M model model1 page_rank v;
    
    list_models_2{i-2} = strcat(folder_2(i).folder,'\',folder_2(i).name);
    load(list_models_2{i-2});
    
    M2 = M;
    pr2 = page_rank;
    v2 = v;
    clear M model model1 page_rank v;
    
    % Compare the similarity between pagerank vectors using cosine angle.
    similarity(i-2) = (dot(pr1,pr2))/(norm(pr1)*norm(pr2));
    angluar_distance(i-2) = acosd(similarity(i-2));
    
    % Comparison of MFG by 3 different criteria
    % Range of difference element wise
    M_diff = abs(M1-M2);
    M_diff_unique = unique(M_diff);
    M_diff_max(i-2) = max(M_diff_unique);
    M_diff_min(i-2) = min(M_diff_unique);
    
    % Sum of squares difference
    M_dist(i-2) = (norm(M1,2)-norm(M2,2))^0.5;
    
    % Element wise squared sum of distance
    M_diff_elementwise = (M1-M2).^2;
    M_diff_elementwise_sum(i-2) = sum(M_diff_elementwise(:));
    M_diff_elementwise_sum(i-2) = M_diff_elementwise_sum(i-2)^0.5;
    
    % Compare if flux is same in both cases or not.
    v_check(i-2) = isequal(v1,v2);    
end

xlswrite(filename,cellLine,'Anaerobic','A2');
xlswrite(filename,v_check','Anaerobic','B2');
xlswrite(filename,angluar_distance,'Anaerobic','C2');
xlswrite(filename,M_diff_min,'Anaerobic','D2');
xlswrite(filename,M_diff_max,'Anaerobic','E2');
xlswrite(filename,M_dist,'Anaerobic','F2');
xlswrite(filename,M_diff_elementwise_sum,'Anaerobic','G2');
