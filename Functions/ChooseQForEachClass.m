function [ newRulebase ] = ChooseQForEachClass( rulebase , data , class , Q)

    numberOfClasses = length(unique(class,'rows'));
    newRulebase = [];
    %sort by evaloation
    rulebase = sortrows(rulebase,size(rulebase,2)-1);
    evaluation = zeros(size(rulebase,1),1);
    
    for i=1:size(rulebase,1)
        evaluation(i) = EvaluateRule(rulebase(i,:),data,class);
    end
    
    rulebase = [rulebase evaluation];
    
    for i = 1 : numberOfClasses
        Group = rulebase(rulebase(:,size(rulebase,2)-2) == i,:);
        Group = sortrows(Group,-size(rulebase,2));
        if Q <= size(Group,1)
            newRulebase = [newRulebase ; Group(1:Q,:)];
        else
            newRulebase = [newRulebase ; Group];
        end
    end
    
    newRulebase = sortrows(newRulebase,-size(rulebase,2));
    newRulebase = newRulebase(:,1:size(rulebase,2)-1);
    
end

