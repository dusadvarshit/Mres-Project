%Check if all the uptake exchange reactions are ignored by pagerank
%importance criteria

left_list = exchange_list;
%for i=1:5
folder = dir(uigetdir());

all_models = cell(60,1);
for k=3:62  
all_models{k-2} = strcat(folder(k).folder,'\',folder(k).name);
end

for j = 1:length(all_models)
disp(j)
[page_rank,v2m, M, rxnNameslist, subSystemslist, direction] = relevent_information(all_models{j});
[pr,indices] = important_reactions(page_rank);
left_out = setdiff(find(v2m~=0),indices);
ignored_reactions = rxnNameslist(left_out);
left_list = intersect(left_list,ignored_reactions);
end
%end
