% MAIN

%% Initialise
ATLASids = {'4345' '4346' '4347' '4348'};
% ATLASids = {'4345'};
SNPlistPATH = 'Data_Raw/1000GP/SNP-Lists/';

%% Paired TOP-SNPs
for i = 1:length(ATLASids)
    SNPlist = [SNPlistPATH 'topsnps_ATLAS-' ATLASids{i} '.txt'];
    [results, SNPloc] = MultiSNPanalysis(ATLASids{i},SNPlist,2);
    comparison = comparePvals(ATLASids{i},SNPloc,results);
    ratios = comparison(:,2)./comparison(:,1);
    [sortedratios, I]=sortrows(ratios);
    comparison = comparison(I,:);
    crit = ceil(length(comparison)*0.975);
    comptop = comparison(crit:end,:);
    compreg = comparison(1:crit-1,:);
    fig = figure;
    plot(compreg(:,1),compreg(:,2),'.',comptop(:,1),comptop(:,2),'.','MarkerSize',5); hold on;
    MAX = max(comparison(:,1)); MIN = min(comparison(:,1)); MIN=0;
    plot([MIN MAX],[MIN MAX; MIN/2 MAX/2]','LineWidth',2)
    ax = gca; ax.TickLabelInterpreter='latex';
    grid on
    title(['P-vals for Paired SNPs (ATLAS-' ATLASids{i} ')'],'Interpreter','latex','FontSize',20);
    xlabel('$-log_{10}\big[\,{\rm P}({\bf snp}_1)\times {\rm P}({\bf snp}_2)\,\big]$ ({\bf expected})','Interpreter','latex','FontSize',16); 
    ylabel('$-log_{10}\big[\,{\rm P}({\bf snp}_1\cup {\bf snp}_2)\,\big]$ ({\bf observed})','Interpreter','latex','FontSize',16);
    
    exportgraphics(fig,['Results/Results-topsnps' num2str(length(SNPloc)) 'c2_ATLAS-' ATLASids{i} '.pdf'],'ContentType','vector')
end

