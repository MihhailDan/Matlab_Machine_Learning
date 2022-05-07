function value = Mihhail_Daniljuk_F_Stat(RSS_prev, RSS, sample_size, sz)

    F_stat_num = (RSS_prev - RSS) / 1;
    F_stat_denom = (RSS / (sample_size - sz - 1));
    value = F_stat_num / F_stat_denom;

end