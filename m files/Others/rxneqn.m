% Output string describing chemical rxn

function rxneqn = RxnEqn(rxnpos,model,fullnamesID)

% Find position of mets in rxns:
m_cons_p = find(model.S(:,rxnpos) < 0);
m_prod_p = find(model.S(:,rxnpos) > 0);

% Find is rxn is in fwd, reverse or both (reversible) directions:
Lb = model.lb(rxnpos);
Ub = model.ub(rxnpos);

% Constructing string of reaction equation:
if fullnamesID == 1
    M = model.metNames;
    rxneqn = strcat(model.rxnNames(rxnpos),{': '});
else
    M = model.mets;
    rxneqn = strcat(model.rxns(rxnpos),{': '});
end

for i = 1:length(m_cons_p)
    if i == 1
        rxneqn = strcat(rxneqn, num2str((-1) * model.S(m_cons_p(i),rxnpos)),{' '},M(m_cons_p(i)));
    else
        rxneqn = strcat(rxneqn,{' + '},num2str((-1) * model.S(m_cons_p(i),rxnpos)),{' '},M(m_cons_p(i)));
    end
end
if model.rev == 1
    rxneqn = strcat(rxneqn,{' <=> '});
elseif Lb < 0 && Ub <= 0
    rxneqn = strcat(rxneqn,{' <-- '});
elseif Lb >= 0 && Ub > 0
    rxneqn = strcat(rxneqn,{' --> '});
end
for i = 1:length(m_prod_p)
    if i == 1
        rxneqn = strcat(rxneqn,num2str(model.S(m_prod_p(i),rxnpos)),{' '},M(m_prod_p(i)),{' '});
    else
        rxneqn = strcat(rxneqn,{' + '},num2str(model.S(m_prod_p(i),rxnpos)),{' '},M(m_prod_p(i)));
    end
end
