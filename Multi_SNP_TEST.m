% TEST RUN

import metaCCA_MODIFIED.*

% DATA FORMAT (MUST contain the following folders & files as shown)

% Folder :  Data_Matrix/
%   Files:  S_XY_ATLAS-<STUDY_REF>.txt      % reformatted GWAS ATLAS XY data
%           S_XX_ATLAS-<STUDY_REF>.txt      % XX matrix estimated via 1000GP
%                                           % use Format_1000GP.m to create this
%                                           % only for multivariate SNP

% Folder :  Data_Raw/GWAS-ATLAS/
%   Files:  ATLAS-<STUDY_REF>_N.txt         % contains study size N

%% import data (must be correctly formatted)
STUDY_REF = input("Enter study reference no.: ",'s');
S_XY_Full = importdata(['Data_Matrix/S_XY_ATLAS-',STUDY_REF,'.txt'],'\t');
N_Test = str2double(S_XY_Full.textdata{1,1}(5:end));
S_XY_Full.textdata(1,:)=[];

opts = detectImportOptions(['Data_Matrix/S_XY_ATLAS-',STUDY_REF,'.txt']);
opts.SelectedVariableNames = 1;
allSNPs = readmatrix(['Data_Matrix/S_XY_ATLAS-',STUDY_REF,'.txt'],opts);

%% cut data down to desired size
[file,path] = uigetfile('Data_Raw/1000GP/SNP-Lists/.txt');
mySNPs = readmatrix([path,file],'Whitespace','rs')';
[in,loc] = ismember(mySNPs,allSNPs);

S_XY_Test = struct();
S_XY_Test.data = S_XY_Full.data(loc,:);
S_XY_Test.textdata = S_XY_Full.textdata([1;loc+1],:);

%% phenotype correlation matrix
S_YY_Test = estimate_Syy(S_XY_Test);

%% default metaCCA TEST
metaCCA_TEST = metaCCA(1,S_XY_Test,0,S_YY_Test,N_Test);

%% single SNP metaCCA TEST
metaCCA_1SNP = metaCCA(1,S_XY_Test,0,S_YY_Test,N_Test,1,string(mySNPs(1)));

%% multi-SNP metaCCA TEST
strSNPs = cellstr(string(mySNPs'));
S_XX_Test = importdata(['Data_Matrix/S_XX_ATLAS-',STUDY_REF,'.txt'],'\t');
metaCCA_MultiSNP = metaCCA(1,S_XY_Test,0,S_YY_Test,N_Test,2,strSNPs(1:2),S_XX_Test);

%% multi-SNP metaCCA combos TEST
pairs = nchoosek(strSNPs,2);
metaCCA_pairSNP = {'SNP_id','r_1','-log10(p-val)'};
for p = 1:length(pairs)
    m = metaCCA(1,S_XY_Test,0,S_YY_Test,N_Test,2,pairs(p,:),S_XX_Test);
    metaCCA_pairSNP(p+1,:) = m(2,:);
end

%% visualise as a 2-way table

resultsMat = NaN(length(mySNPs));
h = length(mySNPs)-1:-1:1;
triN = @(n) n*(n+1)/2;
for i = h
    resultsMat(end-i+1:end,18-i) = cell2mat(metaCCA_pairSNP(((triN(17)-triN(i)+1):(triN(17)-triN(i-1)))+1,3));
end

Dt = D';
D(~isnan(D)') = Dt(~isnan(Dt));

imagesc(D)

%% Get pvals from -log10(pvals)
pvals=10.^(-cell2mat(metaCCA_TEST(2:end,3)));

% insert pvals into results matrix, and round
% also convert to 'single' data type as takes less memory
metaCCA_TEST{1,4}='pvals';
metaCCA_TEST(2:end,4)=num2cell(round(single(pvals),5));
metaCCA_TEST(2:end,3)=num2cell(round(single(cell2mat(metaCCA_TEST(2:end,3))),5));

%% export as .txt file
writecell(metaCCA_TEST(:,[1 3 4]),['Results/Results_ATLAS-',STUDY_REF,'_TEST.txt'],'Delimiter','\t')


