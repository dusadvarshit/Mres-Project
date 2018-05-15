% function to randomize the stoichiometric matrix S 

function s = randomize_S(S)
    s = S;
    for i = 1:3788
       r = s(:,i); % Vector to retain metabolites stoichiometry in reactions.
       s(:,i) = r(randperm(length(r))); 
    end
end
