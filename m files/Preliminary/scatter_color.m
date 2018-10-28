% Function to choose color for scatter plot
function c = scatter_color(a,b)
    c = zeros(length(a),3);
    d = abs(a-b);
    for i=1:length(a)
        c(i,:) = [0 0.1 1];
        if d(i)>20
            c(i,:) = [0.8 0.3 0.1];
        end
    end
    
    
end