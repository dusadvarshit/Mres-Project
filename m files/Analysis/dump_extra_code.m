%This m-file contain dump codes, parts of codes used for specific,
%transient analysis which if kept will mess with flow of code

%% This is a temp section which will be used to plot different results
top10node = 3;
top50nodes = 27;
top100nodes = 56;
bar([10,50,100],[top10node;top50nodes;top100nodes])
xlabel('Number of top nodes sorted by pagerank')
ylabel('Number of top common nodes');
title('BT-549:Number of top common nodes in 5 different conditions')
ylim([0 100]);
Y = [top10node;top50nodes;top100nodes];
text([10 50 100],Y,num2str(Y),'vert','bottom','horiz','center'); 
box off
%% Identify R^2 for v vs page_rank for all cell lines in all 5 conditions + Real data.
folder = dir(uigetdir());
all_models = cell(length(folder)-2,1);
cellname = cell(length(folder)-2,1);
R = zeros(length(folder)-2,1);

for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
cellLine = strsplit(folder(i).name,'.');
cellname{i-2} = cellLine{1};
end

for i=1:length(all_models)
[page_rank,v2m, M, rxnNameslist, subSystemslist, direction] = relevent_information(all_models{i});
R_1 = corrcoef([v2m(find(v2m~=0)),page_rank(find(v2m~=0))]);
R(i) = R_1(2,1);
end

%b = bar(categorical(cellname),R);

%% When comparing across conditions.
folder_1 = dir(uigetdir());
all_models_1 = cell(length(folder_1)-2,1);
folder_2 = dir(uigetdir());
all_models_2 = cell(length(folder_2)-2,1);
folder_3 = dir(uigetdir());
all_models_3 = cell(length(folder_3)-2,1);
folder_4 = dir(uigetdir());
all_models_4 = cell(length(folder_4)-2,1);
folder_5 = dir(uigetdir());
all_models_5 = cell(length(folder_5)-2,1);

% Integrating real data sets
folder_6 = dir(uigetdir());
all_models_6 = cell(length(folder_6)-2,1);

cellname = cell(length(folder_1)-2,1);
R1 = zeros(length(folder_1)-2,1);
R2 = zeros(length(folder_2)-2,1);
R3 = zeros(length(folder_3)-2,1);
R4 = zeros(length(folder_4)-2,1);
R5 = zeros(length(folder_5)-2,1);

for i=3:(length(all_models_1)+2) 
all_models_1{i-2} = strcat(folder_1(i).folder,'\',folder_1(i).name);
all_models_2{i-2} = strcat(folder_2(i).folder,'\',folder_2(i).name);
all_models_3{i-2} = strcat(folder_3(i).folder,'\',folder_3(i).name);
all_models_4{i-2} = strcat(folder_4(i).folder,'\',folder_4(i).name);
all_models_5{i-2} = strcat(folder_5(i).folder,'\',folder_5(i).name);
all_models_6{i-2} = strcat(folder_6(i).folder,'\',folder_6(i).name);
cellLine = strsplit(folder_1(i).name,'.');
cellname{i-2} = cellLine{1};
end

for i=1:length(all_models_1)
disp(i);

[page_rank_1,v2m_1, M_1, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_1{i});
[page_rank_2,v2m_2, M_2, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_2{i});
[page_rank_3,v2m_3, M_3, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_3{i});
[page_rank_4,v2m_4, M_4, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_4{i});
[page_rank_5,v2m_5, M_5, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_5{i});
[page_rank_6,v2m_6, M_6, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_6{i});

[pr_1,indices_1] = important_reactions(v2m_1,page_rank_1);
[pr_2,indices_2] = important_reactions(v2m_2,page_rank_2);
[pr_3,indices_3] = important_reactions(v2m_3,page_rank_3);
[pr_4,indices_4] = important_reactions(v2m_4,page_rank_4);
[pr_5,indices_5] = important_reactions(v2m_5,page_rank_5);
[pr_6,indices_6] = important_reactions(v2m_6,page_rank_6);

percentile_1 = calculate_percentile(pr_1);
percentile_2 = calculate_percentile(pr_2);
percentile_3 = calculate_percentile(pr_3);
percentile_4 = calculate_percentile(pr_4);
percentile_5 = calculate_percentile(pr_5);
percentile_6 = calculate_percentile(pr_6);

common_reactions_2 = intersect(indices_1,indices_2);
common_reactions_3 = intersect(indices_1,indices_3);
common_reactions_4 = intersect(indices_1,indices_4);
common_reactions_5 = intersect(indices_1,indices_5);
common_reactions_6 = intersect(indices_1,indices_6);

index2use_control = original2common_mapping(indices_1,common_reactions_2);
index2use_condition = original2common_mapping(indices_2,common_reactions_2);
R_1 = corrcoef([percentile_1(index2use_control), percentile_2(index2use_condition)]);
%R_1 = corr([percentile_1(index2use_control), percentile_2(index2use_condition)],'Type','Spearman')
R1(i) = R_1(2,1);

% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_3);
index2use_condition = original2common_mapping(indices_3,common_reactions_3);
R_1 = corrcoef([percentile_1(index2use_control), percentile_3(index2use_condition)]);
%R_1 = corr([percentile_1(index2use_control), percentile_3(index2use_condition)],'Type','Spearman')
R2(i) = R_1(2,1);

% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_4);
index2use_condition = original2common_mapping(indices_4,common_reactions_4);
R_1 = corrcoef([percentile_1(index2use_control), percentile_4(index2use_condition)]);
%R_1 = corr([percentile_1(index2use_control), percentile_4(index2use_condition)],'Type','Spearman')
R3(i) = R_1(2,1);

% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_5);
index2use_condition = original2common_mapping(indices_5,common_reactions_5);
R_1 = corrcoef([percentile_1(index2use_control), percentile_5(index2use_condition)]);
%R_1 = corr([percentile_1(index2use_control), percentile_5(index2use_condition)],'Type','Spearman')
R4(i) = R_1(2,1);

index2use_control = original2common_mapping(indices_1,common_reactions_6);
index2use_condition = original2common_mapping(indices_6,common_reactions_6);
R_1 = corrcoef([percentile_1(index2use_control), percentile_6(index2use_condition)]);
%R_1 = corr([percentile_1(index2use_control), percentile_6(index2use_condition)],'Type','Spearman')
R5(i) = R_1(2,1);

end

%b = bar(categorical(cellname),R);

%% %% When comparing across conditions FLux vs Pagerank
folder_1 = dir(uigetdir());
all_models_1 = cell(length(folder_1)-2,1);
folder_2 = dir(uigetdir());
all_models_2 = cell(length(folder_2)-2,1);
folder_3 = dir(uigetdir());
all_models_3 = cell(length(folder_3)-2,1);
folder_4 = dir(uigetdir());
all_models_4 = cell(length(folder_4)-2,1);
folder_5 = dir(uigetdir());
all_models_5 = cell(length(folder_5)-2,1);

% Integrating real data sets
folder_6 = dir(uigetdir());
all_models_6 = cell(length(folder_6)-2,1);

cellname = cell(length(folder_1)-2,1);
R1 = zeros(length(folder_1)-2,1);
R2 = zeros(length(folder_2)-2,1);
R3 = zeros(length(folder_3)-2,1);
R4 = zeros(length(folder_4)-2,1);
R5 = zeros(length(folder_5)-2,1);
R6 = zeros(length(folder_6)-2,1);

for i=3:(length(all_models_1)+2) 
all_models_1{i-2} = strcat(folder_1(i).folder,'\',folder_1(i).name);
all_models_2{i-2} = strcat(folder_2(i).folder,'\',folder_2(i).name);
all_models_3{i-2} = strcat(folder_3(i).folder,'\',folder_3(i).name);
all_models_4{i-2} = strcat(folder_4(i).folder,'\',folder_4(i).name);
all_models_5{i-2} = strcat(folder_5(i).folder,'\',folder_5(i).name);
all_models_6{i-2} = strcat(folder_6(i).folder,'\',folder_6(i).name);
cellLine = strsplit(folder_1(i).name,'.');
cellname{i-2} = cellLine{1};
end

for i=1:length(all_models_1)
disp(i);

[page_rank_1,v2m_1, M_1, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_1{i});
[page_rank_2,v2m_2, M_2, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_2{i});
[page_rank_3,v2m_3, M_3, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_3{i});
[page_rank_4,v2m_4, M_4, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_4{i});
[page_rank_5,v2m_5, M_5, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_5{i});
[page_rank_6,v2m_6, M_6, rxnNameslist, subSystemslist, direction] = relevent_information(all_models_6{i});

R_1 = corrcoef([v2m_1(find(v2m_1~=0)),page_rank_1(find(v2m_1~=0))]);
R1(i) = R_1(2,1);

R_1 = corrcoef([v2m_2(find(v2m_2~=0)),page_rank_2(find(v2m_2~=0))]);
R2(i) = R_1(2,1);

R_1 = corrcoef([v2m_3(find(v2m_3~=0)),page_rank_3(find(v2m_3~=0))]);
R3(i) = R_1(2,1);

R_1 = corrcoef([v2m_4(find(v2m_4~=0)),page_rank_4(find(v2m_4~=0))]);
R4(i) = R_1(2,1);

R_1 = corrcoef([v2m_5(find(v2m_5~=0)),page_rank_5(find(v2m_5~=0))]);
R5(i) = R_1(2,1);

R_1 = corrcoef([v2m_6(find(v2m_6~=0)),page_rank_6(find(v2m_6~=0))]);
R6(i) = R_1(2,1);

end

%b = bar(categorical(cellname),R);
