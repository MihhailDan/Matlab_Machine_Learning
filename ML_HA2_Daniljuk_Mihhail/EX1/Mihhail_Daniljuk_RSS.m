function value = Mihhail_Daniljuk_RSS(Y, y_hat)

    value = sum((Y - y_hat).^2);
end