function [U,V,B] = init(X,T,r,viewNum)
B = cell(viewNum,1);
U = cell(viewNum,1);
H = cell(viewNum,1);
XX = cell(viewNum,1);
for i = 1:viewNum
    item = diag(T{i});
    temp = find(item == 0);
    XX{i} = X{i};
    XX{i}(:,temp)= [];
    Mx = mean(XX{i},2);
    X{i}(:,temp)= repmat(Mx,1,length(temp));
end
%%
sumH = 0;
for i = 1:viewNum
    [d(i),n] = size(X{i});
    [ilabels,C] = litekmeans(X{i}', r, 'Replicates', 20);
    U{i} = C' + 0.1*ones(d(i),r);  
    G = zeros(n,r);
    for j=1:r
        G(:,j)=(ilabels == j*ones(n,1));
    end 
    H{i}=G+0.1*ones(n,r);
    sumH = sumH + H{i};    
end
V = sumH/viewNum;
Q = diag(ones(1,size(V,1))*V);
V = V/Q;
% for i=1:viewNum
%     WV = (abs(V(i))+abs(V(i)'))*0.5;
%     LV=diag(sum(WV))-WV;
% end
for i = 1:viewNum
    U{i} = U{i}*Q;
end
lamda = 1e-5;
for i = 1:viewNum
%     [d,~] = size(U{i});
   invI = diag(1./diag(lamda*eye(d(i))));
%   B{i} =(eye(size(U{i},1)) -  U{i}/(U{i}'*U{i} + eye(r)) * U{i}')*U{i};
   B{i} = (invI - invI * U{i}/(U{i}'*invI*U{i} + eye(r)) * U{i}' * invI) * U{i};
end
end


