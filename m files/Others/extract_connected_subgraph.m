% This function will extract the subgraph with biggest connected component
% and return it
function H = extract_connected_subgraph(G)
    [bins] = conncomp(G,'Type','weak');
    bins = bins';
    
    a = unique(bins);

    k = zeros(length(a),1);
   
    for i =1:length(k)
        k(i) = length(find(bins == a(i)));
    end
    
    k_max = find(k==max(k));
    H = subgraph(G,find(bins==k_max));
end