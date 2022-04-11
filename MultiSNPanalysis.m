function results = MultiSNPanalysis(ATLASid,SNPlist,GroupSize)
% MULTISNPANALYSIS  runs multivariate metaCCA for a selection of SNPs, 
%                   paired in groups of a specified size
% 
% INPUTS:   NAME        DESCRIPTION
% 
%           ATLASid     id number for GWAS-ATLAS dataset
%           SNPlist     filepath for an SNP-list
%           GroupSize   desired SNP-grouping size

% DATA FILES REQUIRED (other than the above INPUTS)
% 
%           NAME                            DESCRIPTION
% 
% Folder :  Data_Matrix/
%   Files:  S_XY_ATLAS-<STUDY_REF>.txt      Manually reformatted 
%                                           GWAS-ATLAS XY data
% 
% Folder :  Data_SNPs/
%   Files:  phase3_<SNPlist_NAME>.txt       Created semi-automatically 
%                                           using get_snpdata.m

import metaCCA_MODIFIED.*

% import XY data (must be correctly formatted)
fprintf('\nImporting Data...\n');

S_XY_Full = importdata(['Data_Matrix/S_XY_ATLAS-',ATLASid,'.txt'],'\t');
N_Test = str2double(S_XY_Full.textdata{1,1}(5:end));
S_XY_Full.textdata(1,:)=[];

fprintf('\nImport Complete.\n');

% get full SNP list
opts = detectImportOptions(['Data_Matrix/S_XY_ATLAS-',ATLASid,'.txt']);
opts.SelectedVariableNames = 1;
allSNPs = readmatrix(['Data_Matrix/S_XY_ATLAS-',ATLASid,'.txt'],opts);

% cut data to desired size
mySNPs = readmatrix(SNPlist,'Whitespace','rs')';
[in,loc] = ismember(mySNPs,allSNPs);

S_XY = struct();
S_XY.data = S_XY_Full.data(loc,:);
S_XY.textdata = S_XY_Full.textdata([1;loc+1],:);

% phenotype correlation matrix
S_YY = estimate_Syy(S_XY);

% genotype correlation matrix
[~, name, ~] = fileparts(SNPlist);
S_XX = estimate_Sxx(['Data_SNPs/phase3_' name '.txt']);

% multi-SNP analysis
SNPstr = cellstr(string(mySNPs'));

pairs = nchoosek(SNPstr,GroupSize);
metaCCA_OUT = {'SNP_id','r_1','-log10(p-val)'};

for p = 1:length(pairs)
    m = metaCCA(1,S_XY,0,S_YY,N_Test,2,pairs(p,:),S_XX);
    metaCCA_OUT(p+1,:) = m(2,:);
end

results = metaCCA_OUT(:,[1 3]);

end
