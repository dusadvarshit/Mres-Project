clear all;
%initCobraToolbox;
folder = dir(uigetdir());
destination_folder = uigetdir();

R_2_M = zeros(60,1); % This will store pearson correlation coefficient for each cell line
R_2_pr = zeros(60,1); % This will store pearson correlation coefficient for each cell line 
R_2_p_r = zeros(60,1); % This will store pearson correlation coefficient for each cell line 

all_models = cell(length(folder)-2,1);
for i=3:(length(all_models)+2) 
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

for i=1:length(all_models)
    %Load the models.
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    %Run the MFG_cancer function
    M1 = MFG_cancer_sparse(model, v); 
    
    %Run the pagerank function
    G = digraph(M);
    pr = centrality(G,'pagerank','FollowProbability',0.85,'Importance',G.Edges.Weight);
    p_r = centrality(G,'pagerank','FollowProbability',0.85); % Without edge weight contribution.
    
    
    % Linearizing M and M1 matrices
     m = M(:);
     m1 = full(M1(:));
     
    % Calculating the pearson correlation coefficient 
    R = corrcoef(m,m1); % Between two MFG constructions
    R_2_M(i) = R(2,1);
    
    R = corrcoef(page_rank,pr); % Between our page_rank and matlab version
    R_2_pr(i) = R(2,1);
    
    R = corrcoef(page_rank,p_r); % Between our page_rank and matlab version without weights
    R_2_p_r(i) = R(2,1);
    
    % Scatter plots
    %Saving the files
    model_name = strsplit(folder(i+2).name,'.');
    destination_path = strcat(destination_folder,'\', model_name{1},'.mat');
    
    save(destination_path, 'model', 'model1', 'model2','v','R_2_M','R_2_pr','R_2_p_r', 'page_rank', 'M', 'pr', 'p_r', 'M1');
end

%i = i+1;

%changeCobraSolver('glpk','all');
%load(all_models{1});
%model1 = optimizeCbModel(model, 'max');