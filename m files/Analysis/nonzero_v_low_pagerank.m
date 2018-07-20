function nodeindex = nonzero_v_low_pagerank(v2m,pagerank)
    nonzero_flux = find(v2m~=0);
    min_pagerank = find(pagerank==min(pagerank));
    important_reactions = find(pagerank>pagerank(min_pagerank(1)));
    
    nodeindex = setdiff(nonzero_flux,important_reactions);
end