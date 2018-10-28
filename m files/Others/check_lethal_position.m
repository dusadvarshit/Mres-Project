% File to check where in bow tie topology MOMA predicted reactions lie

folder = dir(uigetdir());

all_models = cell(length(folder)-2,1);
for i=3:length(folder)  
    all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

nodenames = [1:7576]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));

lethal_substrate_all = [];
lethal_product_all = [];
lethal_GSC_all = [];

for i=1:60
disp(i)
load(all_models{i})

G = digraph(M,nodenames,'OmitSelfLoops');
H = extract_connected_subgraph(G);
%H2G_node_label = table2array(H.Nodes);
%H2G_node_label = str2double(string(H2G_node_label));

% The bow tie topology analysis
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

for j=1:length(x)
if (length(find(d(x(j),y)==Inf))==length(y) & length(find(d1(x(j),y)==Inf))==length(y))
isolated_set(j) = x(j);
elseif length(find(d(x(j),y)==Inf))==length(y) % Some nodes should only have edges from GSC.
from_gsc(j) = x(j);
elseif length(find(d1(x(j),y)==Inf))==length(y) % Some nodes should only have edges to GSC.
to_gsc(j) = x(j);
end
end

% Identifying position of lethal reactions
essential_rxn = moma_lethal(:,i); % In this case A498 should be identified accordingly.
essential_rxn = essential_rxn(find(essential_rxn~=0));
original_node_label = return_original_node_no(H);

% How many in substrate group?
temp_transfer  = original_node_label(to_gsc(find(to_gsc~=0)));
lethal_substrate = intersect(temp_transfer,essential_rxn);
lethal_substrate_all(1:length(lethal_substrate),i) = lethal_substrate;

% How many in product group?
temp_transfer  = original_node_label(from_gsc(find(from_gsc~=0)));
lethal_product = intersect(temp_transfer,essential_rxn);
lethal_product_all(1:length(lethal_product),i) = lethal_product;

% How many in GSC?
lethal_GSC = intersect(original_node_label(y),essential_rxn);
lethal_GSC_all(1:length(lethal_GSC),i) = lethal_GSC;

end
