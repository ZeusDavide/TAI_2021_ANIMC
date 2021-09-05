function V = UpdateV(X,W,U,V,viewNum,options,t,seta_V)
time = 0;
f = 0;
for k = 1:size(V,1)
    tmp(k)=norm(V(k,:),2);
    D_V(k,k)=(seta_V+1)*(seta_V*tmp(k)+2)/(seta_V*tmp(k)+1)^2;
end
clear tmp;
while 1
    time = time +1;
    sumVUUminus = 0;
    sumVUUplus = 0;
    sumXUminus = 0;
    sumXUplus = 0;
    for i = 1:viewNum
         temp(i)=norm((X{i} - U{i}*V')*W{i},'fro');
         omega(i)=min(t/(2*temp(i)^(0.5*t-1)+(1e-5)),0.5/norm((X{i} - U{i}*V'),'fro'));
        XU = X{i}'*U{i};
        absXU = abs(XU);
        XUplus = (absXU + XU)/2;
        XUminus = (absXU - XU)/2;
        
        UU = U{i}'*U{i};
        absUU = abs(UU);
        UUplus = (absUU + UU)/2;
        UUminus = (absUU - UU)/2;
%         sumXUminus = sumXUminus + W{i}*XUminus;
%         sumXUplus = sumXUplus + W{i}*XUplus;    
         sumXUminus = sumXUminus + omega(i)*W{i}*XUminus;
         sumXUplus = sumXUplus + omega(i)*W{i}*XUplus;
%        sumVUUplus = sumVUUplus + W{i}*V*UUplus;
%        sumVUUminus = sumVUUminus + W{i}*V*UUminus;
         sumVUUplus = sumVUUplus + omega(i)*W{i}*V*UUplus;
         sumVUUminus = sumVUUminus + omega(i)*W{i}*V*UUminus;
    end
%    V = V.*sqrt((sumXUplus + sumVUUminus)./(max(sumXUminus + sumVUUplus,1e-10))); 
     V = V.*sqrt((sumXUplus + sumVUUminus+options.afa*D_V*V)./(max(sumXUminus + sumVUUplus+options.afa*D_V*V,1e-10)));  
    
    ff = 0;
    for i = 1:viewNum
%         tmp = (X{i} - U{i}*V')*W{i};
        temp(i)=norm((X{i} - U{i}*V')*W{i},'fro');
        omega(i)=min(t/(2*temp(i)^(0.5*t-1)+(1e-5)),0.5/norm((X{i} - U{i}*V'),'fro'));
%         omega(i)=1/(2*temp(i)+(1e-5)); 
        ff = ff + sum(sum(temp(i).^2))*omega(i);
    end
    if abs((ff-f)/f)<1e-4 | abs(ff-f)>1e100 | time == 30	
        break;
    end
    f = ff; 
end
end


