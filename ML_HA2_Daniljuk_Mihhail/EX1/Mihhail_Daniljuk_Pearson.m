function value = Mihhail_Daniljuk_Pearson(feat1, feat2)

    feat1_mean = Mihhail_Daniljuk_mean(feat1);
    feat2_mean = Mihhail_Daniljuk_mean(feat2);
    
    numerator = sum((feat1 - feat1_mean) .* (feat2 - feat2_mean));
    denom = sum((feat1 - feat1_mean).^ 2) * sum((feat2 - feat2_mean).^2);
    denom = sqrt(denom);
    
    value = numerator / denom;

end 