% This m-file will identify the oxygen level where minimum lactate
% secretion for each cell line becomes positive.
% The oxygen level will start from -8 and will step down to -4 in steps of
% 1 and from 4 to 0 in steps of 0.5

function [v1,v2,o2_level] =FVA_Lactate_o2_identify(model1,o2_flux)

    
    model1 = changeRxnBounds(model1,model1.rxns(3446),o2_flux,'b');
    model2 = optimizeCbModel(model1,'max');
    
    % Change of Objective function
    model3 = changeObjective(model1,model1.rxns(941));
    model3 = changeRxnBounds(model3,model1.rxns(3745),model2.v(3745),'b');
    
    % Flux variability analysis
    model4 = optimizeCbModel(model3,'max');
    model5 = optimizeCbModel(model3,'min'); 
    
    disp(strcat('o2_case:',string(o2_flux))); 

    % Assigning the values to variables
    v1 = model4.v(941);
    v2 = model5.v(941);
    o2_level = o2_flux;
  
       
end
