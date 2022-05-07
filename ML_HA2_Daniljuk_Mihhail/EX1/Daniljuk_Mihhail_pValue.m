function [pvalue,tstat] = Daniljuk_Mihhail_pValue(feat1, feat2)

    corr = Mihhail_Daniljuk_Pearson(feat1, feat2);
	[rows, ~] = size(feat1);

	tstat = corr * sqrt((rows-2) / (1-corr^2));

	s = tcdf(tstat, rows-2);
    
	pvalue = 2*min(s, 1-s);
end