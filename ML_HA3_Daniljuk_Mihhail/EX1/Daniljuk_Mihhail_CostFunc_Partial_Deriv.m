function deriv = Daniljuk_Mihhail_CostFunc_Partial_Deriv(pred, target)
    deriv = 2*(pred - target);
end