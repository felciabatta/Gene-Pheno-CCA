function file = get_bad_snps(ATLASid)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Pvals = struct2array(load(['Data_Raw/GWAS-ATLAS/ATLAS-',ATLASid,'_pvals.mat']));

bad = Pvals(:,2) >= 5e-8;

snps = Pvals(bad,:);

file = ["rsid"                  , "P"               ;
        "rs"+string(snps(:,1))  , string(snps(:,2))];
    
writematrix(file,['Data_Raw/GWAS-ATLAS/badsnps_ATLAS-' ATLASid '.txt'], 'Delimiter','\t')

end

