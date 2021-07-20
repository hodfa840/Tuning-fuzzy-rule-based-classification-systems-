function [ e ] = EvaluateRule( rule , data , class )
% by 18 foemula in paper
% sigma (mio Xp){ movafegh} - sigma (mio Xp) {mokhalef}
    M = size(data,1);
    
    sum1 = 0;
    sum2 = 0;
    for i=1:M
        if rule(length(rule) - 1) == class(i)
            sum1 = sum1 + MuRulePattern(data(i,:),rule);
        else
            sum2 = sum2 + MuRulePattern(data(i,:),rule);
        end
    end
      % 
    e = sum1 - sum2;

end

