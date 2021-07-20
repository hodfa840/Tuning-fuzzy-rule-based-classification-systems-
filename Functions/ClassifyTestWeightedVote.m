function [ PredictedClass ] = ClassifyTestWeightedVote( data , ReducedRulebase , numberOfClasses)
    
    MuMatrix = zeros(1,size(ReducedRulebase,1));
    for i=1:size(ReducedRulebase,1)
        MuMatrix(1,i) = MuRulePattern(data,ReducedRulebase(i,:));
    end
    w = zeros(numberOfClasses,1);
    for j=1:size(ReducedRulebase,1)
        w(ReducedRulebase(j,5)) = w(ReducedRulebase(j,5))+...
            MuMatrix(1,j) * ReducedRulebase(j,6);
    end
    [wMax,index] = max(w);
    if length(find(w == wMax))>1
        PredictedClass = 0;
        return;
    end
    PredictedClass = index;


end

