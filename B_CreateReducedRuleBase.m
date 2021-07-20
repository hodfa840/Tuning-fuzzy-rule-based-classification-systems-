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

