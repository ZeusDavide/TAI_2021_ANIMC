function [X , T , ind , label , viewNum , clusters] = loaddataset(percentDel)
load('scene.mat');
truth=y;
viewNum = length(X); %view number
clusters = length(unique(truth));     %cluster number
for i = 1:viewNum
    X{i} = X{i}';
end
T = cell(viewNum,1);
label=truth;

ind = ones(size(X{1},1), viewNum);
%remove some instances to obtain incomplete data
ind = splitDigitData( ind, percentDel, 1 );
for i = 1:viewNum
    item = ind(:,i);
    T{i} = diag(item);
    temp = item == 0; 
    X{i}(temp,:)= 0;
    X{i} = mapminmax(X{i},0,1);
% normalize each row of X{i}
    X{i} = NormalizeFea(X{i},1);
end
end