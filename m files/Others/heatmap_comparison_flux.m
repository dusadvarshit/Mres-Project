% Run this m-file to compare all 60 NCI-60 cell lines using their logical
% (flux) vectors. 

clear all;

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
v1 = double(v~=0);
    for j=1:60
        load(all_models{j});
        v2 = double(v~=0);
        angle_matrix(i,j) = (dot(v1,v2))/(norm(v1)*norm(v2));
    end  
    
end

csvwrite("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.05.19\Heatmap comparisons\Aerobic\Heatmap_flux_Anaerobic.csv",angle_matrix);

