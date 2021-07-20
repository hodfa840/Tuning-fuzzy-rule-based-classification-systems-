function [ rulebase ] = GenerateFuzzyRulesMaxL1( dataset )

    MaxRulelenght = 1;
    n = size(dataset,2)-1;
    data = dataset(:,1:n);
    class = dataset(:,n+1);
    % n= NO feature = 9 glass     13 wine
    rulbaseLenght = n * 14;
    rulebase = zeros(rulbaseLenght,2*MaxRulelenght + 2);
   
    a = {1:n , 1:14};
    [x,f] = ndgrid(a{:});
    rulebase(:,1:2) = [x(:) f(:)];
    
    for i=1:rulbaseLenght
        rulebase(i,:) = GenerateClassOfRuleL1(rulebase(i,:),data,class);
    end
    
    rulebase = rulebase(rulebase(:,4) == 1,:);

end

