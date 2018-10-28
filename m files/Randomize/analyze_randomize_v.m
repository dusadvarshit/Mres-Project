% This m-file will analyze the result of randomization of MFG algorithm.
% This m-file is divided into subsections.
%% Preliminary work
folder = dir(uigetdir());
all_models = cell(1000,1);
for i=3:1002
    all_models{i-2} =   strcat(folder(i).folder,'\',folder(i).name);
end


%% Number of nodes and edges in most connected components
% Making graph of unrandomize matrix and calculating its topology
g = digraph(M,'OmitSelfLoops');
h = extract_connected_subgraph(g);
% Computing nodes and edges in unrandomized graph
n_nodes = numnodes(h);
n_edges = numedges(h);

number_nodes = zeros(1000,1); %zeros(60,1);
number_edges = zeros(1000,1); %zeros(60,1);

for i = 1:1000
    load(all_models{i})
    disp(i);
    H =  extract_connected_subgraph(G);
    number_nodes(i) = numnodes(H);
    number_edges(i) = numedges(H);
end
[hyp_n,p_n,ci_n,zval_n] = ztest(n_nodes,mean(number_nodes),std(number_nodes));
[hyp_e,p_e,ci_e,zval_e] = ztest(n_edges,mean(number_edges),std(number_edges));

%% Characteristic path length of network.
% Making graph of unrandomize matrix and calculating its topology
nodenames = [1:7576]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));

g = digraph(M,nodenames,'OmitSelfLoops');
h = extract_connected_subgraph(g);

% Compensate for zero indegree and outdegree
%h_1 = compensate_zero_degree_nodes(h);

% Complementary variable where weights can be used as distances.
h_dist = h;
h_dist.Edges.Weight = 1./h_dist.Edges.Weight;

% Calculating shortest node distances
d = distances(h_dist);

d_withoutInf = d(:); %Removing the "Inf" values from the matrix.
d_withoutInf = d_withoutInf(find(d_withoutInf~=1/0));

% % % %
% This commented region is now defunct. Ignore and move on!
%d_withoutInf = d;
%for a=1:numnodes(h_dist)
%        for b = 1:numnodes(h_dist)
%            if d_withoutInf(a,b) == 1/0
%                d_withoutInf(a,b) = 0;
%            end
%        end
%end
%  %  %
% Control is MFG of BT-549 in standard condition. Load the .mat file before
% run

average_path_control = sum(sum(d_withoutInf))/((numnodes(h_dist))*numnodes(h_dist)-1);
network_diameter_control = max(max(d_withoutInf));
    
% Computing network parameters for randomized graph
average_distance = zeros(1000,1);
network_diameter = zeros(1000,1);

for i=1:1000
    load(all_models{i});
    disp(i);
    G = digraph(M_random_v,nodenames,'OmitSelfLoops');
    H =  extract_connected_subgraph(G);
    
    % Compensate for zero indegree and outdegree
    %H_1 = compensate_zero_degree_nodes(H);

    % Complementary variable where weights can be used as distances.
    H_dist = H;
    H_dist.Edges.Weight = 1./H_dist.Edges.Weight; %Assuming weights implied closeness!
    D = distances(H_dist); % Calculate the distance with distance weights.
    D_withoutInf = D(:); %Removing the "Inf" values from the matrix.
    D_withoutInf = D_withoutInf(find(D_withoutInf~=1/0));
    
    %for a=1:numnodes(H_dist)
    %    for b = 1:numnodes(H_dist)
    %        if D_withoutInf(a,b) == 1/0
    %            D_withoutInf(a,b) = 0;
    %        end
    %   end
    %end
    average_distance(i) = sum(sum(D_withoutInf))/length(D_withoutInf);%((numnodes(H_dist))*numnodes(H_dist)-1);
    
    network_diameter(i) = max(max(D_withoutInf));
end

[hyp_avgL,p_avgL,ci_avgL,zval_avgL] = ztest(average_path_control,mean(average_distance),std(average_distance));
[hyp_dia,p_dia,ci_dia,zval_dia] = ztest(network_diameter_control,mean(network_diameter),std(network_diameter));

%% Power law
% Degree distribution actual vs random
nodenames = [1:7576]';
nodes = nodenames;
nodenames = cellstr(string(nodenames));

g = digraph(M,nodenames,'OmitSelfLoops');
h = extract_connected_subgraph(g);

deg = indegree(h)+outdegree(h);
h1 = histogram(deg);
h1.BinWidth =1;
count1 = h1.BinCounts;
count1 = count1';
count1 = count1(find(count1>0));
deg_unique = unique(deg);

% Using logfit function <external code, not Matlab inbuilt>
% Ignores x=0 and y =0 values on both axis and thus +1 added to remove 0.
[slope_deg, intercept_deg] = logfit(log(deg_unique+1),log(count1+1),'loglog'); 

% Pagerank distribution actual vs random
h2 = histogram(page_rank);
h2.BinWidth = min(page_rank);
x = h2.BinEdges(1:length(h2.BinEdges)-1);
y = h2.BinCounts;

% Using logfit function <external code, not Matlab inbuilt>
% Ignores x=0 and y =0 values on both axis and thus +1 and +2 added to remove 0.
[slope_pr, intercept_pr] = logfit(log(x+1),log(y+2),'loglog');

% Initializing variables to hold results
pr_slope = zeros(1000,1);
deg_slope = zeros(1000,1);

for i=1:1000
    load(all_models{i});
        disp(i);
    
    G = digraph(M_random_v,nodenames,'OmitSelfLoops');
    H = extract_connected_subgraph(G);

    % Degree calculations
    deg = indegree(H)+outdegree(H);
    h1 = histogram(deg);
    h1.BinWidth =1;
    count1 = h1.BinCounts;
    deg_unique = h1.BinEdges(1:length(h1.BinEdges)-1);
    % Using logfit function <external code, not Matlab inbuilt>
    % Ignores x=0 and y =0 values on both axis and thus +1 and +2 added to remove 0.
    [slope_deg_v, intercept_deg_v] = logfit(log(deg_unique+1),log(count1+2),'loglog'); 
    
    deg_slope(i) = slope_deg_v;

    % Pagerank distribution of random graphs
    h2 = histogram(page_rank_random_v);
    h2.BinWidth = min(page_rank_random_v);
    x = h2.BinEdges(1:length(h2.BinEdges)-1);
    y = h2.BinCounts;

    % Using logfit function <external code, not Matlab inbuilt>
    % Ignores x=0 and y =0 values on both axis and thus +1 and +2 added to remove 0.
    [slope_pr_v, intercept_pr_v] = logfit(log(x+1),log(y+2),'loglog');
    
    pr_slope(i) = slope_pr_v;
    
end
[hyp_deg,p_deg,ci_deg,zval_deg] = ztest(slope_deg,mean(deg_slope),std(deg_slope));
[hyp_pr,p_pr,ci_pr,zval_pr] = ztest(slope_pr,mean(pr_slope),std(pr_slope));

%% Clustering coefficient
% Calculated using networkx in python

%% Centrality measures! Pagerank, degree, betweeness, 

%% Statistical significance of maximum pagerank

