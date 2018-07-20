% This m-file takes list of 2 indices and sends back the sorted array containing
% the index numbers of the indices array containing the same value
% as index of common reactions
% This method works because these arrays are always sorted!
function index2use = original2common_mapping(indices,common_reactions)
    index2use = zeros(length(common_reactions),1);
    for i=1:length(common_reactions)
        index2use(i) = find(indices == common_reactions(i));
    end
end