% This m-file will be used to calculate the subsystem frequency count based
% on the input pagerank vector. 

function subSystem_frequency = subSystem_count(pagerank,subSystemslist)
    % Indexing the reactions with minimum pagerank
    % Identifying reactions with pagerank higher than minimum pagerank
    min_index = find(pagerank==min(pagerank));
    important_reactions = find(pagerank>pagerank(min_index(1)));
        
    keyset = cellstr(unique(subSystemslist));
    subSystem_frequency = containers.Map(keyset,zeros(99,1));
    
    for i=1:length(important_reactions)
        subSystem_frequency(subSystemslist{important_reactions(i)}) = subSystem_frequency(subSystemslist{important_reactions(i)})+ 1; 
    end
end