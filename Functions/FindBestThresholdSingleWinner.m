function [ best_th , optimum] = FindBestThresholdSingleWinner( data , class , IScore , rulebase , index , MuMatrix,numberOfClasses)
    % if set of i is not empty  then ... 
    if isempty(IScore)
        best_th = 0;
        % index 6= cf
        rulebase(index,6) = 0;
        predictedClasses = ClassifySingleWiner(...
                data,rulebase,MuMatrix,numberOfClasses);
            % optimum= accuracy
        optimum = sum(predictedClasses == class);
        return;
    end
    
    IScore = sort(IScore);
    best_th = 0;
    th = 0;
    rulebase(index,6) = th;
    predictedClasses = ClassifySingleWiner(...
        data,rulebase,MuMatrix,numberOfClasses);
    current = sum(predictedClasses == class);
    
    optimum = current;
   

    if size(IScore,1)  >= 2
        combinations = nchoosek(IScore,2);
        for i = 1:size(combinations,1)
            th = combinations(i,1) + combinations(i,2);
            th = th/2;
            rulebase(index,6) = th;
            predictedClasses = ClassifySingleWiner(...
                data,rulebase,MuMatrix,numberOfClasses);
            current = sum(predictedClasses == class);
            %''''''';;;;;;''''' 
            if current > optimum
                optimum = current;
                best_th = th;
            end
        end
    end
    % t= 0.00001
    th = IScore(length(IScore)) + 0.00001;
    rulebase(index,6) = th;
    predictedClasses = ClassifySingleWiner(...
        data,rulebase,MuMatrix,numberOfClasses);
    current = sum(predictedClasses == class);
    if current > optimum
            optimum = current;
            best_th = th;
    end
    
    
end

