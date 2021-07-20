function [ ruleWithClass ] = GenerateClassOfRuleL2( rule , data , class)

    M = size(data,1);
    numberOfClasses = length(unique(class,'rows'));
    Confidences = zeros(numberOfClasses,1);
    %compute confidence of each class
    for i=1:numberOfClasses
        sum1 = 0;
        sum2 = 0;
        for j=1:M
            mu = MuRulePattern(data(j,:),rule);
            if class(j) == i
                sum1 = sum1 + mu;
            end
            sum2 = sum2 + mu;
        end
        Confidences(i) = sum1/sum2; 
    end
    
    m = max(Confidences);
    maxIndex = find(Confidences == m);
    
    if length(maxIndex) == 1
        rule(5) = maxIndex;
        rule(6) = 1;
    end

    ruleWithClass = rule;

end

