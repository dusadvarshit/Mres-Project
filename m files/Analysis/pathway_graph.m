% Function to make pathway graph from MFG

function Pg = pathway_graph(model, G)
    t = table2cell(G.Edges); % Convert edges data from table into a cell.
    
    t1 = t(:,1); % Extracting the source and target nodes of all edges.
    w = zeros(length(t1),1); % Weight of all edges
    
    subsyslist = [model.subSystems; model.subSystems];
    
    t_1 = zeros(length(t1),2);
    
    for i=1:length(t1) 
        x = t1{i,:};
        t_1(i,1) = str2double(string(x{1,1}));
        t_1(i,2) = str2double(string(x{1,2}));
        w(i) = t{i,2};
    end

    t_2 = subsyslist(t_1);

    a = zeros(length(t1),2);
    
    % Identifying the subsystem id to make subsystem graph
    s = unique(string(model.subSystems));
    P = zeros(length(s));
    for i=1:length(t1)
        a(i,1) = find(s==t_2{i,1});
        a(i,2) = find(s==t_2{i,2});
    end

    s(1,1) = "####";
    
    % Constructing adjacency matrix for pathway graph
    for i=1:length(a)
        m = a(i,1);
        n = a(i,2);
        P(m,n) = P(m,n)+w(i);
    end
    
    % Constructing the digraph without removing the self loop
    Pg = digraph(P,cellstr(s));    

end