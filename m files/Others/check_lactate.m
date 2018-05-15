%This m file checks over all cancer cell lines, which produces D-lactate or
%L-lactate and under which condition.

clear all;
folder_exl = dir(uigetdir());

list_models = cell(length(folder_exl)-2,1);
cell_line = cell(length(folder_exl)-2,1);
v_D_lactate = cell(length(folder_exl)-2,1);
v_L_lactate = cell(length(folder_exl)-2,1);
page_rank_D_lactate = cell(length(folder_exl)-2,1);
page_rank_L_lactate = cell(length(folder_exl)-2,1);

for i=3:length(folder_exl)
    list_models{i-2} = strcat(folder_exl(i).folder,'\',folder_exl(i).name);
    cell_line{i-2} =  folder_exl(i).name;
end

filename = 'C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today\Check Lactate.xlsm';
xlswrite(filename,{'Cell Line','v_D_lactate','v_L_lactate','page_rank_D_lactate','page_rank_L_lactate'},'Anaerobic','A1');

for k=1:length(folder_exl)-2
    %Load the models.
    disp(k);
    disp(list_models{k});
    load(list_models{k});
    v_D_lactate{k} = v(687);
    page_rank_D_lactate{k} = page_rank(687);
    v_L_lactate{k} = v(941);
    page_rank_L_lactate{k} = page_rank(941);
end
xlswrite(filename,cell_line,'Anaerobic','A2');
xlswrite(filename,v_D_lactate,'Anaerobic','B2');
xlswrite(filename,v_L_lactate,'Anaerobic','C2');
xlswrite(filename,page_rank_D_lactate,'Anaerobic','D2');
xlswrite(filename,page_rank_L_lactate,'Anaerobic','E2');
