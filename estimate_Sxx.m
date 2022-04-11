function S_XX = estimate_Sxx(file)
% ESTIMATE_SXX
% INPUTS:   NAME    DESCRIPTION
%
%           file    filepath for a tab delimited .txt 1000GP file, 
%                   created using get_snpdata.m

% file import options
opts = detectImportOptions(file,'Delimiter','\t');
opts = setvartype(opts,'ID','double');
opts.Whitespace = '\b rs';

% import & reformat data
SNPdata = readtable(file,opts);
formatCol = find(string(SNPdata.Properties.VariableNames)=="FORMAT");
SNPids = SNPdata.ID;
SNPdata = SNPdata(:,formatCol+1:end);
SNPdata = string(table2array(SNPdata));

cat = ["0|0","0|1";"1|0","1|1"];
num = [ "0" ,"0.5";"0.5", "1" ];

for c = 1:numel(cat)
        SNPdata(SNPdata==cat(c)) = num(c);
end

SNPdata = double(SNPdata);

% calculate covariance matrix
S_XX = [SNPids,round(corr(SNPdata'),5)];

%% save matrix
% ATLASiD = input("Enter the ID for the GWAS ATLAS dataset: ","s");
% savepath = uigetdir('Data_Matrix');
% writematrix(S_XX,savepath+"/S_XX_ATLAS-"+ATLASiD,'Delimiter','\t')

%% visualise matrix
% S_XX(S_XX==1) = NaN;
% imagesc(S_XX(:,2:end))

end