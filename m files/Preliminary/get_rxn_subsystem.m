% For a given model and a cell of reactions. Identify the unique subsystems
% belonging to cell of reactions

function active_subsystems = get_rxn_subsystem(model, rxnlist);
    active_subsystems = cell(length(rxnlist),1);
    
    for i=1:length(rxnlist)
        active_subsystems{i} = model.subSystems(find(strcmp(model.rxns, string(rxnlist{i}))));
    end
end