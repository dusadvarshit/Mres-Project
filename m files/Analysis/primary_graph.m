% This m-file will be used a primer for primary graph structure analysis

%% Identify distribution of nodes and their degree.

indegree = zeros(7576,1);
outdegree = zeros(7576,1);
for i=1:7576
    indegree(i) = length(find(tOut==i));
    outdegree(i) = length(find(sOut==i));
end
degree_count = indegree+outdegree;
s = scatter(v2m(find(degree_count~=0)),degree_count(find(degree_count~=0)));
%set(gca,'xscale','log')