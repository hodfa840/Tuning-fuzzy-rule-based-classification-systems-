function [ rulebase ] = GenerateFuzzyRulesMaxL2( dataset )

    MaxRulelenght = 2;
    n = size(dataset,2)-1;
    data = dataset(:,1:n);
    class = dataset(:,n+1);
    
    rulbaseLenght = nchoosek(n,MaxRulelenght) * (14 ^ MaxRulelenght) + ...
        n * 14;
    
    a = {1:n , 1:14 , 1:n , 1:14};
    [x1,f1,x2,f2] = ndgrid(a{:});
    tmp1 = [x1(:) f1(:) x2(:) f2(:)];
    tmp2 = zeros(rulbaseLenght-n*14,4);
    index = 0;
    %removing same rules
    for i=1:size(tmp1,1)
        if tmp1(i,1) < tmp1(i,3)
            index = index + 1;
            tmp2(index,:) = tmp1(i,:);
        end
    end
    
    rulebase = [tmp2  zeros(rulbaseLenght-n*14,1) zeros(rulbaseLenght-n*14,1)];
    
    for i=1:rulbaseLenght - n * 14
        rulebase(i,:) = GenerateClassOfRuleL2(rulebase(i,:),data,class);
    end
    
    rulebase = rulebase(rulebase(:,6) == 1,:);

    tmp3 = GenerateFuzzyRulesMaxL1(dataset);
    tmp3 = [tmp3(:,1:2) zeros(size(tmp3,1),2) tmp3(:,3:4)];  
    rulebase = [rulebase ; tmp3];
end

