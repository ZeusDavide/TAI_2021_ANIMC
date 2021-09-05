function [ splitInd ] = splitDigitData(ind, inCP, randSeed )
%   Remove some instances to obtain incomplete multi-view data
[N, M] = size(ind);
splitInd = ones(size(ind)); %index of missing instances
indCell = cell(M,1);    
delNum = floor(N * inCP);   %the number of missing instances
for i=1:M
    %Randomly delete instances
    rng(i * randSeed); 
    indCell{i} = randperm(N);   %
    splitInd(indCell{i}(1:delNum),i)=0;
end
counter = ones(M,1)*delNum + 1;

while 1
    zerosInd = find(sum(splitInd,2)==0);
    if size(zerosInd,1) == 0
        break;
    else
        i = randi(M);
        splitInd(zerosInd(1),i) = 1;
        splitInd(indCell{i}(counter(i)),i) = 0;
        counter(i) = counter(i) + 1;
    end
        
end


