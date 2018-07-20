function [pr,indices] = important_reactions(page_rank)
    index = find(page_rank==min(page_rank));
    indices = find(page_rank>page_rank(index(1)));
    pr = page_rank(indices);
end