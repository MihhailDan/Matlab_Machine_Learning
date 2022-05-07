function value = Mihhail_Daniljuk_Determ_coeff(y, y_hat)

    SSR = Mihhail_Daniljuk_SSR(y_hat, y);
    SST = Mihhail_Daniljuk_SST(y);
    
    value = SSR / SST;
end