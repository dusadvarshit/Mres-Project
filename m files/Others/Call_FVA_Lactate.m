% This m-file will call FVA_Lactate_o2_identify.m after loading all the
% cancer models.
% The final results will be saved as mat files as well as exported in excel
% sheet.

folder = dir(uigetdir());

all_models = cell(60,1);
for i=3:62  
all_models{i-2} = strcat(folder(i).folder,'\',folder(i).name);
end

Lactate_min = zeros(60,1);
Lactate_max = zeros(60,1);
o2_flux = zeros(60,1);

for i =1:length(all_models)
    %Keeping count, displaying and loading model
    disp(i);
    disp(all_models{i});
    load(all_models{i});
    
    model1 = model;
    
    model1 = changeRxnBounds(model1,model.rxns(1372),-1,'b'); %L-Glutamine
    model1 = changeRxnBounds(model1,model.rxns(968),-5,'b'); % D-Glucose
    model1 = changeRxnBounds(model1,model.rxns(687),0.05,'b'); %D-Lactate release

    o2_uptake = [-12;-11;-10;-9.5;-9;-8.5;-8;-7.5;-7;-6.5;-6;-5.5;-5;-4.5;-4;-3.5;-3];
    
    Lactate_minimum = 0;
    Lactate_maximum = 0;
    o2_level = 0;
    
    for j = 1:length(o2_uptake)
    
    [Lactate_maximum, Lactate_minimum, o2_level] = FVA_Lactate_o2_identify(model1,o2_uptake(j));
    
    if Lactate_minimum>0
            disp(strcat('Lactate_minimum: ',string(Lactate_minimum)));    
            Lactate_min(i) = Lactate_minimum;
            Lactate_max(i) = Lactate_maximum;
            o2_flux(i) = o2_level;
            %disp(strcat('j:',string(j)));
            break
    end
    end
       
    destination_path = "C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today";
    destination_path = strcat("C:\Users\dusad\Downloads\M.res Systems and Synthetic Biology\Projects\Diego+Keun\Project work\Cancer models\Today",'\',folder(i+2).name);
    save(destination_path, 'model', 'model1', 'Lactate_minimum', 'Lactate_maximum', 'o2_level');
end

