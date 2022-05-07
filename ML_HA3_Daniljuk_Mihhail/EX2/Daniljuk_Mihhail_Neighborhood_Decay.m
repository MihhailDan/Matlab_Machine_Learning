function neighborhood = Daniljuk_Mihhail_Neighborhood_Decay(neighbor_init, t, tau2)
    neighborhood = neighbor_init * exp(-t/tau2);
end