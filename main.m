% MAIN

%% Initialise
ATLASids = {'4345' '4346' '4347' '4348'};
% ATLASids = {'4347'};
SNPlistPATH = 'Data_Raw/1000GP/SNP-Lists/';

%% Paired TOP-SNPs
for i = 1:length(ATLASids)
    SNPlist = [SNPlistPATH 'topsnps_ATLAS-' ATLASids{i} '.txt'];
    [results, SNPloc] = MultiSNPanalysis(ATLASids{i},SNPlist,2);
    [comptab, univarPvals] = comparePvals(ATLASids{i},SNPloc,results);
    compmat = cell2mat(comptab(2:end,2:end));
    
    % remove rows with Inf
    comptab([false;compmat(:,2)==Inf],:)=[];
    compmat = cell2mat(comptab(2:end,2:end));
        
    % SUM STATS
    [~,ItE] = max(compmat(:,1));
    [~,ItO] = max(compmat(:,2));
    
    topEXP = comptab(ItE+1,:);
    topOBS = comptab(ItO+1,:);
    univarPvals = sortrows(univarPvals,2);
    [~,EXPranking] = ismember(double(split(topEXP{1},',')),univarPvals(:,1));
    [~,OBSranking] = ismember(double(split(topOBS{1},',')),univarPvals(:,1));
    topOBS = [topOBS,mat2cell(OBSranking',1,[1 1])]
    topEXP = [topEXP,mat2cell(EXPranking',1,[1 1])]
    
    % FIND EXTREME VALUES
    ratios = compmat(:,2)./compmat(:,1);
    [sortedratios, I] = sortrows(ratios);
    compmat = compmat(I,:);
    crit = ceil(length(compmat)*0.05);
    comptop = compmat(end-crit+1:end,:);
    compmid = compmat(crit+1:end-crit,:);
    compbot = compmat(1:crit,:);
    
    fig = figure;
    
    MAX = max(compmat(:,1)); MIN = min(compmat(:,1)); MIN=0;
    refplt = plot([MIN MAX],[MIN MAX]','LineWidth',0.5,'Color',[0 0 0]);hold on;
    
    plt = plot(comptop(:,1),comptop(:,2),'.',compmid(:,1),compmid(:,2),'.',compbot(:,1),compbot(:,2),'.','MarkerSize',5); hold on;
    plt(1).Color = '#D95319'; plt(2).Color = '#0072BD'; plt(3).Color = '#EDB120';
    
    topplt = plot(topOBS{2},topOBS{3},'x',topEXP{2},topEXP{3},'+','LineWidth',1,'MarkerSize',5);
    topplt(1).Color = [.4 .4 .4]; topplt(2).Color = [.4 .4 .4];
    topplt(1).Color = '#D95319'; topplt(2).Color = '#0072BD';

    ax = gca; ax.TickLabelInterpreter='latex';
    grid on
    title(['P-vals for Paired SNPs (ATLAS-' ATLASids{i} ')'],'Interpreter','latex','FontSize',20);
    xlabel('$-log_{10}\big[\,{\rm P}({\bf snp}_1)\times {\rm P}({\bf snp}_2)\,\big]$ ({\bf expected})','Interpreter','latex','FontSize',16); 
    ylabel('$-log_{10}\big[\,{\rm P}({\bf snp}_1\cup {\bf snp}_2)\,\big]$ ({\bf observed})','Interpreter','latex','FontSize',16);
    
    leg = legend([plt;topplt],{'Upper 2.5\%' 'Mid Range' 'Lower 2.5\%' 'Max Observed Value' 'Max Expected Value'},'Location','northwest','Interpreter','latex','FontSize',12);
    
    ax.XLim = [10,55];
    
    exportgraphics(fig,['Results/Results-topsnps' num2str(length(SNPloc)) 'c2_ATLAS-' ATLASids{i} '.pdf'],'ContentType','vector')
end

