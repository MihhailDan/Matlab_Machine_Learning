% Funcction decides what to do in cases of trueBranhc and falseBranch
function [trueBr, falseBr] = Daniljuk_Mihhail_Defining_True_False(ss1,ss2,count,featureNumber)

uni_SS1 = unique(ss1(:,2));
uni_SS2 = unique(ss2(:,2));

if count ~= featureNumber
    if length(uni_SS1) == 1
        trueBranch = ss1(1,2);
        if length(uni_SS2) == 1
            falseBranch = ss2(1,2);
        else
            falseBranch = 0;
        end
    else
        trueBranch = 0;
        if length(uni_SS2) == 1
            falseBranch = ss2(1,2);
        else
            falseBranch = 0;
        end
    end
else
    if length(uni_SS1) == 1
        trueBranch = ss1(1,2);
        if length(uni_SS2) == 1
            falseBranch = ss2(1,2);
        else
            falseBranch = mode(ss2(:,2));
        end
    else
        trueBranch = mode(ss1(:,2));
        if length(uni_SS2) == 1
            falseBranch = ss2(1,2);
        else
            falseBranch = mode(ss2(:,2));
        end
    end
end

trueBr = trueBranch;
falseBr = falseBranch;

end
