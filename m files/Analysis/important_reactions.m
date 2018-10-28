function [pr,indices] = important_reactions(v2m,page_rank)
    index =   find(v2m~=0);  % find(page_rank>min(page_rank));find(v2m>0.0000000001);
    indices =  index;%find(page_rank>page_rank(index(1)));%
    pr = page_rank(indices);
end