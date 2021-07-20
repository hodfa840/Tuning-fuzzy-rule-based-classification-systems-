load SavedData/NormalizedGlass.data;
load SavedData/NormalizedWine.data;
load SavedData/ReducedGlass100.data;
load SavedData/ReducedWine100.data;
addpath Functions/;

dglass = NormalizedGlass(:,1:9);
cglass = NormalizedGlass(:,10);
dwine = NormalizedWine(:,1:13);
cwine = NormalizedWine(:,14);

[finalRulebaseGlassWV,accGlass,~] = OptimizationWeightedVote(ReducedGlass100,dglass,cglass);
[finalRulebaseWineWV,accWine,~] = OptimizationWeightedVote(ReducedWine100,dwine,cwine);

GlassAccNumberOfRulesWV = [accGlass(size(ReducedGlass100,1))*100 size(finalRulebaseGlassWV,1)];
WineAccNumberOfRulesWV = [accWine(size(ReducedWine100,1))*100 size(finalRulebaseWineWV,1)];

save SavedData/WineAccNumberOfRulesWV.data WineAccNumberOfRulesWV -ascii;
save SavedData/GlassAccNumberOfRulesWV.data GlassAccNumberOfRulesWV -ascii;
save SavedData/finalRulebaseGlassWV.data finalRulebaseGlassWV -ascii;
save SavedData/finalRulebaseWineWV.data finalRulebaseWineWV -ascii;
