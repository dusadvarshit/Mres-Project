% This m-file will be used in extracting relevant information from an
% analyzed mat file like pagerank,v2m, M etc.
function [pagerank,v2m, M_1, rxnNameslist, subSystemslist, direction] = relevent_information(file)

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

disp(file);
load(file);    

model_1 = model;
pagerank = page_rank;
v_plus = (0.5.*(abs(v) + v))';
v_minus = (0.5.*(abs(v) - v))';
v2m = [v_plus v_minus]';
M_1 = M;
rxnlist = [model_1.rxns;model_1.rxns];
rxnNameslist = [model_1.rxnNames;model_1.rxnNames];
subSystemslist = [model_1.subSystems; model_1.subSystems];
clear v_plus v_minus model page_rank v M