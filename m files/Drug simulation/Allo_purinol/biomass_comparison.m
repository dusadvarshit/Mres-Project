%This m files compare the result of biomass from allopurinol knockdown
%simulation and without it.

folder_noDrug = dir(uigetdir());

all_models_noDrug = cell(60,1);
for i=3:62  
all_models_noDrug{i-2} = strcat(folder_noDrug(i).folder,'\',folder_noDrug(i).name);
end

% However, here metho is symbolic of drug and refers to drug allopurinol
folder_metho = dir(uigetdir());

all_models_metho = cell(60,1);
for i=3:62  
all_models_metho{i-2} = strcat(folder_metho(i).folder,'\',folder_metho(i).name);
end

v_noDrug = zeros(60,1);
v_metho = zeros(60,1);
v_comparison = zeros(60,1);
cellLine = cell(60,1);

for i=1:length(all_models_metho)
    disp(i);
    disp(all_models_noDrug{i});
    load(all_models_noDrug{i});
    v_noDrug(i)   = v(3745);
    clear v
    
    disp(i);
    disp(all_models_metho{i});
    load(all_models_metho{i});
    v_metho(i)   = v(3745);
    
    v_comparison(i) = v_noDrug(i)/v_metho(i);
    
    cellLine{i} = folder_metho(i+2).name;
    
end

destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today"
filename = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today",'\','Biomass_Comparison','.xlsm');

xlswrite(filename,{'CellLine','NoDrug','Allopurinol','Fold change'},'Comparison','A1');
xlswrite(filename,cellLine,'Comparison','A2');
xlswrite(filename,v_noDrug,'Comparison','B2');
xlswrite(filename,v_metho,'Comparison','C2');
xlswrite(filename,v_comparison,'Comparison','D2');

