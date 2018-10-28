% Randomization

%i = 1;
for i=1:1000       
    disp(i)
    % Randomize the flux!
    %v_avg = 0;
    v_rand = v(randperm(length(v)));
    
    %for x = 1:10000
    %    v_rand = abs(v(randperm(length(v))));
    %    v_avg = (v_avg+v_rand);
    %end
    %v_avg = (v_avg+v_rand)/10000;
    % Assign flux sign at random
    %sign_vector = randi(2,3788,1);
    %sign_vector(find(sign_vector==2))=-1;
    
    %v_avg = v_avg.*sign_vector;
    
    %Run the MFG_cancer function
    M_random_v = MFG_cancer_sparse(model1, v_rand); %Though sending model1 seems redundant
    
    %Construct the graph
    G = digraph(M_random_v,'OmitSelfLoops');
    
    %Run the pagerank function
    page_rank_random_v = centrality(G,'pagerank','FollowProbability',0.85,'Importance',G.Edges.Weight);
    
    %Saving the files
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.08.06\Randomize"
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.08.06\Randomize",'\','Random_v_',string(i),'.mat');
    save(destination_path, 'model', 'model1', 'v_rand', 'page_rank_random_v', 'M_random_v', 'G', 'v');
    %save(destination_path, 'model', 'model1', 'v_rand');
    
    % Randomize the S matrix
    model2 = model1;
    model2.S = randomize_S(model2.S);
    M_random_S = MFG_cancer_sparse(model2, v);
    G1 = digraph(M_random_S,'OmitSelfLoops');
    page_rank_random_S = centrality(G1,'pagerank','FollowProbability',0.85,'Importance',G1.Edges.Weight);
    %Saving the files
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.08.06\Randomize"
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.08.06\Randomize",'\','Random_S_',string(i),'.mat');
    save(destination_path, 'model', 'model1', 'v', 'model2','page_rank_random_S', 'M_random_S', 'G1');
    %save(destination_path, 'model', 'model1', 'v_rand');
end
%i = i+1;