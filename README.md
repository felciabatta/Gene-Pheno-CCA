# Gene-Pheno-CCA

Private project files, including a modified version of metaCCA.
- Bugs fixed relating to single-study analysis

Key Information:
- The README.txt files in each folder explain what should be in each folder
- Large files that cannot be contained in the REPO must be obtained seperately, which mainly includes 1000GP data, GWAS-ATLAS data, and S_XY files.
- The only files which need to be created/edited manually are:
	- S_XY_ATLAS-xxxx.txt (reformat GWAS-ATLAS data)
	- POP-Lists/*.txt (download & reformat)
	- SNP-Lists/*.txt (download & reformat; or created otherwise)
- The files which can be created semi-automatically using MATLAB scripts inlcude:
	- S_XX_ATLAS-xxxx.txt (estimateSxx.m)
	- Data_SNPs/*.txt (get_snpdata.m)
	- Results/*.txt (TEST_RUN.m, Multi_SNP_TEST.m, etc)
- For univariate SNP analysis, only S_XY is needed
- For multivariate SNP analysis
	- POP-Lists, SNP-Lists are used to generate Data_SNPs
	- Data_SNPs/*.txt are used to generate S_XX
	- S_XY, S_XX, SNP-Lists are used to generate Results

Original metaCCA README:

The MATLAB codes in this repository can be used to perform metaCCA <br />
(and its variant metaCCA+) - summary statistics-based analysis <br />
of a single or multiple genome-wide association studies (GWAS) <br />
that allows multivariate representation of both genotype and phenotype.

example.m demonstrates the usage of metaCCA. Test files are provided.

Please cite the following paper when using the software: <br />
[*metaCCA: Summary statistics-based multivariate meta-analysis <br />
of genome-wide association studies using canonical correlation analysis.*](http://bioinformatics.oxfordjournals.org/content/early/2016/02/19/bioinformatics.btw052.abstract)
<br />


15/07/2015 Anna Cichonska, anna.cichonska@helsinki.fi

R implementation: http://bioconductor.org/packages/metaCCA/
