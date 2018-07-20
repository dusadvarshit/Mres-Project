% This m-file is to calculate percentile of the important reactions
function [percentile] = calculate_percentile(pr_1)
A = unique(pr_1);

percentile = zeros(length(pr_1),1);
frequency = ones(length(pr_1),1);
for i=1:length(A)
    common = find(pr_1==A(i));
    frequency(common) = length(common);
end

for i = 1:length(pr_1)
    B = length(find(pr_1<pr_1(i)));
    percentile(i) = 100*(B+0.5*frequency(i))/length(pr_1);
end
check_percentile = zeros(length(pr_1),1);
for i = 1:length(pr_1)
    Y = prctile(pr_1,percentile(i));
    if abs(Y - pr_1(i))<0.00001
        check_percentile(i) = 1;
    else
        problem_index(i) = i;
    end
end
%problem_index = problem_index';

if isequal(check_percentile,ones(length(pr_1),1))
    disp('All percentiles are correct!');
else
    disp('Warning: Something wrong with pagerank percentile calculation!');
end

end
