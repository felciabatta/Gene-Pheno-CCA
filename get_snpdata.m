function fileout = get_snpdata(SNPlist,POPlist)
% GET_SNPDATA   Extracts snp data from 1000GP database, 
%               for specified snps and subpopulation
% 
% NOTE:         This function is for use within other functions, 
%               so you shouldn't need to use it directly
%
% INPUTS:   NAME    DESCRIPTION
% 
%           SNPlist file containing list of rsids for snps
%                   ',' separated, single row
% 
%           POPlist file containing list of 1000GP samples from a sub population
%                   e.g. UK only

DIR     = 'Data_Raw/1000GP/';
SNPstr = fileread(SNPlist);

system(['./' DIR 'plink2 '  '--snps ' SNPstr ' '...
                            '--keep ' POPlist ' '...
                            '--pfile ' DIR 'all_phase3 '... 
                            '--recode vcf id-paste=iid '...
                            '--out Data_SNPs/phase3_' name ]);

[~, name, ~] = fileparts(SNPlist);
system(['rm '   'Data_SNPs/phase3_' name '.log']);

system(['mv '   'Data_SNPs/phase3_' name '.vcf '...
                'Data_SNPs/phase3_' name '.txt']);

fileout = ['Data_SNPs/phase3_' name '.txt'];
 
end