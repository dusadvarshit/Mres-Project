% This m-file is used to compare the FBA soltions from 3 major solvers
% glpk, gurobi and cplex. Load the model before running code

changeCobraSolver('glpk','all')
clc
%model = changeRxnBounds(model,'EX_glc(e)',-10,'l');
%model = changeRxnBounds(model,'EX_o2(e)',-20,'l');
[sampleStruct,mixedFrac] = gpSampler(model,5000,[],120);
clc
v_glpk = zeros(3788,1);
for i = 1:3788
v_glpk(i) = mean(sampleStruct.points(i,:));
end
model1 = optimizeCbModel(model,'max');
changeCobraSolver('ibm_cplex','all')
clc
[sampleStruct,mixedFrac] = gpSampler(model,5000,[],120);
clc
v_cplex = zeros(3788,1);
for i = 1:3788
v_cplex(i) = mean(sampleStruct.points(i,:));
end
clc
changeCobraSolver('Gurobi','all')
clc
[sampleStruct,mixedFrac] = gpSampler(model,5000,[],120);
clc
v_gurobi = zeros(3788,1);
for i = 1:3788
v_gurobi(i) = mean(sampleStruct.points(i,:));
end
clc

check_absolute = [v_glpk v_cplex v_gurobi]; %Observe absolute value of fluxes
check_difference = [(v_glpk-v_cplex) (v_glpk-v_gurobi)  (v_cplex-v_gurobi)]; %Observe difference in value of fluxes
