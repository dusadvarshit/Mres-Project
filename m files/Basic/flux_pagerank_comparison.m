%This m-file contains the code to produce difference in fluxes and pagerank
%of all the reactions of a given model in aerobic and anaerobic condition.
clear all;
%%Older code
% Get the filename and its path by browsing through dialog box
% [filename, pathname] = uigetfile();
%Load the file
% load(strcat(pathname,filename));

% AEROBIC
folder_aero = dir(uigetdir());

all_models_aero = cell(6,1);
for i=3:8  
all_models_aero{i-2} = strcat(folder_aero(i).folder,'\',folder_aero(i).name);
end


% ANAEROBIC
folder_anaero = dir(uigetdir());

all_models_anaero = cell(6,1);
for i=3:8  
all_models_anaero{i-2} = strcat(folder_anaero(i).folder,'\',folder_anaero(i).name);
end

% Get the excel filename for storage. Prepare blank file with desired
% name.
[filename, pathname] = uigetfile(); 
file_export = strcat(pathname,filename);

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
% AEROBIC
% Generate and store necessary variables. Delete the unnneccessary ones.
for i=1:length(all_models_aero)
disp(i);
disp(all_models_aero{i});
load(all_models_aero{i});    
sheet_name = folder_aero(i+2).name;

model_aero = model;
page_rank_aero = page_rank;
v_plus = (0.5.*(abs(v) + v))';
v_minus = (0.5.*(abs(v) - v))';
v2m_aero = [v_plus v_minus]';
rxnlist = [model_aero.rxns;model_aero.rxns];
rxnNameslist = [model_aero.rxnNames;model_aero.rxnNames];
subSystemslist = [model_aero.subSystems; model_aero.subSystems];
clear v_plus v_minus model page_rank v

% Get the filename and pathname for the .mat models
% [filename, pathname] = uigetfile();
% Load the models
% load(strcat(pathname,filename));

%Generate and store necessary variables; clear the rest
disp(all_models_anaero{i});
load(all_models_anaero{i});
model_anaero = model;
page_rank_anaero = page_rank;
v_plus = (0.5.*(abs(v) + v))';
v_minus = (0.5.*(abs(v) - v))';
v2m_anaero = [v_plus v_minus]';
%direction = 
clear v_plus v_minus

%Calculate the page_rank difference and normalize it.
page_rank_diff = page_rank_aero-page_rank_anaero;
page_rank_diff = page_rank_diff./(page_rank_aero+page_rank_anaero);

% Calculate the flux differences and normalize it. Pay special attention to
% 0/0 condition
v_diff = zeros(7576,1);
for j=1:7576
    if v2m_aero(j)+v2m_anaero(j) ==0
    v_diff(j) = 0;
    else
    v_diff(j) = (v2m_aero(j)-v2m_anaero(j))./(v2m_aero(j)+v2m_anaero(j));
end
end

% Present the differences in a single vector for easy access. The results
% could be exported but we are better of by simple copy pasting in this
% situation.
duplet = [v_diff page_rank_diff];

%Export to excel file
xlswrite(file_export,{'rxns','rxnNames','subSystems','page_rank_diff','v_diff','Direction'},sheet_name,'A1');
xlswrite(file_export,rxnlist,sheet_name,'A2');
xlswrite(file_export,rxnNameslist,sheet_name,'B2');
xlswrite(file_export,subSystemslist,sheet_name,'C2');
xlswrite(file_export,page_rank_diff,sheet_name,'D2');
xlswrite(file_export,v_diff,sheet_name,'E2');
xlswrite(file_export,direction,sheet_name,'F2');
end
