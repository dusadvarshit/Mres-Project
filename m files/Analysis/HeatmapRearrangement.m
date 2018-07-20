%leukemia = find(celltype=='Leukemia');
%small_lung = find(celltype=='Non-Small Cell Lung');
%colon = find(celltype=='Colon');
%cns = find(celltype=='CNS');
%melanoma = find(celltype=='Melanoma');
%ovarian = find(celltype=='Ovarian');
%renal = find(celltype=='Renal');
%prostrate = find(celltype=='Prostate');
%breast = find(celltype=='Breast');
    
function [organized_heatmap,new_cellname] = HeatmapRearrangement(heatmap_original)
    % Rows rearrangement
    % , , , , , , , , 
    new_cellname = ["CCRF-CEM";"HL-60";"K-562";"MOLT-4";"RPMI-8226";"SR";"A549";"EKVX";"HOP-62";"HOP-92";"NCI-H226";"NCI-H23";"NCI-H322M";"NCI-H460";"NCI-H522";"COLO-205";"HCC2998";"HCT-116";"HCT-15";"HT29";"KM12";"SW620";"SF268";"SF295";"SF539";"SNB-19";"SNB-75";"U251";"LOXIMVI";"M14";"MALME-3M";"MDA-MB-435";"MDA-N";"SK-MEL-2";"SK-MEL-28";"SK-MEL-5";"UACC-257";"UACC-62";"IGROV-1";"NCI-ADR-RES";"OVCAR-3";"OVCAR-4";"OVCAR-5";"OVCAR-8";"SK-OV-3";"786";"A498";"ACHN";"CAKI-1";"RXF393";"SN12C";"TK10";"UO-31";"DU-145";"PC-3";"BT-549";"HS-578-T";"MCF7";"MDA-MB-231";"T47D"];
    new_cellindex = [7;14;20;29;41;53;3;10;15;16;31;32;33;34;35;8;11;12;13;18;21;54;43;44;45;51;52;57;22;23;24;27;28;46;47;48;58;59;19;30;36;37;38;39;49;1;2;4;6;42;50;56;60;9;40;5;17;25;26;55];
    new_heatmap = heatmap_original(new_cellindex,:);
    organized_heatmap = new_heatmap(:,new_cellindex);
end

