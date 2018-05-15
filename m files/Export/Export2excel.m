clear all;

%initCobraToolbox;
load('C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\reaction_names_formulas.mat')
folder_exl = dir(uigetdir());

list_models = cell(length(folder_exl)-2,1);
for i=3:length(folder_exl)
    list_models{i-2} = strcat(folder_exl(i).folder,'\',folder_exl(i).name);
end

    
for k=1:length(folder_exl)-2
    %Load the models.
    disp(k);
    disp(list_models{k});
    load(list_models{k});
    filename = 'C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today';
    remove_mat_extension = length(folder_exl(k+2).name)-3;
    filename = strcat(filename,'\',folder_exl(k+2).name(1:remove_mat_extension),'xlsm')
    index = find(min(page_rank));
    indices = find(page_rank>page_rank(index));
   
    rxns_1 = {};
    rxnNames_1 = {};
    subSystems_1 = {};
    page_rank_1 = [];
    v_1 = [];
    index_1 = [];
    reaction_formulas_1 = {};
    reaction_names_1 = {};
    
    rxns_2 = {};
    rxnNames_2 = {};
    subSystems_2 = {};
    page_rank_2 = [];
    v_2 = [];
    index_2 = [];
    reaction_formulas_2 = {};
    reaction_names_2 = {};
    
    backward_index = length(find(find(page_rank>page_rank(index))<3788));
    for j=1:length(indices)
        if indices(j)<=3788
            %disp(indices(i))
            rxns_1(j) = model.rxns(indices(j));
            rxnNames_1(j) = model.rxnNames(indices(j));
            %subSystems_1(j) = erase(model.subSystems{indices(j)},"'");
            subSystems_1(j) = cellstr(model.subSystems{indices(j)});
            page_rank_1(j) = page_rank(indices(j));
            v_1(j) = v(indices(j));
            index_1(j) = indices(j);
            reaction_formulas_1(j) = reaction_formulas{indices(j)};
            reaction_names_1(j) = reaction_names{indices(j)};
    
        elseif indices(j)>3788
            rxns_2(j-backward_index) = model.rxns(indices(j)-3788);
            rxnNames_2(j-backward_index) = model.rxnNames(indices(j)-3788);
            %subSystems_2(j-backward_index) = erase(model.subSystems{indices(j)-3788},"'");
            subSystems_2(j-backward_index) = cellstr(model.subSystems{indices(j)-3788});
            page_rank_2(j-backward_index) = page_rank(indices(j));
            v_2(j-backward_index) = v(indices(j)-3788);
            index_2(j-backward_index) = indices(j);
            reaction_formulas_2(j-backward_index) = reaction_formulas{indices(j)-3788};
            reaction_names_2(j-backward_index) = reaction_names{indices(j)-3788};
        end            
    end    
    % Write the sheet forward
    empty = [""];
    xlswrite(filename,{'rxns','rxnNames','subSystems','page_rank','v','index','','reaction_formulas', 'reaction_names'},'Forward','A1');
    xlswrite(filename,rxns_1','Forward','A2');
    xlswrite(filename,rxnNames_1','Forward','B2');
    xlswrite(filename,subSystems_1','Forward','C2');
    xlswrite(filename,page_rank_1','Forward','D2');
    xlswrite(filename,v_1','Forward','E2');
    xlswrite(filename,index_1','Forward','F2');
    xlswrite(filename,empty,'Forward','G2');
    xlswrite(filename,reaction_formulas_1','Forward','H2');
    xlswrite(filename,reaction_names_1','Forward','I2');
    
    % Write the sheet backward
    xlswrite(filename,{'rxns','rxnNames','subSystems','page_rank','v','index','','reaction_formulas', 'reaction_names'},'Backward','A1');
    xlswrite(filename,rxns_2','Backward','A2');
    xlswrite(filename,rxnNames_2','Backward','B2');
    xlswrite(filename,subSystems_2','Backward','C2');
    xlswrite(filename,page_rank_2','Backward','D2');
    xlswrite(filename,v_2','Backward','E2');
    xlswrite(filename,index_2','Backward','F2');
    xlswrite(filename,empty,'Backward','G2');
    xlswrite(filename,reaction_formulas_2','Backward','H2');
    xlswrite(filename,reaction_names_2','Backward','I2');

end 
