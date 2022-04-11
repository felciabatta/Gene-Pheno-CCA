function image = visualiseResults(results)
%VISUALISERESULTS Only for visualising duo-SNP results
%   Detailed explanation goes here

if length(results(2,1)) == 2

    resultsMat = NaN(length(mySNPs));
    h = length(mySNPs)-1:-1:1;
    triN = @(n) n*(n+1)/2;
    for i = h
        resultsMat(end-i+1:end,18-i) = cell2mat(results(((triN(17)-triN(i)+1):(triN(17)-triN(i-1)))+1,end));
    end

    resultsMat = resultsMat;

    rMt = resultsMat';
    resultsMat(~isnan(resultsMat)') = rMt(~isnan(rMt));

    image = imagesc(resultsMat);
else
    fprintf('Cannot visualise this result <(;-;)>');
    image = NaN;
end

end

