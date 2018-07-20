% Returns index of top 10 nodes based on pagerank in descending order
function nodeindex = top10nodes(page_rank,v2m, k)
    sorted_pagerank = sort(page_rank,'descend');
    extract_important = sorted_pagerank(1:k,1);
    for i = 1:k
        nodeindex(i) = find(page_rank==extract_important(i));
    end
    nodeindex = nodeindex';
end