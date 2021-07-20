function [ FinalRulebase , acc , error_rate ] = OptimizationWeightedVote( ReducedRulebase , data , class )

    acc = zeros(size(ReducedRulebase,1),1);
    error_rate = zeros(size(ReducedRulebase,1),1);
    MuMatrix = zeros(size(data,1),size(ReducedRulebase,1));
    numberOfClasses = length(unique(class,'rows'));
    
    for i=1:size(data,1)
        for j=1:size(ReducedRulebase,1)
            MuMatrix(i,j) = MuRulePattern(data(i,:),ReducedRulebase(j,:));
        end
    end
    
    for i=1:size(ReducedRulebase,1)
        
        ReducedRulebase(i,6) = 1000000;
        predictedClasses1 = ClassifyWeightedVote(data , ReducedRulebase , MuMatrix , numberOfClasses);
        RightPredictions1 = (predictedClasses1 == class);
        
        ReducedRulebase(i,6) = 0;
        predictedClasses2 = ClassifyWeightedVote(data , ReducedRulebase , MuMatrix , numberOfClasses);
        RightPredictions2 = (predictedClasses2 == class);
        
        RightInOneOfThem = abs(RightPredictions1 - RightPredictions2);
        
        IIndex = find(RightInOneOfThem == 1);
        IData = data(IIndex,:);
        IClass = class(IIndex);
        
        IScore = zeros(length(IClass),1);
        ii = 0;
        ReducedRulebase(i,6) = 0;
        for j = IIndex'
            ii = ii + 1;
            IScore(ii) = ScoreWeightedVote(MuMatrix,ReducedRulebase,i,j,numberOfClasses);
        end
        [bestCF,acc(i)] = FindBestThresholdWeightedVote(data, class, IScore,...
            ReducedRulebase, i , MuMatrix , numberOfClasses);
        
        ReducedRulebase(i,size(ReducedRulebase,2)) = bestCF;
        
        %accuracy
        acc(i) = acc(i)/length(class);
        error_rate(i) = (1 - acc(i)) * 100;
    end
    
    FinalRulebase = ReducedRulebase(ReducedRulebase(:,6) ~= 0 , :);

end

