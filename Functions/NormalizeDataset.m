function [ normalizedDataset ] = NormalizeDataset( dataset )

    data = dataset(:,1:size(dataset,2)-1);
    for i=1:size(data,2)
        data(:,i) = (data(:,i) - min(data(:,i)))/...
            (max(data(:,i)) - min(data(:,i)));
    end
    normalizedDataset = [data dataset(:,size(dataset,2))];

end

