function pvals = getPvals()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[file,path] = uigetfile('Data_Raw/GWAS-ATLAS/.txt')
file = [path file];

[~,name,~] = fileparts(file);
ATLASid = name(end-3:end);

opts = detectImportOptions(file);
opts.SelectedVariableNames

rsIDhead = input('\nType in rsID header: ','s');
pvalhead = input('\nType in pval header: ','s');

opts.SelectedVariableNames = {rsIDhead,pvalhead};
opts = setvaropts(opts,'Type','double');
opts = setvaropts(opts,'SNP','Prefixes','rs');

fprintf('\nReading file...\n');
pvals = readmatrix(file,opts);
save(['Data_Raw/GWAS-ATLAS/Pvals_ATLAS-' ATLASid '.mat'],'pvals')

end

