load SavedData/NormalizedGlass.data;
load SavedData/ReducedGlass40.data
addpath Functions/;

dglass = NormalizedGlass(:,1:9);
cglass = NormalizedGlass(:,10);

for i=1:3
    [finalRulebase,~,error_rate] = OptimizationWeightedVote(ReducedGlass40,dglass,cglass);
    x = linspace(i-1,i,size(ReducedGlass40,1));
    error_rate = error_rate';
    plot(x,error_rate);
    hold on;
    ReducedGlass40 = finalRulebase;
end

xlabel('iteration number');
ylabel('error rate');
title('Error-rate on training data with weighted vote reasoning method');

print -djpeg Figures/Error_rateVW.jpg;


save SavedData/FinalRuleBaseGlass40_3iterationsWV finalRulebase -ascii;


