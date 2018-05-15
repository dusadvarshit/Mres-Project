% Compares change in flux (delta flux) to change in pagerank
% percentile

close all, clear all
load 'MFG_data_WT_PH1.mat'

pr_TOL = 20;  % plot reactions whose percentiles change more than
              % this
df_TOL = 100; % Same for delta f

figure
%subplot(1,2,1)
hold on

for k=1:2592
    df = -DeltaFlux(k);
    
    f = percentilechange(k);
    
    r_index = find(reverseof==k);
    
    if isempty(r_index)
        if (abs(f)>=pr_TOL) || (abs(df)>=df_TOL)
            plot(df, f, 's', 'MarkerEdgeColor', [43 131 186]./255, ...
                 'MarkerFaceColor', [215 25 28]./255, 'MarkerSize', ...
                 10, 'LineWidth', 1.5);
            %text(df, f, Label{k}, 'interpreter', 'none', 'FontSize', ...
            text(df, f, 'aa', 'interpreter', 'none', 'FontSize', ...
                 14, 'FontName', 'Arial')
        else
            %scatter(df, f, 20, f, 'filled');
        end
    else
        r = percentilechange(r_index);
        if (max(abs(r), abs(f))>=pr_TOL) || (abs(df)>=df_TOL)
            plot([df df], [f r], 'Color', [153 153 153]./255, ...
                 'LineWidth', 1.5);
            plot(df, f, '>', 'MarkerEdgeColor', [43 131 186]./255, ...
                 'MarkerFaceColor', [43 131 186]./255, 'MarkerSize', 10);
            plot(df, r, '<', 'MarkerEdgeColor', [215 25 28]./255, ...
                 'MarkerFaceColor', [215 25 28]./255, 'MarkerSize', 10);
            v = [r f];
            [m in] = max(abs(v));
%            text(df, v(in), Label{k}, 'interpreter', 'none', ...
            text(df, v(in), 'aa', 'interpreter', 'none', ...
                 'FontSize', 14, 'FontName', 'Arial')
        else
            %scatter(df, f, 20, f, 'filled');
            %scatter(df, r, 20, r, 'filled');
        end
        
    end
end


ind = intersect(find(percentilechange<20), find(abs(DeltaFlux)<100));
scatter(-DeltaFlux(ind), percentilechange(ind), 20,  percentilechange(ind), ...
        'filled')

% Inverted axes so that more reactions that became more central go
% up
set(gca,'YDir','Reverse')

xlabel('Average flux difference between WT and PH1')
ylabel('Change in pagerank percentile from WT to PH1')
grid on
box on
title(['Change in percetile is more than ' num2str(pr_TOL) ' or ' ...
                    'change in flux is more than ' num2str(df_TOL)])

set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 16);


% % Change in pr percentile
% subplot(1,2,2)

% scatter(percentileWT, percentilePH1, 30, percentilechange, ...
%         'filled');
% set(gca,'XDir','Reverse')
% set(gca,'YDir','Reverse')
% axis([0 100 0 100])

% xlabel('Pagerank percentile in WT');
% ylabel('Pagerank percentile in PH1');
% colormap jet
% %colorbar
% hold on

% sr = sort(abs(percentilechange), 'descend');
% ind_c = find(abs(percentilechange)>=sr(pr_TOL));
% for k=1:numel(ind_c)
%     text(percentileWT(ind_c(k)), percentilePH1(ind_c(k)), Label{ind_c(k)}, ...
%          'Interpreter', 'none', 'FontSize', 13, 'FontName', 'Arial');
% end


% set(gca, 'FontName', 'Arial');
% set(gca, 'FontSize', 13);

% grid on
% box on