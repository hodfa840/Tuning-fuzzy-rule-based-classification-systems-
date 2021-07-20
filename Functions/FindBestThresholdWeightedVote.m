function [ best_th , optimum] = FindBestThresholdWeightedVote( data , class , IScore , rulebase , index , MuMatrix , numberOfClasses)
    
    if isempty(IScore)
        best_th = 0;
        rulebase(index,6) = 0;
        predictedClasses = ClassifyWeightedVote(...
                data,rulebase,MuMatrix,numberOfClasses);
        optimum = sum(predictedClasses == class);
        return;
    end
    
    IScore = sort(IScore);
    best_th = 0;
    th = 0;
    rulebase(index,6) = th;
    predictedClasses = ClassifyWeightedVote(...
        data,rulebase,MuMatrix,numberOfClasses);
    current = sum(predictedClasses == class);
    optimum = current;
    
    

    if size(IScore,1)  >= 2
        combinations = nchoosek(IScore,2);
        for i = 1:size(combinations,1)
            th = combinations(i,1) + combinations(i,2);
            th = th/2;
            rulebase(index,6) = th;
            predictedClasses = ClassifyWeightedVote(...
                data,rulebase,MuMatrix,numberOfClasses);
            current = sum(predictedClasses == class);
            if current > optimum
                optimum = current;
                best_th = th;
            end
        end
    end
    
    th = IScore(length(IScore)) + 0.00001;
    rulebase(index,6) = th;
    predictedClasses = ClassifyWeightedVote(...
        data,rulebase,MuMatrix,numberOfClasses);
    current = sum(predictedClasses == class);
    if current > optimum
            optimum = current;
            best_th = th;
    end
    
    
end

