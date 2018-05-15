clear all;
%initCobraToolbox;
folder = dir(uigetdir());

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end
clear i;

similarity = zeros(60,60);

for i=1:length(all_models)
    %Load the models.
    disp(i);
    %disp(all_models{i});
    load(all_models{i});
    P_1 = P;
    clear P;
    for j = 1:length(all_models)
        load(all_models{i});
        P_2 = P;
        similarity(i,j) = isequal(P_1,P_2);
    end
end
disp(similarity)