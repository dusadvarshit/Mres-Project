% Checking bow tie topology for all the sampled solution
nodenames = [1:7576]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));
from_gsc_all  = zeros(1000,1);
to_gsc_all  = zeros(1000,1);
gsc_all  = zeros(1000,1);
isolated_set_all = zeros(1000,1);
nodes_total_all = zeros(1000,1);
edges_total_all = zeros(1000,1);
all_follow_gsc = cell(1000,1);

for j=1:1000
disp(j)
load(all_models{j})

%M = MFG_cancer_sparse(model1, ); %m(:,j) v_rand
G = digraph(M_random_v,nodenames,'OmitSelfLoops'); % M  M_random_S
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
isolated_set = zeros(length(x),1);

for i=1:length(x)
if (length(find(d(x(i),y)==Inf))==length(y) & length(find(d1(x(i),y)==Inf))==length(y))
isolated_set(i) = x(i);
elseif length(find(d(x(i),y)==Inf))==length(y) % Some nodes should only have edges from GSC.
from_gsc(i) = x(i);
elseif length(find(d1(x(i),y)==Inf))==length(y) % Some nodes should only have edges to GSC.
to_gsc(i) = x(i);
end
end

% Nodes and edge info
nodes_total_all(j) =  height(H.Nodes);
edges_total_all(j) =  height(H.Edges);
% Bow tie info
from_gsc_all(j)  = length(find(from_gsc~=0));
to_gsc_all(j)  = length(find(to_gsc~=0));
isolated_set_all(j) = length(find(isolated_set~=0));

gsc_all(j)  = length(y);
if from_gsc_all(j)+to_gsc_all(j)+gsc_all(j) + isolated_set_all(j) == length(table2array(H.Nodes))
    all_follow_gsc(j) = cellstr('yes');
end
end