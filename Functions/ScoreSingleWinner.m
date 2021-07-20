function [ score ] = ScoreSingleWinner( MuMatrix , rulebase , ruleindex , dataindex)
% by formula 12 and 13
    MaxFi = 0;
    for i = 1:size(rulebase,1)
        if rulebase(i,5) ~= rulebase(ruleindex,5)
            Fi = rulebase(i,6) * MuMatrix(dataindex,i);
            if Fi > MaxFi
                MaxFi = Fi;
            end
        end
    end
    score = MaxFi / MuMatrix(dataindex,ruleindex);

end

