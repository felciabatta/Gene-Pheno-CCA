% TEST RUN

import metaCCA_MODIFIED.*

%% import data (must be correctly formatted)
S_XY_Full = importdata("Data/S_XY_ATLAS-3693.txt");

% no. of people in study
N_Test = 244890;

%% cut data down to desired size
SNProws = [1:100]; % choose which SNPs you want (using row no.)
S_XY_Test = struct();
S_XY_Test.data = S_XY_Full.data(SNProws,:);
S_XY_Test.textdata = S_XY_Full.textdata([1,SNProws+1],:);

%% phenotype correlation matrix
S_YY_Test = estimate_Syy(S_XY_Test);

%% run metaCCA
metaCCA_TEST = metaCCA(1,S_XY_Test,0,S_YY_Test,N_Test);

%% Get pvals from -log10(pvals)
pvals=10.^(-cell2mat(metaCCA_TEST(2:end,3)));

% insert pvals into results matrix, and round
% also convert to 'single' data type as takes less memory
metaCCA_TEST{1,4}='GwazAtlas_pvals';
metaCCA_TEST(2:end,4)=num2cell(pvals);
metaCCA_TEST(2:end,4)=num2cell(pvals);
metaCCA_TEST(2:end,4)=num2cell(round(single(pvals),5));
metaCCA_TEST(2:end,3)=num2cell(round(single(cell2mat(metaCCA_TEST(2:end,3))),5));

%% export as .txt file
writecell(metaCCA_TEST(:,[1 3 4]),'metaCCA_TEST.txt','Delimiter','\t')


