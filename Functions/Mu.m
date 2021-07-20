function [ mu ] = Mu( data , fuzzySetNum )

    switch fuzzySetNum
        case 1
            mu = Triangle(data,0,0,1);
        case 2
            mu = Triangle(data,0,1,1);
        case 3
            mu = Triangle(data,0,0,1/2);
        case 4
            mu = Triangle(data,0,1/2,1);
        case 5
            mu = Triangle(data,1/2,1,1);
        case 6
            mu = Triangle(data,0,0,1/3);
        case 7
            mu = Triangle(data,0,1/3,2/3);
        case 8
            mu = Triangle(data,1/3,2/3,1);
        case 9
            mu = Triangle(data,2/3,1,1);
        case 10
            mu = Triangle(data,0,0,1/4);
        case 11
            mu = Triangle(data,0,1/4,1/2);
        case 12
            mu = Triangle(data,1/4,1/2,3/4);
        case 13
            mu = Triangle(data,1/2,3/4,1);
        case 14
            mu = Triangle(data,3/4,1,1);
        case 15
            mu = 1;
    end

end

