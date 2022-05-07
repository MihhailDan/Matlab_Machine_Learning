function value = Mihhail_Daniljuk_F_Test(b, y_hat, y)

    sample_size = size(y,1);
    var_num = size(b,1);
    SSR = Mihhail_Daniljuk_SSR(y_hat, y);
    RSS = Mihhail_Daniljuk_RSS(y,y_hat);
    
    F_test_num = SSR/ (var_num - 1);
    F_test_denom = RSS / (sample_size - var_num);
    
    value = F_test_num / F_test_denom;

end