% Computes the pagerank of the nodes of a network
%
% Mariano Beguerisse
% 5 August 2015

function v = pagerank(A, varargin)

% teleportation probability
p = 0.15;

% Update p
nVarargs = length(varargin);
if nVarargs > 0
    p = varargin{1};
end

B = getStochastic(A, p);

% eigenvalues of the transition matrix
[V,D] = eigs(B');
D = diag(D);
maxEval = max(D);
rmaxEval = find(D==maxEval);

v = V(:,rmaxEval)./(sum(V(:,rmaxEval)));

    