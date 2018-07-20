% This m-file will be used to calculate the subsystem frequency count based
% on the input pagerank vector. 

function subSystem_pr = subSystem_pagerank(pagerank,subSystemslist)
    % Indexing the reactions with minimum pagerank
    % Identifying reactions with pagerank higher than minimum pagerank
    min_index = find(pagerank==min(pagerank));
    important_reactions = find(pagerank>pagerank(min_index(1)));
    
    keyset = unique(subSystemslist);
    subSystem_pr = containers.Map(keyset,zeros(99,1));
    for i=1:length(important_reactions)
        subSystem_pr(subSystemslist{important_reactions(i)}) = subSystem_pr(subSystemslist{important_reactions(i)})+ pagerank(important_reactions(i)); 
    end
end