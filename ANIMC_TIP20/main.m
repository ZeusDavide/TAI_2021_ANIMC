
%NOTE THAT our paper "ANIMC: A Soft Framework for Auto-weighted Noisy and Incomplete Multi-view Clustering"
% performs the experiments in MATLAB R2019b and our codes run on a Windows 10 machine with 3:30 GHz E3-1225 CPU, 64 GB main memory.
clear all;
clc;
%missing rate
percentDel = 0.2;   
fprintf(sprintf('percentDel: %0.4f\n', percentDel));
% load multi-view dataset
[X , T , ind , label , viewNum , clusters] = loaddataset(percentDel);
% %add noises
% noise_der=0.1;
% per_noise=0.2;
% % % iv=1;
% for iv = 1:viewNum
% %add Gaussian noise
% noise=sqrt(noise_der)*randn(size(X{iv})) + 0;
% noise_f= randsrc(size(X{iv},1),size(X{iv},2),[1 0; per_noise (1-per_noise)]);
% X{iv}=X{iv}+noise.*noise_f;
% end


% for t = 1:1

for i = 1:viewNum
    X{i} = X{i}';
end

tic

    options.afa =0.1;
%     for j = 1:1
        options.beta =100;
        options.sigema=options.afa;
        
        disp([options.afa,options.beta,options.sigema]);
        [U,V,A,obj,omega,ACC,NMI,Purity] = ANIMC_TIP(X,T,label,clusters,viewNum,options);
%     end
% end
toc
% end