function S_XY = formatATLASsiewert(N)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[file,path] = uigetfile('Data_Raw/GWAS-ATLAS/.txt');
file = [path file];

[~,name,~] = fileparts(file);
ATLASid = name(end-3:end);

opts = detectImportOptions(file);
opts.SelectedVariableNames = {'SNP' 'EA' 'OA' 'beta_CAD' 'se_CAD' 'beta_lipid' 'se_lipid'};
opts = setvaropts(opts,'Type','string');
opts = setvaropts(opts,'SNP','Prefixes','rs');

fprintf('\nReading file...\n');
S_XY = readmatrix(file,opts);
vars = {'SNP_id' 'allele_0' 'allele_1' 'CAD_b' 'CAD_se' 'lipid_b' 'lipid_se'};

S_XY = ["##N "+string(N) "" "" "" "" "" ""; string(vars); S_XY];

fprintf('\nWriting file...\n')
writematrix(S_XY,['Data_Matrix/S_XY_ATLAS-' ATLASid '.txt'],'Delimiter','\t')

fprintf('\nJob done.\n')
end

