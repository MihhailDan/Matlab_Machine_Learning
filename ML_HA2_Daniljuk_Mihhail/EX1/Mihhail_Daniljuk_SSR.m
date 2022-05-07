function value = Mihhail_Daniljuk_SSR(Y_hat, Y)

    value = sum((Y_hat - Mihhail_Daniljuk_mean(Y)).^2); 
end