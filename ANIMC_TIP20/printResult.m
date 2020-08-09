function [ACC MIhat Purity] = printResult(X, label, K, kmeansFlag)

if kmeansFlag == 1
    indic = litekmeans(X, K, 'Replicates', 20);
else
    [~, indic] = max(X, [] ,2);
end
% result = bestMap(label, indic);
[ACC MIhat Purity] = ClusteringMeasure(label, indic);
% disp(sprintf('ac: %0.4f\t%d/%d\tnmi:%0.4f\t', ACC, cnt, length(label), nmi_value));