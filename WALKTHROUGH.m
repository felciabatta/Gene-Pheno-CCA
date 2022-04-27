% WALKTHROUGH

% In this walkthrough, we use 'ATLAS-3693' as our dataset:
% @ https://atlas.ctglab.nl/traitDB/3693

% First you will need to create a S_XY file, by reformatting GWAS-ATLAS data
%
% --------- YOU CAN DOWNLOAD S_XY_ATLAS-3693.txt from the MS teams page ---------
%
% FILE      S_XY_ATLAS-xxxx.txt 
% 
% FORMAT 	---------------------------------------
%           ##N nnnnnn
%           SNP_id	allele_0    allele_1	trait_b 
%           rrrrrr	al          al          bbbb
%           rrrrrr	al          al          bbbb
%           ---------------------------------------
% 
% Where     xxxx 	is the GWAS ATLAS reference code
%           nnnnnn 	is the number of participants in the study
%           rrrrrr 	is the rs id (numeric, i.e. without 'rs' prefix)
%           al      are alleles
%           bbbb 	is the regression coefficient

% Next, you will need to choose a range of SNPs you wish to analyse,
% imported as a ',' separated .txt file
% 
% FILE      DESC_ATLAS-XXXX.txt
% 
% FORMAT    rsxxxxx,rsyyyyy,rszzzzz,    etc...
% 
% Where     DESC	is a brief description of the list	e.g. "topSNPtable"
%           XXXX	is the GWAS ATLAS reference number,
%                   for the study which the SNPs come from	e.g. "3693"
% 
% NOTE: 	'top SNP tables' can be downloaded for any GWAS ATLAS dataset 
%           (https://atlas.ctglab.nl), but need to be reformatted as shown

SNPlist = 'Data_Raw/1000GP/SNP-Lists/topSNPs_ATLAS-3693.txt';

%% OPTIONAL - only if you NEED to extract new data with PLINK
%
% You also need to download the 1000GP phase3 population list, corresponding to
% the GWAS-ATLAS study being analysed.
% 
% FILE      phase3_POP.txt
% 
% FORMAT:	simply change first column header, to #IID, and should all work fine
%           ------------------------------------------
%           #IID    Sex etc...
%           ABXXXXX	m/f	___...
%           ------------------------------------------
% 
% where     POP     is the population reference code 	e.g. 'GBR'
%           ABXXXXX	is the sample reference code        e.g. 'HG00106'

% In this case it is GBR.
% @ https://www.internationalgenome.org/data-portal/population

POPlist = 'Data_Raw/1000GP/POP-Lists/phase3_GBR.txt';

% Using these lists, you need to extract the 1000GP SNP-data like so:
%  NOTE:    ONCE THE FILE IS CREATED, YOU DO NOT NEED TO RUN THIS AGAIN
%           AS IT TAKES A LONG TIME TO RUN

get_snpdata(SNPlist,POPlist);

%% Finally, you can apply metaCCA using the function below
% SNPloc just gives position of your selected SNPs, within the original data

[results SNPloc] = MultiSNPanalysis('3693',SNPlist,2);

%% save the results using writecell

writecell(results,'Results/WALKTHROUGH_result.txt','Delimiter','\t');

