function snps = extractTOPsnps()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[file,path] = uigetfile('Data_Raw/GWAS-ATLAS/.csv');
file = [path file];

[~,name,~] = fileparts(file);
ATLASid = name(end-3:end);

opts = detectImportOptions(file);
opts.SelectedVariableNames = 'rsID';
opts = setvaropts(opts,'Type','string');

fprintf('\nReading file...\n');
snps = readmatrix(file,opts)';

fprintf('\nWriting file...\n')
writematrix(snps,['Data_Raw/1000GP/SNP-Lists/topSNPs_ATLAS-' ATLASid '.txt'],'Delimiter',',')

fprintf('\nJob done.\n')
end

