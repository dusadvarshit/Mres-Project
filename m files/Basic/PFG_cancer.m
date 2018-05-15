% Launch the genome scale model prior to running this script in Matlab
% workspace using cobratoolbox "readCbModel()" or if it is a mat file then just load 
%into workspace.

function P = PFG_cancer(model)
    % use model = name of mat file used before running the codes.
S = full(model.S); %S take from the model; stored in workspace
B = (S ~= 0); %boolean version of stoichometric matrix

% Reaction adjancency matrix
A = double(B')*double(B);
len = length(S(1,:));
% reversibility vector
%R = double((model.lb<0)); %[0; 0; 0; 1; 0; 0; 0; 0];
R = double((model.rev));
r = diag(R);
Im = eye(len,len);
S2m_1 = [S -S];
S2m_2 = [Im zeros(len); zeros(len) r];
S2m = S2m_1*S2m_2;

%Production and consumption matrices
S2m_plus = 0.5.*(abs(S2m) + S2m);
S2m_minus = 0.5.*(abs(S2m) - S2m);

%Probabilistic flux graph
W_plus_penrose = (pinv(diag(S2m_plus*ones(2*len,1))));
W_minus_penrose = (pinv(diag(S2m_minus*ones(2*len,1))));

n = size(S(:,1)); %Number of metabolites
n = n(1);
P = (S2m_plus'*(W_plus_penrose*W_minus_penrose)*S2m_minus)/n;
end