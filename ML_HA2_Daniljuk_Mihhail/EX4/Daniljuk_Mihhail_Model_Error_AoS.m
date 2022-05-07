function [error, amount_of_say] = Daniljuk_Mihhail_Model_Error_AoS(miss)
    error = sum(miss(:,4));
    amount_of_say = (1/2) * log((1 - error)/ error);
end