function learning_rate = Daniljuk_Mihhail_Learning_rate_Decay(lrate_initial, t, tau1)
    learning_rate = lrate_initial*exp(-t/tau1);
end