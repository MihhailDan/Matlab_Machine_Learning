function distances = Daniljuk_Mihhail_Manhat_Dist(neurons, win, radius)
    distances = abs(double(neurons)-double(win));
    distances = sum(distances,2);
    
    distances = distances ./ (radius^2);
    distances = exp(-distances);
end