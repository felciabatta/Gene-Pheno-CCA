% Format 1000GP

% Input: tab delim .txt 1000GP file (exported to .vcf via PLINK, changed to .txt)
%        reformatting and covariance matrix are automatic

% input file
[file,path] = uigetfile('Data_SNPs/.txt');
opts = detectImportOptions([path,file],'Delimiter','\t');
opts = setvartype(opts,'ID','double');
opts.Whitespace='\b rs';

% reformat data
SNPdata = readtable([path,file],opts);
% Var1 = find(string(SNPdata.Properties.VariableNames)=="ID");
Var2 = find(string(SNPdata.Properties.VariableNames)=="FORMAT");
SNPids = SNPdata.ID;
SNPdata = SNPdata(:,Var2+1:end);
SNPdata = string(table2array(SNPdata));

cat = ["0|0","0|1";"1|0","1|1"];
num = [ "0" ,"0.5";"0.5", "1" ];

for c = 1:numel(cat)
        SNPdata(SNPdata==cat(c)) = num(c);
end

SNPdata = double(SNPdata);

% calculate covariance matrix
S_XX = [SNPids,round(corr(SNPdata'),5)];

% save matrix
ATLASiD = input("Enter the ID for the GWAZ ATLAS dataset: ","s");
savepath = uigetdir('Data_Matrix');
writematrix(S_XX,savepath+"/S_XX_ATLAS-"+ATLASiD,'Delimiter','\t')

%% visualise matrix
S_XX(S_XX==1) = NaN;
imagesc(S_XX)

