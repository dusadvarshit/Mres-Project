% 1: Standard
% 2: No D Lactate constraint
function [page_rank_1, page_rank_2, v2m_1, v2m_2, page_rank_diff, v_diff, M_1, M_2,direction,rxnlist, rxnNameslist, subSystemslist] = relative_pagerank_flux_difference(file1,file2)

%Providing the direction of reaction variable
direction = cell(7576,1);
for a = 1:3788
direction{a} = 'Forward';
end
clc
for a = 3789:7576
direction{a} = 'Backward';
end

% Run in loop till exporting of results to excel files.
% Generate and store necessary variables. Delete the unnneccessary ones.

disp(file1);
load(file1);    

model_1 = model;
page_rank_1 = page_rank;
v_plus = (0.5.*(abs(v) + v))';
v_minus = (0.5.*(abs(v) - v))';
v2m_1 = [v_plus v_minus]';
M_1 = M;
rxnlist = [model_1.rxns;model_1.rxns];
rxnNameslist = [model_1.rxnNames;model_1.rxnNames];
subSystemslist = [model_1.subSystems; model_1.subSystems];
clear v_plus v_minus model page_rank v M

% Get the filename and pathname for the .mat models
% [filename, pathname] = uigetfile();
% Load the models
% load(strcat(pathname,filename));

%Generate and store necessary variables; clear the rest
disp(file2);
load(file2);
model_2 = model;
page_rank_2 = page_rank;
v_plus = (0.5.*(abs(v) + v))';
v_minus = (0.5.*(abs(v) - v))';
v2m_2 = [v_plus v_minus]';
M_2 = M;
%direction = 
clear v_plus v_minus model page_rank v M

%Calculate the page_rank difference and normalize it.
page_rank_diff = page_rank_1-page_rank_2;
page_rank_diff = page_rank_diff./(page_rank_1+page_rank_2);

% Calculate the flux differences and normalize it. Pay special attention to
% 0/0 condition
v_diff = zeros(7576,1);
for j=1:7576
    if v2m_1(j)+v2m_2(j) ==0
    v_diff(j) = 0;
    else
    v_diff(j) = (v2m_1(j)-v2m_2(j))./(v2m_1(j)+v2m_2(j));
end
end

end
