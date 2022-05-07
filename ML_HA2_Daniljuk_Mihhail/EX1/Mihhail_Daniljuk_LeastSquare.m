function [value] = Mihhail_Daniljuk_LeastSquare(X, Y)
    
    value = inv(X'*X)*X'*Y;
end