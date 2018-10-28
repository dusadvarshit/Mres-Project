% M-file to analyze bow-tie topology of metabolic networks by MFGs

%% Loading the files which needs to be analyzed and other pre-processing steps
folder = dir(uigetdir());

all_models = cell(length(folder)-2,1);
for i=3:length(folder)  
    all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end


%% Constructing the graph
nodenames = [1:2*length(model.rxns)]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));

G = digraph(M,nodenames,'OmitSelfLoops'); % Converting matrix to the graph
H = extract_connected_subgraph(G); % Extracting only the connected component; Also the v~=0

%% Analyzing the network. Identifying the giant strong connected component
[bins] = conncomp(H,'Type','strong'); % Identify bins for each node
bins = bins';

a = unique(bins);
k = zeros(length(a),1);

for i =1:length(k)
    k(i) = length(find(bins == a(i)));
end

k_max = find(k==max(k));
find(bins==k_max);
x = find(bins~=k_max); %Finding nodes in H which do not belong to GSC
y = find(bins==k_max); %Finding nodes in H which do belong to GSC

%% Analyzing nodes in the GSC and not in GSC.
nodenames = [1:7576]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));
from_gsc_all  = zeros(60,1);
to_gsc_all  = zeros(60,1);
gsc_all  = zeros(60,1);
all_follow_gsc = cell(60,1);

for j=1:60
disp(j)
load(all_models{j})

G = digraph(M,nodenames,'OmitSelfLoops');
H = extract_connected_subgraph(G);

[bins] = conncomp(H,'Type','strong'); % Identify bins for each node
bins = bins';

a = unique(bins);
k = zeros(length(a),1);

for p =1:length(k)
    k(p) = length(find(bins == a(p)));
end

k_max = find(k==max(k));
find(bins==k_max);
x = find(bins~=k_max); %Finding nodes in H which do not belong to GSC
y = find(bins==k_max); %Finding nodes in H which do belong to GSC


% degree of nodes outside the GSC.
x_degree = [indegree(H,x) outdegree(H,x)];
y_degree = [indegree(H,y) outdegree(H,y)];

d = distances(H,'Method','unweighted'); % Because only existence of path matters not exact distance
d1 = d'; 

from_gsc = zeros(length(x),1); %Identifying nodes which only have incoming nodes from GSC
to_gsc = zeros(length(x),1); %Identifying nodes which only have outgoing nodes towards GSC.

for i=1:length(x)
if length(find(d(x(i),y)==Inf))==length(y) % Some nodes should only have edges from GSC.
from_gsc(i) = x(i);
end
if length(find(d1(x(i),y)==Inf))==length(y) % Some nodes should only have edges to GSC.
to_gsc(i) = x(i);
end
end

from_gsc_all(j)  = length(find(from_gsc~=0));
to_gsc_all(j)  = length(find(to_gsc~=0));
gsc_all(j)  = length(y);
if from_gsc_all(j)+to_gsc_all(j)+gsc_all(j) == length(table2array(H.Nodes))
    all_follow_gsc(j) = cellstr('yes');
end
end

%% Identify the position of essential reaction in MFG: GSC, S or P?
essential_rxn = moma_lethal(:,2); % In this case A498 should be identified accordingly.
essential_rxn = essential_rxn(find(essential_rxn~=0));
original_node_label = return_original_node_no(H);

% How many in substrate group?
temp_transfer  = original_node_label(from_gsc(find(from_gsc~=0)));
lethal_substrate = intersect(temp_transfer,essential_rxn);

% How many in product group?
temp_transfer  = original_node_label(to_gsc(find(to_gsc~=0)));
lethal_product = intersect(temp_transfer,essential_rxn);

% How many in GSC?
lethal_GSC = intersect(original_node_label(y),essential_rxn);


%% Compute the growth rate in different biomass conditions

biomass = zeros(60,1);
for i=1:60
    load(all_models{i})
    biomass(i) = v(3745);
end

%% Compute number of nodes and edges in giant connected component

num_nodes = zeros(60,1);
num_edges = zeros(60,1);

nodenames = [1:7576]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));

for i=1:60
    load(all_models{i})
    G = digraph(M,nodenames,'OmitSelfLoops');
    H = extract_connected_subgraph(G);
    num_nodes(i) = height(H.Nodes);
    num_edges(i) = height(H.Edges);
end

%% Identify lethal mutations using both MOMA and FBA for all the cell lines.

fba_lethal = [];
moma_lethal = [];

% Load oxygen information for all cell lines
%load('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.06.13\Warburg effect verification\o2_lactate_threshold.mat')

for i=1:224
    load(all_models{i})
    
    model1 = model;
    model1 = changeRxnBounds(model1,model.rxns(1372),-1,'b'); %L-Glutamine
    model1 = changeRxnBounds(model1,model.rxns(968),-5,'b'); % D-Glucose
    model1 = changeRxnBounds(model1,model.rxns(687),0.005,'b'); %D-Lactate release
    %model1 = changeRxnBounds(model1,model.rxns(3446),o2_flux(i),'b'); %O2 uptake
    
    rxn_list = setdiff(model.rxns,blockedReactions);
    [grRatio, grRateKO, grRateWT, hasEffect, delRxn, fluxSolution] = singleRxnDeletion(model1, 'FBA', rxn_list);
    
    temp = find(grRateKO<0.05);
    fba_lethal(1:length(temp),i) = temp;
    
    [grRatio, grRateKO, grRateWT, hasEffect, delRxn, fluxSolution] = singleRxnDeletion(model1, 'MOMA', rxn_list);
    
    temp = find(grRateKO<0.05);
    moma_lethal(1:length(temp),i) = temp;
    
end


