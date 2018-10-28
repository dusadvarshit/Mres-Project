% Return only in original reaction id terms i.e. no rxnid >3788
function return_labels = return_original_node_no(H)
    a = H.Nodes.Name;
    return_labels = str2double(string(a));
    return_labels(find(return_labels>3788)) = return_labels(find(return_labels>3788)) -3788;
end