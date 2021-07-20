function [ FinalRulebase , acc , error_rate ] = OptimizationSingleWinner( ReducedRulebase , data , class )

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
        
        ReducedRulebase(i,6) = 100000;
        predictedClasses1 = ClassifySingleWiner(data , ReducedRulebase , MuMatrix,numberOfClasses);
        RightPredictions1 = (predictedClasses1 == class);
        
        ReducedRulebase(i,6) = 0;
        predictedClasses2 = ClassifySingleWiner(data , ReducedRulebase , MuMatrix,numberOfClasses);
        RightPredictions2 = (predictedClasses2 == class);
        
        RightInOneOfThem = abs(RightPredictions1 - RightPredictions2);
        % find by index
        IIndex = find(RightInOneOfThem == 1);
        IData = data(IIndex,:);
        IClass = class(IIndex);
        % calculate score
        IScore = zeros(length(IClass),1);
        ii = 0;
        for j = IIndex'
            ii = ii + 1;
            IScore(ii) = ScoreSingleWinner(MuMatrix,ReducedRulebase,i,j);
        end
        [bestCF,acc(i)] = FindBestThresholdSingleWinner(data, class, IScore,...
            ReducedRulebase, i , MuMatrix,numberOfClasses);
        
        ReducedRulebase(i,size(ReducedRulebase,2)) = bestCF;
        
        %accuracy
        acc(i) = acc(i)/length(class);
        error_rate(i) = (1 - acc(i)) * 100;
    end
    
    FinalRulebase = ReducedRulebase(ReducedRulebase(:,6) ~= 0 , :);

end

