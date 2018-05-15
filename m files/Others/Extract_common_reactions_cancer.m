%This m-file contains the code to produce difference in fluxes and pagerank
%of all the reactions of a given model in aerobic and anaerobic condition.
clear all;
%%Older code
% Get the filename and its path by browsing through dialog box


% AEROBIC
folder = dir(uigetdir());

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

load(all_models{1});
compare_reaction = (v~=0);
compare_reaction = double(compare_reaction);

cell_line_count = zeros(3788,1); %This vector keeps a count of number of cell lines reaction 
                                 % active or inactive in.
                                 
for i=1:60%length(all_models)
disp(i);
disp(all_models{i});
load(all_models{i});

logical_v = (v~=0); %Stores the logical value given if v == 0 or not!
logical_v = double(logical_v);

 for j=1:3788
    if compare_reaction(j) == logical_v(j)
        if  compare_reaction(j) == 1
            compare_reaction(j) = 1;            
            cell_line_count(j) = cell_line_count(j)+1;
        elseif compare_reaction(j) ==0 
            compare_reaction(j) = 0;            
            cell_line_count(j) = cell_line_count(j)+1;
        end
    elseif compare_reaction(j) ~= logical_v(j)
        compare_reaction(j) = 2;
        if logical_v(j) == 1
            cell_line_count(j) = cell_line_count(j)+1;
        end
    end
    
        
end
end



