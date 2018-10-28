%changeCobraSolver('glpk','all');
function M = MFG_cancer_temp(model, v)
    % Launch the genome scale model prior to running this script in Matlab
    % workspace using cobratoolbox "readCbModel()".
    
    % Generate an outside variable for stoichiometric matrix
    S = full(model.S); %S take from the model; stored in workspace
    
    B = (S ~= 0); %boolean version of stoichometric matrix

    % Reaction adjancency matrix
    A = double(B')*double(B);
    len = length(S(1,:));
    
    % reversibility vector
    % This is probably wrong method: %R = double((model.rev)); %[0; 0; 0; 1; 0; 0; 0; 0];
    %double(model.lb<0 & model.ub>0);
    R = ones(length(model.rxns),1); % Rev is deprecetated and not used anymore.
    r = diag(R);
    Im = eye(len,len);
    S2m_1 = [S -S];
    S2m_2 = [Im zeros(len); zeros(len) r];
    S2m = S2m_1*S2m_2;

    %Production and consumption matrices
    S2m_plus = 0.5.*(abs(S2m) + S2m);
    S2m_minus = 0.5.*(abs(S2m) - S2m);

    %General
    v_plus = (0.5.*(abs(v) + v))';
    v_minus = (0.5.*(abs(v) - v))';
    v2m = [v_plus v_minus]';
    % Vector of production and consumption fluxes
    j_v = S2m_plus*v2m;
    J_v = diag(j_v);
    V = diag(v2m);

    M = (S2m_plus*V)'*(pinv(J_v))*(S2m_minus*V);
end

    


