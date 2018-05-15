% Takes in an adjacency matrix of a directed network and
% makes it stochastic and ergodic with teleportation probability p.
% 
%
% Mariano Beguerisse
% Oct 15 2014

function B = getStochastic(A, p)

    N = size(A, 1);
    
    % get out-strengths
    sout = A*ones(N,1);
    
    % Dead-end nodes
    dangNodes = find(sout==0);
    sout(dangNodes) = 1;
    Atilde = diag(1./sout)*A;
    a = zeros(N,N);
    a(dangNodes,:) = 1;
    
    % Construct ergodic graph with uniform teleporting
    B = (1-p)*Atilde + ((1-p)*a + p)./N;
    
end
