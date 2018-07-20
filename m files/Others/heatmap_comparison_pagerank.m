% Run this m-file to compare all 60 NCI-60 cell lines using their logical
% (flux) vectors. 

%clear all;
% Aerobic, Anaerobic: 14.03.2018

folder = dir(uigetdir());

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

angle_matrix = zeros(60,60);

                                 
for i=1:60%length(all_models)
disp(i);
disp(all_models{i});
load(all_models{i});
%v1 = double(v~=0);
page_rank_1 = page_rank;
    for j=1:60
        load(all_models{j});      
        page_rank_2 = page_rank;
        angle_matrix(i,j) = (dot(page_rank_1,page_rank_2))/(norm(page_rank_1)*norm(page_rank_2));
    end  
    
end

csvwrite("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.06.14\MFG_FHKnockout\Heatmaps\Heatmap_pagerank.csv",angle_matrix);

