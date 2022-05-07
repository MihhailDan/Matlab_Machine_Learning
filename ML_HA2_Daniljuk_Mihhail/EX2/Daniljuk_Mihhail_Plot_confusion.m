function Daniljuk_Mihhail_Plot_confusion(predict, valid, count)
    fh(count) = figure(count);
    clf(count);
    c = confusionmat(predict, valid);
    confusionchart(c);
    title("Confusion matrix");
    saveas(fh(count), "Confusion.png");
end