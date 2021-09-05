function [U,V,A,obj,omega,ACC,NMI,Purity] = ANIMC_TIP(X,T,label,clusters,viewNum,options)
% Code for "ANIMC: A Soft Framework for Auto-weighted Noisy and Incomplete Multi-view Clustering"
% writen by Xiang Fang (xfang9508@gmail.com)
%%
%Input
%X: incomplete multi-view data with viewNum views
%the v-th view matrix X{v} d_v by n
%T{v}:  the corresponding diagonal matrix of vector g(v)
%label: ground truth label
%clusters: cluster number
%viewNum: view number
%options: Parameter options.afa,options.beta
%%
%Output
%U{v}: the basis matrix of the v-th view
%V: the common latent feature matrix shared by all views
%A{v}: the regression coefficient matrix of the v-th view
%obj:objective function value
%omega: the weight of the v-th view
%ACC,NMI,and Purity : the evaluation metrics
%%
fprintf(sprintf('Initialization...\n'));
%Initialize variable U,V,A
[U,V,A] = init(X,T,clusters,viewNum);

printResult(V, label, clusters, 1);
r=1.2;
% eta = 1e-10;

obj = 0;
seta_A=100;
seta_V=1e-2;

D_A= cell(viewNum,1);




time = 0;
f =0;
while 1
    time = time+1;
    V = UpdateV(X,T,U,V,viewNum,options,r,seta_V); 
    for i = 1:viewNum
        temp(i)=norm((X{i} - U{i}*V')*T{i},'fro');
        omega(i)=min(r/(2*temp(i)^(0.5*r-1)+(1e-5)),0.5/norm((X{i} - U{i}*V'),'fro'));
%          omega(i)=t/(2*temp(i)^(2-t));
%         1/(2*temp(i)-norm(ones(length(label))-W{i},'fro')/length(label)); 
        tmp1 = options.afa*A{i}*A{i}';
        tmp2 = V'*T{i}*V*omega(i);
        tmp3 = X{i}*T{i}*V*omega(i) + options.afa*A{i};
        U{i} = lyap(tmp1, tmp2, -tmp3);     %Lyapunov function
%         U{i} = X{i}*W{i}*V*omega(i)/(V'*W{i}*V);     

    end  
    Q = diag(ones(1,size(V,1))*V);
    V = V/Q;
    for i = 1:viewNum
        U{i} = U{i}*Q;
%         B{i} = options.afa/options.sigema*(eye(size(U{i},1)) -  U{i}/(U{i}'*U{i} + options.sigema*eye(r)) * U{i}')*U{i};
    for k = 1:size(A{i},1)
        tmp(k)=norm(A{i}(k,:),2);
        D_A{i}(k,k)=(seta_A+1)*(seta_A*tmp(k)+2)/(seta_A*tmp(k)+1)^2;
    end
        clear tmp;
%         B{i} = -pinv(U{i}*U{i}')*(options.sigema*eye(r));
        invD = diag(1./diag(D_A{i}));
        A{i} = options.afa/options.beta*(invD - invD * U{i}/(U{i}'*invD*U{i} + options.beta*eye(clusters)) * U{i}' * invD)*U{i};
%        for k = 1:size(B{i},1)
%            D{i}(k,k) = 1/sqrt(norm(B{i}(k,:),2).^2+eta);   
%        end
    end
    
    ff = 0;
    for i = 1:viewNum  
        tmp1 = (X{i} - U{i}*V')*T{i};
        temp(i)=norm(tmp1,'fro');
          omega(i)=min(r/(2*temp(i)^(0.5*r-1)+(1e-5)),0.5/norm((X{i} - U{i}*V'),'fro'));

%         omega(i)=t/(2*temp(i)^(2-t)); 
        tmp2 = A{i}'*U{i} - eye(clusters);
    for k = 1:size(A{i},1)
        tmp(k)=norm(A{i}(k,:),2);
        tmp3 =(seta_A+1)*tmp(k)^2/(seta_A*tmp(k)+1);
    end
    clear tmp;
%         tmp4 = sum(1./diag(D{i}));
        ff = ff + sum(sum(tmp1.^2))*omega(i) + options.afa*sum(sum(tmp2.^2)) + options.beta*(options.sigema*sum(norm(A{i},'fro')^2));
    end
    for k = 1:size(V,1)
        tmp(k)=norm(V(k,:),2);
        tmp4=(seta_V+1)*tmp(k)^2/(seta_V*tmp(k)+1);
    end
   clear tmp;
    obj(time) = ff+options.afa*tmp4;
% indic: clustering result label
    indic = litekmeans(V, clusters, 'Replicates', 20);
    [ACC, NMI,Purity] = ClusteringMeasure(label, indic);
    fprintf('Finish the iteration %d, ac is %d, nmi is %d, pure is %d,value is %d\n',time,ACC,NMI,Purity,ff);
    
    if abs(ff-f)/f < 1e-6 | abs(ff-f) >  1e100 | time ==30
        break;
    end
    f = ff;
end