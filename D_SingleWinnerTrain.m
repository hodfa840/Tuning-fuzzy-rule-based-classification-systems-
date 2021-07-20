load SavedData/NormalizedGlass.data;
load SavedData/NormalizedWine.data;
load SavedData/ReducedGlass100.data;
load SavedData/ReducedWine100.data;
addpath Functions/;

dglass = NormalizedGlass(:,1:9);
cglass = NormalizedGlass(:,10);
dwine = NormalizedWine(:,1:13);
cwine = NormalizedWine(:,14);

[finalRulebaseGlassSW,accGlass,~] = OptimizationSingleWinner(ReducedGlass100,dglass,cglass);
[finalRulebaseWineSW,accWine,~] = OptimizationSingleWinner(ReducedWine100,dwine,cwine);

GlassAccNumberOfRulesSW = [accGlass(size(ReducedGlass100,1))*100 size(finalRulebaseGlassSW,1)];
WineAccNumberOfRulesSW = [accWine(size(ReducedWine100,1))*100 size(finalRulebaseWineSW,1)];

save SavedData/WineAccNumberOfRulesSW.data WineAccNumberOfRulesSW -ascii;
save SavedData/GlassAccNumberOfRulesSW.data GlassAccNumberOfRulesSW -ascii;
save SavedData/finalRulebaseGlassSW.data finalRulebaseGlassSW -ascii;
save SavedData/finalRulebaseWineSW.data finalRulebaseWineSW -ascii;
