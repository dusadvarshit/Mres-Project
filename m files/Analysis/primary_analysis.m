% This m-file will be for primary exploratory analysis. The codes will also
% be divided into sections. New derivitive m-files may be written based on
% this m-file as needed.

%% Loading the files
% File 1
[filename,pathname] = uigetfile();
file_1 = strcat(pathname,filename);

% File 2
[filename,pathname] = uigetfile();
file_2 = strcat(pathname,filename);

%% Getting relative pagerank and flux differences
% _1,_2 correspond to order of file_1 and file_2
% v_diff(j) = (v2m_1(j)-v2m_2(j))./(v2m_1(j)+v2m_2(j)); For every j
% j for which where v2m_1(j) = v2m_2(j) = 0 ==> v_diff(j) = 0
% page_rank_diff = page_rank_1-page_rank_2;
% page_rank_diff = page_rank_diff./(page_rank_1+page_rank_2);

[page_rank_1, page_rank_2, v2m_1, v2m_2, page_rank_diff, v_diff, M_1, M_2,direction,rxnlist, rxnNameslist, subSystemslist] = relative_pagerank_flux_difference(file_1,file_2);

%% Identify Important Reactions: Reactions with pagerank greater than minimum pagerank
[pr_1,indices_1] = important_reactions(page_rank_1);

[pr_2,indices_2] = important_reactions(page_rank_2);

%% Calculate the percentiles of the important reactions
percentile_1 = calculate_percentile(pr_1);

percentile_2 = calculate_percentile(pr_2);

%% Identifying common reactions among "Important reactions"
common_reactions = intersect(indices_1,indices_2);

%% Plotting begins
sc = scatter(v_diff,page_rank_diff);
hold on
ax = gca;
dummy_x = [-1:0.05:1];
dummy_y = [-1:0.05:1];
plot(dummy_x,dummy_y);
grid on 
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% Graph labelling
title('BT-549: Relative Flux and Pagerank differencess'); % string(inputdlg('Enter the graph title')) <Request for user input and title the graph.>
xlabel('Relative flux difference');
ylabel('Relative pagerank difference');
legend('scatter', 'y = x','Location','southeast')

% Realigning the axis labels. Be careful as they are not dynamic and avoid
% resizing the shape of figures.
vec_pos = get(get(gca, 'XLabel'), 'Position');
set(get(gca, 'XLabel'), 'Position', vec_pos + [-0.5 -1.2 0]);

vec_pos = get(get(gca, 'YLabel'), 'Position');
set(get(gca, 'YLabel'), 'Position', vec_pos + [-0.5 0 0]);
hold off

%% Some analysis on previously plotted relative pagerank flux differences
temp_index = find(page_rank_diff>0 & v_diff<0); % Second quadrant

%% Pagerank percentile change vs absolute flux differences.

%% Angular distance between pagerank vector.

%% Angular distance between flux activation vector and subsystem activation vector.

%% Network analysis
%% Top k important nodes based on pagerank


%% Reactions with non zero flux but low importance


%% 



