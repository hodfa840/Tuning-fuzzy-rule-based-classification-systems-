load Dataset/glass.data; 
load Dataset/wine.data;
addpath Functions/;
%normalize
nglass = NormalizeDataset(glass);
nwine = NormalizeDataset(wine);


save SavedData/NormalizedGlass.data nglass -ascii;
save SavedData/NormalizedWine.data nwine -ascii;

RulebaseGlassInitial=GenerateFuzzyRulesMaxL2(nglass);
RulebaseWineInitial=GenerateFuzzyRulesMaxL2(nwine);

save SavedData/RulebaseGlassInitial.data RulebaseGlassInitial -ascii;
save SavedData/RulebaseWineInitial.data RulebaseWineInitial -ascii;
%=======

load SavedData/NormalizedGlass.data;
load SavedData/NormalizedWine.data;
load SavedData/RulebaseGlassInitial.data;
load SavedData/RulebaseWineInitial.data;

GlassData = NormalizedGlass(:,1:9);
GlassClass = NormalizedGlass(:,10);
WineData = NormalizedWine(:,1:13);
WineClass = NormalizedWine(:,14);

ReducedGlass40 = ChooseQForEachClass(RulebaseGlassInitial,...
    GlassData,GlassClass,40);
ReducedGlass100 = ChooseQForEachClass(RulebaseGlassInitial,...
    GlassData,GlassClass,100);
ReducedWine100 = ChooseQForEachClass(RulebaseWineInitial,...
    WineData,WineClass,100);

save SavedData/ReducedGlass40.data ReducedGlass40 -ascii;
save SavedData/ReducedGlass100.data ReducedGlass100 -ascii;
save SavedData/ReducedWine100.data ReducedWine100 -ascii;

%========
%
load SavedData/NormalizedGlass.data;
load SavedData/ReducedGlass40.data
addpath Functions/;

dglass = NormalizedGlass(:,1:9);
cglass = NormalizedGlass(:,10);

for i=1:3
    [finalRulebase,~,error_rate] = OptimizationSingleWinner(ReducedGlass40,dglass,cglass);
    x = linspace(i-1,i,size(ReducedGlass40,1));
    error_rate = error_rate';
    plot(x,error_rate);
    hold on;
    ReducedGlass40 = finalRulebase;
end

xlabel('iteration number');
ylabel('error rate');
title('Error-rate on training data with single winner reasoning method');

print -djpeg Figures/Error_rateSW.jpg;


save SavedData/FinalRuleBaseGlass40_3iterationsSW finalRulebase -ascii;


%======================
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
%=====================
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


%======================
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
%=========================
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
