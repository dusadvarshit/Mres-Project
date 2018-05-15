% Use this file to extract all reactions in the model

reaction_names = cell(3788,1);
reaction_formulas = cell(3788,1);

for i=1:3788
    reaction_names{i} = rxneqn(i,model,1);
    reaction_formulas{i} = rxneqn(i,model,0);
end

    