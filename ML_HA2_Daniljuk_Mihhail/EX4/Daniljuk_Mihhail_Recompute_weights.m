function new_set = Daniljuk_Mihhail_Recompute_weights(miss, corr, AoS)

    miss(:,4) = miss(:,4) .* exp(AoS);
    corr(:,4) = corr(:,4) .* exp(-1*AoS);
    new_set = [miss; corr];
    new_set(:,4) = new_set(:,4) ./ sum(new_set(:,4));

end