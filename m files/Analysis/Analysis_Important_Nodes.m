% This m-file is for general evaluation for all the important reactions.

% File 1
[filename,pathname] = uigetfile();
file_1 = strcat(pathname,filename);

% File 2
[filename,pathname] = uigetfile();
file_2 = strcat(pathname,filename);

% File 3
[filename,pathname] = uigetfile();
file_3 = strcat(pathname,filename);

% File 4
[filename,pathname] = uigetfile();
file_4 = strcat(pathname,filename);

% File 5
[filename,pathname] = uigetfile();
file_5 = strcat(pathname,filename);

% File 6
[filename,pathname] = uigetfile();
file_6 = strcat(pathname,filename);

%% Load all the files and extract necessary variables
[page_rank_1,v2m_1, M_1, rxnNameslist, subSystemslist, direction] = relevent_information(file_1);
[page_rank_2,v2m_2, M_2, rxnNameslist, subSystemslist, direction] = relevent_information(file_2);
[page_rank_3,v2m_3, M_3, rxnNameslist, subSystemslist, direction] = relevent_information(file_3);
[page_rank_4,v2m_4, M_4, rxnNameslist, subSystemslist, direction] = relevent_information(file_4);
[page_rank_5,v2m_5, M_5, rxnNameslist, subSystemslist, direction] = relevent_information(file_5);
[page_rank_6,v2m_6, M_6, rxnNameslist, subSystemslist, direction] = relevent_information(file_6);

%% Analyzing the subsystem information
subSystem_frequency_1 = subSystem_count(page_rank_1,subSystemslist);
subSystem_frequency_2 = subSystem_count(page_rank_2,subSystemslist);
subSystem_frequency_3 = subSystem_count(page_rank_3,subSystemslist);
subSystem_frequency_4 = subSystem_count(page_rank_4,subSystemslist);
subSystem_frequency_5 = subSystem_count(page_rank_5,subSystemslist);
subSystem_frequency_6 = subSystem_count(page_rank_6,subSystemslist);

%% Subsystem level pagerank information
subSystem_pr_1 = subSystem_pagerank(page_rank_1,subSystemslist);
subSystem_pr_2 = subSystem_pagerank(page_rank_2,subSystemslist);
subSystem_pr_3 = subSystem_pagerank(page_rank_3,subSystemslist);
subSystem_pr_4 = subSystem_pagerank(page_rank_4,subSystemslist);
subSystem_pr_5 = subSystem_pagerank(page_rank_5,subSystemslist);
subSystem_pr_6 = subSystem_pagerank(page_rank_6,subSystemslist);

%% Plotting the subsystem information
% modifying keyset the to ensure blank subsystems are not mistreated!!
keyset_1 = string(keyset);
keyset_1(1) = '###';

bar(categorical(keyset_1),zeros(99,1));
hold on
b = bar([cell2mat(subSystem_frequency_1.values);cell2mat(subSystem_frequency_2.values)]','stacked');
legend(b,{'Standard', 'Free DLactate'},'Location','northeast')

hold off
figure()

bar(categorical(keyset_1),cell2mat(subSystem_frequency_3.values));
legend('Methotrexate','Location','northeast')
figure()

bar(categorical(keyset_1),zeros(99,1));
hold on
b = bar([cell2mat(subSystem_frequency_4.values);cell2mat(subSystem_frequency_5.values)]','stacked');
legend(b,{'SDH Knockout','FH Knockout'},'Location','northeast')
hold off

%% Correlation between flux and pagerank
R1 = corrcoef([v2m_1(find(v2m_1~=0)),page_rank_1(find(v2m_1~=0))]);
R2 = corrcoef([v2m_2(find(v2m_2~=0)),page_rank_2(find(v2m_2~=0))]);
R3 = corrcoef([v2m_3(find(v2m_3~=0)),page_rank_3(find(v2m_3~=0))]);
R4 = corrcoef([v2m_4(find(v2m_4~=0)),page_rank_4(find(v2m_4~=0))]);
R5 = corrcoef([v2m_5(find(v2m_5~=0)),page_rank_5(find(v2m_5~=0))]);
R6 = corrcoef([v2m_6(find(v2m_6~=0)),page_rank_6(find(v2m_6~=0))]);

% Plotting of scatter plot between nonzero flux and pagerank vector in 5
% conditions.
figure 
subplot(3,2,1)
scatter(v2m_1(find(v2m_1~=0)),page_rank_1(find(v2m_1~=0)));
title('Standard Conditions');
xlabel('Absloute Flux (mmol/gDw/hr)');
ylabel('Pagerank of nodes');
text(mean(v2m_1), max(page_rank_1), ['R^2 = ' num2str(R1(2,1))])

subplot(3,2,2)
scatter(v2m_2(find(v2m_2~=0)),page_rank_2(find(v2m_2~=0)));
title('No D Lactate Constraint');
xlabel('Absloute Flux (mmol/gDw/hr)');
ylabel('Pagerank of nodes');
text(mean(v2m_2), max(page_rank_2), ['R^2 = ' num2str(R2(2,1))])

subplot(3,2,3)
scatter(v2m_3(find(v2m_3~=0)),page_rank_3(find(v2m_3~=0)));
title('Methotrexate Knockout');
xlabel('Absloute Flux (mmol/gDw/hr)');
ylabel('Pagerank of nodes');
text(mean(v2m_3), max(page_rank_3), ['R^2 = ' num2str(R3(2,1))])

subplot(3,2,4)
scatter(v2m_4(find(v2m_4~=0)),page_rank_4(find(v2m_4~=0)));
title('SDH Knockout');
xlabel('Absloute Flux (mmol/gDw/hr)');
ylabel('Pagerank of nodes');
text(mean(v2m_4), max(page_rank_4), ['R^2 = ' num2str(R4(2,1))])

subplot(3,2,5)
scatter(v2m_5(find(v2m_5~=0)),page_rank_5(find(v2m_5~=0)));
title('FH Knockout');
xlabel('Absloute Flux (mmol/gDw/hr)');
ylabel('Pagerank of nodes');
text(mean(v2m_5), max(page_rank_5), ['R^2 = ' num2str(R5(2,1))])

subplot(3,2,6)
scatter(v2m_6(find(v2m_6~=0)),page_rank_6(find(v2m_6~=0)));
title('Real Dataset');
xlabel('Absloute Flux (mmol/gDw/hr)');
ylabel('Pagerank of nodes');
text(mean(v2m_6), max(page_rank_6), ['R^2 = ' num2str(R6(2,1))])

%% Plotting the percentile comparison between pageranks in different conditions with standard conditions
% Identifying important reactions
[pr_1,indices_1] = important_reactions(page_rank_1);
[pr_2,indices_2] = important_reactions(page_rank_2);
[pr_3,indices_3] = important_reactions(page_rank_3);
[pr_4,indices_4] = important_reactions(page_rank_4);
[pr_5,indices_5] = important_reactions(page_rank_5);
[pr_6,indices_6] = important_reactions(page_rank_6);

% Calculating the percentile of important reactions
percentile_1 = calculate_percentile(pr_1);
percentile_2 = calculate_percentile(pr_2);
percentile_3 = calculate_percentile(pr_3);
percentile_4 = calculate_percentile(pr_4);
percentile_5 = calculate_percentile(pr_5);
percentile_6 = calculate_percentile(pr_6);

% Control condition will be standard condition
common_reactions_2 = intersect(indices_1,indices_2);
common_reactions_3 = intersect(indices_1,indices_3);
common_reactions_4 = intersect(indices_1,indices_4);
common_reactions_5 = intersect(indices_1,indices_5);
common_reactions_6 = intersect(indices_1,indices_6);

% Plotting of pageranks with each other
figure()
subplot(3,2,1)
% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_2);
index2use_condition = original2common_mapping(indices_2,common_reactions_2);
scatter(percentile_1(index2use_control), percentile_2(index2use_condition));
R1 = corrcoef([percentile_1(index2use_control), percentile_2(index2use_condition)]);
hold on
plot([1:0.5:100],[1:0.5:100]);
hold off
xlabel('Percentile in Standard')
ylabel('Percentile in No D-Lactate constraint')
text(2, 80, ['R^2 = ' num2str(R1(2,1))])

subplot(3,2,2)
% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_3);
index2use_condition = original2common_mapping(indices_3,common_reactions_3);
scatter(percentile_1(index2use_control), percentile_3(index2use_condition));
R2 = corrcoef([percentile_1(index2use_control), percentile_3(index2use_condition)]);
hold on
plot([1:0.5:100],[1:0.5:100]);
hold off
xlabel('Percentile in Standard')
ylabel('Percentile in Methotrexate Knockout')
text(2, 80, ['R^2 = ' num2str(R2(2,1))])

subplot(3,2,3)
% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_4);
index2use_condition = original2common_mapping(indices_4,common_reactions_4);
scatter(percentile_1(index2use_control), percentile_4(index2use_condition));
R3 = corrcoef([percentile_1(index2use_control), percentile_4(index2use_condition)]);
hold on
plot([1:0.5:100],[1:0.5:100]);
hold off
xlabel('Percentile in Standard')
ylabel('Percentile in SDH Knockout')
text(2, 80, ['R^2 = ' num2str(R3(2,1))])

subplot(3,2,4)
% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_5);
index2use_condition = original2common_mapping(indices_5,common_reactions_5);
scatter(percentile_1(index2use_control), percentile_5(index2use_condition));
R4 = corrcoef([percentile_1(index2use_control), percentile_5(index2use_condition)]);
hold on
plot([1:0.5:100],[1:0.5:100]);
hold off
xlabel('Percentile in Standard')
ylabel('Percentile in FH Knockout')
text(2, 80, ['R^2 = ' num2str(R4(2,1))])

subplot(3,2,5)
% Identifying right indexes in original important indices to use
index2use_control = original2common_mapping(indices_1,common_reactions_6);
index2use_condition = original2common_mapping(indices_6,common_reactions_6);
scatter(percentile_1(index2use_control), percentile_6(index2use_condition));
R5 = corrcoef([percentile_1(index2use_control), percentile_6(index2use_condition)]);
hold on
plot([1:0.5:100],[1:0.5:100]);
hold off
xlabel('Percentile in Standard')
ylabel('Percentile in Real Data')
text(2, 80, ['R^2 = ' num2str(R5(2,1))])