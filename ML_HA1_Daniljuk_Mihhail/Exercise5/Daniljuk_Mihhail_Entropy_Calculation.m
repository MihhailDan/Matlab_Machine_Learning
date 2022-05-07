% Function computes entropy for 2 subsets and adds them
function value = Daniljuk_Mihhail_Entropy_Calculation(ss1,ss2)

uni_SS1 = unique(ss1(:,2));
uni_SS2 = unique(ss2(:,2));

% Computing entropy for first subset
for k=1:length(uni_SS1)
    class_costs_ss1(k) = length(find(ss1(:,2) == uni_SS1(k,1))) / length(ss1);
end
vSumSS1 = 0;
for l=class_costs_ss1
    vSumSS1 = vSumSS1 + l * log2(l);
end
vSumSS1 = -1 * vSumSS1;

% Computing entropy for second subset
for k=1:length(uni_SS2)
    class_costs_ss2(k) = length(find(ss2(:,2) == uni_SS2(k,1))) / length(ss2);
end
vSumSS2 = 0;
for l=class_costs_ss2
    vSumSS2 = vSumSS2 + l * log2(l);
end
vSumSS2 = -1 * vSumSS2;


splitEntropy = vSumSS1 + vSumSS2;
value = splitEntropy;
end
