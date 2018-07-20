% This m-file will be used to plot heatmap

% Identify the desired csv file
[filename,pathname] = uigetfile(); 
file = strcat(pathname,filename);

% Read the csv file
data = csvread(file);

% Reorganize the data file according to reorganization of cell lines
[heatmap,new_cellname] = HeatmapRearrangement(data);

% Plot the heatmap
RowLabels = cellstr(new_cellname);
hm = clustergram(heatmap,'ColumnLabels', RowLabels, 'RowLabels',RowLabels,'Cluster','Column','Standardize',1);