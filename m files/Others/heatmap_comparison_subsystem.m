% Run this m-file to compare all 60 NCI-60 cell lines using their logical
% (flux) vectors. 

%clear all;

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
sub_sys_1 = containers.Map(keyset,zeros(99,1));
for m = 1:3788
    if v1(m) == 1
        sub_sys_1(model.subSystems{m}) = sub_sys_1(model.subSystems{m})+ 1;
    end    
end
subsystem_1 = (cell2mat(sub_sys_1.values))';
subsystem_1_fraction = subsystem_1./valueset;

    for j=1:60
        load(all_models{j});
        v2 = double(v~=0);        
        sub_sys_2 = containers.Map(keyset,zeros(99,1));        
        for n = 1:3788
            if v2(n) == 1
                sub_sys_2(model.subSystems{n}) = sub_sys_2(model.subSystems{n})+ 1;
            end    
        end
        subsystem_2 = (cell2mat(sub_sys_2.values))';
        subsystem_2_fraction = subsystem_2./valueset;
        
        angle_matrix(i,j) = (dot(subsystem_1_fraction,subsystem_2_fraction))/(norm(subsystem_1_fraction)*norm(subsystem_2_fraction));
    end  
    
end

csvwrite("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.05.19\Heatmap comparisons\Aerobic\Heatmap_subsystem_Anaerobic.csv",angle_matrix);

