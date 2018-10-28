% This m-file will be used to analyze synthetic lethal pairs.

%% Find the reaction ids of all the synthetic lethal pairs.
rxn_ids = findRxnIDs(model,Jdl);

%% Extract relevant information for original network
direction = cell(7576,1);
for a = 1:3788
direction{a} = 'Forward';
end
clc
for a = 3789:7576
direction{a} = 'Backward';
end

v_plus = (0.5.*(abs(v) + v))';
v_minus = (0.5.*(abs(v) - v))';
v2m = [v_plus v_minus]';
rxnlist = [model.rxns;model.rxns];
rxnNameslist = [model.rxnNames;model.rxnNames];
subSystemslist = [model.subSystems; model.subSystems];
clear a v_plus v_minus

%% Find the rxn_ids whose reactions are active in reverse direction.
rxn_ids_2 = rxn_ids(:,1);
for i=1:length(rxn_ids_2)
    if v2m(rxn_ids_2(i))==0
        rxn_ids_2(i) = rxn_ids_2(i)+3788;
    end
end

%% Find the pagerank and pagerank percentile of first reaction in the pair
[pr_1,indices_1] = important_reactions(v2m,page_rank); 
percentile_1 = calculate_percentile(pr_1);
lethal_rank_1 = zeros(length(rxn_ids_2),1);
for i=1:length(rxn_ids_2)
    a = find(indices_1==rxn_ids_2(i,1));
    lethal_rank_1(i) = percentile_1(a(1));
end

%% Do knockout of first rxn and identify the percentile of the second rxn.
lethal_rank_2 = zeros(length(rxn_ids_2),1);

for i=1:length(rxn_ids_2)
    disp(i);
    
    model3 = model1;
    model3 = changeRxnBounds(model3,Jdl(i,1),0,'b');
    model4 = optimizeCbModel(model3,'max');
    
    M2 = MFG_cancer_sparse(model,model4.v);
    page_rank_2 = pagerank(M2);
    
    v_2 = model4.v;
    v_plus = (0.5.*(abs(v_2) + v_2))';
    v_minus = (0.5.*(abs(v_2) - v_2))';
    v2m_2 = [v_plus v_minus]';
    
    [pr_2,indices_2] = important_reactions(v2m_2,page_rank_2); 
    percentile_2 = calculate_percentile(pr_2);
    
    rxn_ids_3 = rxn_ids(:,2);
    for j=1:length(rxn_ids_3)
        if v2m_2(rxn_ids_3(j))==0
            rxn_ids_3(j) = rxn_ids_3(j)+3788;
        end
    end
    
    a = find(indices_2==rxn_ids_3(i));
    lethal_rank_2(i) = percentile_1(a(1));
    
end
