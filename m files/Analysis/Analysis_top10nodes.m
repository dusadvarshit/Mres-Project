% Loop over all the cell lines in all 5 conditions to identify top 10 nodes
% in decreasing order of pagerank.

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

%% Load all the files and extract necessary variables
[page_rank_1,v2m_1, M_1, rxnNameslist, subSystemslist, direction] = relevent_information(file_1);
[page_rank_2,v2m_2, M_2, rxnNameslist, subSystemslist, direction] = relevent_information(file_2);
[page_rank_3,v2m_3, M_3, rxnNameslist, subSystemslist, direction] = relevent_information(file_3);
[page_rank_4,v2m_4, M_4, rxnNameslist, subSystemslist, direction] = relevent_information(file_4);
[page_rank_5,v2m_5, M_5, rxnNameslist, subSystemslist, direction] = relevent_information(file_5);


%% Make the function call for top 10 node indices
nodeindex_1 = top10nodes(page_rank_1,v2m_1, 10);
nodeindex_2 = top10nodes(page_rank_2,v2m_2, 10);
nodeindex_3 = top10nodes(page_rank_3,v2m_3, 10);
nodeindex_4 = top10nodes(page_rank_4,v2m_4, 10);
nodeindex_5 = top10nodes(page_rank_5,v2m_5, 10);

%% Comparison across all 5 conditions,
common_nodes = intersect(nodeindex_1,nodeindex_2);
common_nodes = intersect(nodeindex_3,nodeindex_2);
common_nodes = intersect(nodeindex_4,nodeindex_3);
common_nodes = intersect(nodeindex_5,nodeindex_4);
%% Node description
node_standard = [string(rxnNameslist(nodeindex_1)) string(direction(nodeindex_1)) string(subSystemslist(nodeindex_1))];
node_noDLactateConstraint = [string(rxnNameslist(nodeindex_2)) string(direction(nodeindex_2)) string(subSystemslist(nodeindex_2))];
node_MethotrexateKnockout = [string(rxnNameslist(nodeindex_3)) string(direction(nodeindex_3)) string(subSystemslist(nodeindex_3))];
node_SDHKnockout = [string(rxnNameslist(nodeindex_4)) string(direction(nodeindex_4)) string(subSystemslist(nodeindex_4))];
node_FHKnockout = [string(rxnNameslist(nodeindex_5)) string(direction(nodeindex_5)) string(subSystemslist(nodeindex_5))];
