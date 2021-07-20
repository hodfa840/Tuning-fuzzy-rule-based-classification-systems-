 load SavedData/NormalizedGlass.data;
load SavedData/NormalizedWine.data;
addpath Functions/;

GlassData = NormalizedGlass(:,1:9);
GlassClass = NormalizedGlass(:,10);
WineData = NormalizedWine(:,1:13);
WineClass = NormalizedWine(:,14);

MGlassData = size(GlassData,1);
MWineData = size(WineData,1);

finalRulebaseLengthSW = 0;
finalRulebaseLengthWV = 0;
accTestSW = 0;
accTestWV = 0;

for s = 1:MGlassData
    dglass = [GlassData(1:s-1,:) ; GlassData(s+1:MGlassData,:)];
    cglass = [GlassClass(1:s-1,:) ; GlassClass(s+1:MGlassData,:)];
    RulebaseGlassInitial = GenerateFuzzyRulesMaxL2([dglass cglass]);
    ReducedGlass100 = ChooseQForEachClass(RulebaseGlassInitial,...
    dglass,cglass,100);

    [finalRulebaseGlassSW,~,~] = ...
        OptimizationSingleWinner(ReducedGlass100,dglass,cglass);
    sclass = ClassifyTestSingleWinner(dglass(s,:),finalRulebaseGlassSW,6);
    if sclass == cglass(s)
        accTestSW = accTestSW + 1;
    end
    finalRulebaseLengthSW = finalRulebaseLengthSW + size(finalRulebaseGlassSW,1);
    
    [finalRulebaseGlassVW,~,~] = ...
        OptimizationWeightedVote(ReducedGlass100,dglass,cglass);
    sclass = ClassifyTestWeightedVote(dglass(s,:),finalRulebaseGlassVW,6);
    if sclass == cglass(s)
        accTestWV = accTestWV + 1;
    end
    finalRulebaseLengthWV = finalRulebaseLengthWV + size(finalRulebaseGlassVW,1);
end

accTestSW = (accTestSW / MGlassData) * 100;
finalRulebaseLengthSW = finalRulebaseLengthSW/MGlassData;
accTestWV = (accTestWV / MGlassData) * 100;
finalRulebaseLengthWV = finalRulebaseLengthWV/MWineData;

save SavedData/accTestGlassSW.data accTestSW -ascii;
save SavedData/numberOfRulesTestGlassSW.data finalRulebaseLengthSW -ascii;
save SavedData/accTestGlassWV.data accTestWV -ascii;
save SavedData/numberOfRulesTestGlassWV.data finalRulebaseLengthWV -ascii;

finalRulebaseLengthSW = 0;
finalRulebaseLengthWV = 0;
accTestSW = 0;
accTestWV = 0;

for s = 1:MWineData
    dwine = [WineData(1:s-1,:) ; WineData(s+1:MWineData,:)];
    cwine = [WineClass(1:s-1,:) ; WineClass(s+1:MWineData,:)];
    RulebaseWineInitial = GenerateFuzzyRulesMaxL2([dwine cwine]);
    ReducedWine100 = ChooseQForEachClass(RulebaseWineInitial,...
    dwine,cwine,100);

    [finalRulebaseWineSW,~,~] = ...
        OptimizationSingleWinner(ReducedWine100,dwine,cwine);
    sclass = ClassifyTestSingleWinner(dwine(s,:),finalRulebaseWineSW,3);
    if sclass == cwine(s)
        accTestSW = accTestSW + 1;
    end
    finalRulebaseLengthSW = finalRulebaseLengthSW + size(finalRulebaseWineSW,1);
    
    [finalRulebaseWineWV,~,~] = ...
        OptimizationWeightedVote(ReducedWine100,dwine,cwine);
    sclass = ClassifyTestWeightedVote(dwine(s,:),finalRulebaseWineWV,3);
    if sclass == cwine(s)
        accTestWV = accTestWV + 1;
    end
    finalRulebaseLengthWV = finalRulebaseLengthWV + size(finalRulebaseWineWV,1);
end

accTestSW = (accTestSW / MGlassData) * 100;
finalRulebaseLengthSW = finalRulebaseLengthSW/MWineData;
accTestWV = (accTestWV / MGlassData) * 100;
finalRulebaseLengthWV = finalRulebaseLengthWV/MWineData;

save SavedData/accTestWineSW.data accTestSW -ascii;
save SavedData/numberOfRulesTestWineSW.data finalRulebaseLengthSW -ascii;
save SavedData/accTestWineWV.data accTestWV -ascii;
save SavedData/numberOfRulesTestWineWV.data finalRulebaseLengthWV -ascii;