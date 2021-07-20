function [ score ] = ScoreWeightedVote( MuMatrix , rulebase , ruleindex , dataindex , numberOfClasses)
    
    Psi = zeros(numberOfClasses,1);
    sigma = 0;
    for i = 1:size(rulebase,1)
        if rulebase(i,5) ~= rulebase(ruleindex,5)
            Psi(rulebase(i,5)) = Psi(rulebase(i,5)) + ...
                rulebase(i,6) * MuMatrix(dataindex,i);
        else
            sigma = sigma + rulebase(i,6) * MuMatrix(dataindex,i);
        end
    end
    score = (max(Psi) - sigma)/MuMatrix(dataindex,ruleindex);


end

