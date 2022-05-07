function new_set = Daniljuk_Mihhail_New_Set(new)
    
    % Aggregating weights to use them as a probabilistic distribution
    for i=2:size(new,1)
        new(i,4) = new(i,4) + new(i-1,4);
    end
    
    % Generating random numbers
    randNums = rand(size(new,1), 1);
    
    % Generating a new dataset according to probabilistic distribution 
    for j = 1:size(new,1)
        elem_IDX = min(find(new(:,4) >= randNums(j))); 
        new_set(j,:) = new(elem_IDX, :);
    end
end