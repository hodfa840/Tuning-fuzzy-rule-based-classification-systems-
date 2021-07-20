function [ acc , newDataClassScore ] = GetClassificationAccWithTh( IData , IClass , T , th , rulebase , i)

    Size1 = size(DataClassScore,1);
    Size2 = size(DataClassScore,2);
    newDataClassScore = DataClassScore;
    
    
    
    acc = 0;
    for i=1:Size1
       if  DataClassScore(i,Size2-1) < th
           if DataClassScore(i,Size2 - 2) == T
               acc = acc + 1;
               newDataClassScore(i,Size2) = 1;
           end
       else
           if DataClassScore(i,Size2 - 2) ~= T
               acc = acc + 1;
               newDataClassScore(i,Size2) = 1;
           end
       end
    end
    
    acc = acc/Size1;

end

