function oldVSnew = comparePvals(ATLASid,SNPloc,results)
%COMPAREPVALS Summary of this function goes here
%   Detailed explanation goes here

% soloPvals = readmatrix(['Data_Raw/GWAS-ATLAS/ATLAS-',ATLASid,'_pvals.txt']);
soloPvals = struct2array(load(['Data_Raw/GWAS-ATLAS/ATLAS-',ATLASid,'_pvals.mat']));
mySoloPvals = soloPvals(SNPloc,:);

pairedSNP_sumPvals = zeros(length(results)-1,1);

for p = 2:length(results)
    rsids = str2double(split(results{p,1},','));
    [in loc] = ismember(rsids,mySoloPvals(:,1));
    pairedSNP_sumPvals(p-1) = sum(-log10(mySoloPvals(loc,2)));
end

oldVSnew = [pairedSNP_sumPvals,cell2mat(results(2:end,2))];

plot(oldVSnew(:,1),oldVSnew(:,2),'.'); hold on;
plot([0,120],[0,120])
plot([0,120],[0,120]/2)

end