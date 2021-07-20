function [ PredictedClasses ] = ClassifySingleWiner( data , ReducedRulebase , MuMatrix,numberOfClasses)

    PredictedClasses = zeros(size(data,1),1);
    
    for i=1:size(data,1)
        w = zeros(numberOfClasses,1);
        for j=1:size(ReducedRulebase,1)
            if(MuMatrix(i,j) * ReducedRulebase(j,6) > w(ReducedRulebase(j,5)))
                w(ReducedRulebase(j,5)) = MuMatrix(i,j) * ReducedRulebase(j,6);
            end
        end
        [wMax,index] = max(w);
        if length(find(w == wMax))>1
            PredictedClasses(i) = 0;
            continue;
        end
        PredictedClasses(i) = index;
    end

end

