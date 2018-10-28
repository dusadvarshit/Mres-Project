% Function to attach zero percentile to supernumary reactions in union

function percentile_1_1 = add_zero2percentile(percentile,indices, total_reactions)
    percentile_1_1 = zeros(length(total_reactions),1);
    for i=1:length(indices)
        percentile_1_1(find(total_reactions==indices(i))) = percentile(i);
    end
end