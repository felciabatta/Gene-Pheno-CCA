% TEST RUN

import metaCCA_MODIFIED.*

% no. of people in study
N_Test = 244890;

% data already correctly formatted
S_XY_Test = importdata("Data/S_XY_ATLAS-3693.txt");

% phenotype correlation matrix
S_YY_Test = estimate_Syy(S_XY_Test);

% run metaCCA
metaCCA_TEST = metaCCA(1,S_XY_Test,0,S_YY_Test,N_Test);

% Get pvals from -log10(pvals)
pvals=10.^(-cell2mat(metaCCA_TEST(2:end,3)));

% insert pvals into results matrix, and round
% also convert to 'single' data type as takes less memory
metaCCA_TEST(2:end,4)=num2cell(pvals);
metaCCA_TEST(2:end,4)=num2cell(round(single(pvals),4));
metaCCA_TEST(2:end,3)=num2cell(round(single(cell2mat(metaCCA_TEST(2:end,3))),4));

% export as .txt file
writecell(metaCCA_TEST(:,[1 3 4]),'metaCCA_TEST.txt','Delimiter','\t')


