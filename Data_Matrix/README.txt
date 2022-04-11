In this folder, you will need to add the following files, converted from GWAS ATLAS data. Make sure the content and names of the files are in the correct format. Note S_XX is generated using Format_1000GP.m, 1000GP .txt data and SNP-lists.

1. S_XY_ATLAS-xxxx.txt 

FORMAT 	---------------------------------
	##N nnnnnn
	SNP_id	allele_0	allele_1	trait_b 
	rrrrrr	al	al	bbbb
	rrrrrr	al	al	bbbb
	---------------------------------

Where 	xxxx 	is the GWAS ATLAS reference code
	nnnnnn 	is the number of participants in the study
	rrrrrr 	is the rs id (numeric, i.e. without 'rs' prefix)
	al 	are alleles
	bbbb 	is the regression coefficient

2. S_XX_ATLAS-xxxx.txt

DO NOT commit S_XY files to github, just keep them locally - they are too large for git.