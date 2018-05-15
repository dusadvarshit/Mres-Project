%This m file contains the code to analyze the randomly generated models
%with objectively solved cancer models.

%clear all;

%Folder for original cancer cell matfiles
folder_1 = dir(uigetdir()); 

list_models_1 = cell(length(folder_1)-2,1);
%page_rank_1 = cell(length(folder_1)-2,1);
pr1 = cell(length(folder_1)-2,1);


%Folder for random cancer cell matfiles
folder_2 = dir(uigetdir()); 

list_models_2 = cell(length(folder_2)-2,1);
%page_rank_2 = cell(length(folder_2)-2,1);
pr2 = cell(length(folder_2)-2,1);

common = cell(length(folder_2)-2,1);
stat = cell(length(folder_2)-2,1);



for i=3:length(folder_2)
    disp(i-2);
    list_models_1{i-2} = strcat(folder_1(i).folder,'\',folder_1(i).name);
    load(list_models_1{i-2});
    %page_rank_1{i-2} = page_rank;
    thresh = page_rank(find(v==0,1)); %Identifies page_rank of first reaction with zero flux
    pr1 = (find((page_rank)>thresh));
    clear M model model1 page_rank v thresh;
    
    list_models_2{i-2} = strcat(folder_2(i).folder,'\',folder_2(i).name);
    load(list_models_2{i-2});
    %page_rank_2{i-2} = page_rank_random;
    thresh = page_rank_random(find(v_rand==0,1)); %Identifies page_rank of first reaction with zero flux
    pr2 = (find(page_rank_random>thresh));
    clear M_random model model1 page_rank_random v_rand thresh;
    
    common{i-2} = intersect(pr1,pr2);  
    stat{i-2} = [length(pr1) length(pr2) length(intersect(pr1,pr2))];
end
clear i;

