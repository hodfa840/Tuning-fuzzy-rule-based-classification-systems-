function [ mu ] = MuRulePattern( pattern , rule )
% triangle 
    if length(rule) == 4
        mu = Mu(pattern(rule(1)),rule(2));
    elseif length(rule) == 6
        if rule(3) == 0 
            mu = Mu(pattern(rule(1)),rule(2));
        else
            mu = Mu(pattern(rule(1)),rule(2)) * ...
                Mu(pattern(rule(3)),rule(4));
        end
    end

end

