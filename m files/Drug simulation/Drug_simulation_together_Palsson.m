%Drug simulation in one go!
%Drugs used: Methotrexate, Raltitrexed, Pemetrexed, Mercaptopurine,
%Thioguanine, Cladribine, Fludarabine, Clofarabine, Florouracil, Gemcitabine,
%Capecitabine, Hydroxyurea, Pentostatin

Methotrexate = {'DHFR';'r0512';'r0514'};
Raltitrexed = {'TMDS'};
Pemetrexed = {'TMDS';'DHFR';'r0512';'r0514';'GARFT'};
Mercaptopurine = {'GLUPRT'};
Thioguanine = {'IMPD'};
Cladribine = {'RNDR1';'RNDR3';'RNDR4';'RNDR2';'DADA';'DADAe';'ADAe';'ADA'};
Fludarabine = {'RNDR1';'RNDR3';'RNDR4';'RNDR2'};
Clofarabine = {'RNDR1';'RNDR3';'RNDR4';'RNDR2'};
Florouracil = {'TMDS'};
Gemcitabine = {'TMDS'};
Capecitabine = {'TMDS'};
Hydroxyurea = {'RNDR1';'RNDR3';'RNDR4';'RNDR2' };
Pentostatin = {'DADA';'DADAe';'ADAe';'ADA'};
Allopurinol = {'XAO2x';'XAOx'};

% Reaching the desired models
folder = dir(uigetdir());
all_models = cell(60,1);
for i=3:20  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end
clear i;

cellLine = cell(60,1);
v_NoDrug = zeros(60,1);
v_Methotrexate = zeros(60,1);
v_Raltitrexed = zeros(60,1);
v_Pemetrexed = zeros(60,1);
v_Mercaptopurine = zeros(60,1);
v_Thioguanine = zeros(60,1);
v_Cladribine = zeros(60,1);
v_Fludarabine = zeros(60,1);
v_Clofarabine = zeros(60,1);
v_Florouracil = zeros(60,1);
v_Gemcitabine = zeros(60,1);
v_Capecitabine = zeros(60,1);
v_Hydroxyurea = zeros(60,1);
v_Pentostatin = zeros(60,1);
v_Allopurinol = zeros(60,1);

% The loop over all NCI-60 models and all drugs simulation
for i =1:length(all_models)
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    cellLine{i} = folder(i+2).name;
    
    model1 = model;
    
    % Media simulation
    model1 = changeRxnBounds(model1,media,media_lb,'l');
    % The default conditions for model simulations. No fixation of oxygen
    model1 = changeRxnBounds(model1,'EX_gln_L(e)',-0.5,'b'); %L-Glutamine -1
    model1 = changeRxnBounds(model1,'EX_glc(e)',-1.5,'b'); % D-Glucose -5
    model1 = changeRxnBounds(model1,'EX_lac_L(e)',2,'b'); %D-Lactate release
    
    % Control optimization: No drug based knockout
    model2 = optimizeCbModel(model1,'max');
    %v_NoDrug(i) = model2.v(3745);
    
    % Methotrexate knockout
    model_Methotrexate = changeRxnBounds(model1,Methotrexate,zeros(length(Methotrexate),1),'b'); 
    Methotrexate_sol = optimizeCbModel(model_Methotrexate,'max');
    v_Methotrexate(i) = Methotrexate_sol.v(3745);
    
    % Raltitrexed knockout
    model_Raltitrexed = changeRxnBounds(model1,Raltitrexed,zeros(length(Raltitrexed),1),'b'); 
    Raltitrexed_sol = optimizeCbModel(model_Raltitrexed,'max');
    v_Raltitrexed(i) = Raltitrexed_sol.v(3745);
    
    % Pemetrexed knockout
    model_Pemetrexed = changeRxnBounds(model1,Pemetrexed,zeros(length(Pemetrexed),1),'b'); 
    Pemetrexed_sol = optimizeCbModel(model_Pemetrexed,'max');
    v_Pemetrexed(i) = Pemetrexed_sol.v(3745);
    
    % Mercaptopurine knockout
    model_Mercaptopurine = changeRxnBounds(model1,Mercaptopurine,zeros(length(Mercaptopurine),1),'b'); 
    Mercaptopurine_sol = optimizeCbModel(model_Mercaptopurine,'max');
    v_Mercaptopurine(i) = Mercaptopurine_sol.v(3745);
    
    % Thioguanine knockout
    model_Thioguanine = changeRxnBounds(model1,Thioguanine,zeros(length(Thioguanine),1),'b'); 
    Thioguanine_sol = optimizeCbModel(model_Thioguanine,'max');
    v_Thioguanine(i) = Thioguanine_sol.v(3745);
    
    % Cladribine knockout
    model_Cladribine = changeRxnBounds(model1,Cladribine,zeros(length(Cladribine),1),'b'); 
    Cladribine_sol = optimizeCbModel(model_Cladribine,'max');
    v_Cladribine(i) = Cladribine_sol.v(3745);
    
    % Fludarabine knockout
    model_Fludarabine = changeRxnBounds(model1,Fludarabine,zeros(length(Fludarabine),1),'b'); 
    Fludarabine_sol = optimizeCbModel(model_Fludarabine,'max');
    v_Fludarabine(i) = Fludarabine_sol.v(3745);
    
    % Clofarabine knockout
    model_Clofarabine = changeRxnBounds(model1,Clofarabine,zeros(length(Clofarabine),1),'b'); 
    Clofarabine_sol = optimizeCbModel(model_Clofarabine,'max');
    v_Clofarabine(i) = Clofarabine_sol.v(3745);
    
    % Florouracil knockout
    model_Florouracil = changeRxnBounds(model1,Florouracil,zeros(length(Florouracil),1),'b'); 
    Florouracil_sol = optimizeCbModel(model_Florouracil,'max');
    v_Florouracil(i) = Florouracil_sol.v(3745);
    
    % Gemcitabine knockout
    model_Gemcitabine = changeRxnBounds(model1,Gemcitabine,zeros(length(Gemcitabine),1),'b'); 
    Gemcitabine_sol = optimizeCbModel(model_Gemcitabine,'max');
    v_Gemcitabine(i) = Gemcitabine_sol.v(3745);
    
    % Capecitabine knockout
    model_Capecitabine = changeRxnBounds(model1,Capecitabine,zeros(length(Capecitabine),1),'b'); 
    Capecitabine_sol = optimizeCbModel(model_Capecitabine,'max');
    v_Capecitabine(i) = Capecitabine_sol.v(3745);
    
    % Hydroxyurea knockout
    model_Hydroxyurea = changeRxnBounds(model1,Hydroxyurea,zeros(length(Hydroxyurea),1),'b'); 
    Hydroxyurea_sol = optimizeCbModel(model_Hydroxyurea,'max');
    v_Hydroxyurea(i) = Hydroxyurea_sol.v(3745);
    
    % Pentostatin knockout
    model_Pentostatin = changeRxnBounds(model1,Pentostatin,zeros(length(Pentostatin),1),'b'); 
    Pentostatin_sol = optimizeCbModel(model_Pentostatin,'max');
    v_Pentostatin(i) = Pentostatin_sol.v(3745);
    
    % Allopurinol knockout: Not a cancer drug!
    model_Allopurinol = changeRxnBounds(model1,Allopurinol,zeros(length(Allopurinol),1),'b'); 
    Allopurinol_sol = optimizeCbModel(model_Allopurinol,'max');
    v_Allopurinol(i) = Allopurinol_sol.v(3745);
end

filename = 'C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\2018.06.13\Drugs Simulation Together\biomass_comparison_2.xls';

% Writing the comparison result in excel sheet.
xlswrite(filename,{'CellLine','NoDrug','Methotrexate','Raltitrexed', 'Pemetrexed', 'Mercaptopurine','Thioguanine', 'Cladribine', 'Fludarabine', 'Clofarabine', 'Florouracil', 'Gemcitabine','Capecitabine', 'Hydroxyurea', 'Pentostatin','Allopurinol'},'Biomass defect','A1');
xlswrite(filename,cellLine,'Biomass defect','A2');
xlswrite(filename,v_NoDrug,'Biomass defect','B2');
xlswrite(filename,v_Methotrexate,'Biomass defect','C2');
xlswrite(filename,v_Raltitrexed,'Biomass defect','D2');
xlswrite(filename,v_Pemetrexed,'Biomass defect','E2');
xlswrite(filename,v_Mercaptopurine,'Biomass defect','F2');
xlswrite(filename,v_Thioguanine,'Biomass defect','G2');
xlswrite(filename,v_Cladribine ,'Biomass defect','H2');
xlswrite(filename,v_Fludarabine,'Biomass defect','I2');
xlswrite(filename,v_Clofarabine,'Biomass defect','J2');
xlswrite(filename,v_Florouracil ,'Biomass defect','K2');
xlswrite(filename,v_Gemcitabine ,'Biomass defect','L2');
xlswrite(filename,v_Capecitabine,'Biomass defect','M2');
xlswrite(filename,v_Hydroxyurea,'Biomass defect','N2'); 
xlswrite(filename,v_Pentostatin,'Biomass defect','O2'); 
xlswrite(filename,v_Allopurinol,'Biomass defect','P2'); 
