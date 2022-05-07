% First task, Linear regression
clc
clear
rng(1);

% Initializing variables and creating dataset
range_of_values = 20;
level_of_significance = 0.05;
n_dim = 11;
sample_size = 500;
X = unifrnd(0,range_of_values,[sample_size, n_dim]);

% Generating dependent variable
Y = 5 * X(:,1) + 4*X(:,4) - 3*X(:,6) +0.5* X(:,11) + unifrnd(0,range_of_values,[sample_size,1]);
Y_mean = Mihhail_Daniljuk_mean(Y);


% Finding correlations between Y and all other features, sorting them
for i = 1:n_dim
    corr_XY(i) = abs(Mihhail_Daniljuk_Pearson(X(:,i), Y));
end
corr_sorted = sort(corr_XY,"descend");


% Initializing variables for loop
R_sq = 0;
i = 1;
RSS_prev = 0;
b_estimate_prev = 0;
F_prev = 0;
coeffs_prev = [0];
sub_set = ones(sample_size,1);
while R_sq <= 0.98 && i <= n_dim


    % Selecting feature with the greatest correlation value so our model will
    % always chose the best feature to add
    col_num = find(corr_XY == corr_sorted(i));
    sub_set = [sub_set, X(:,col_num)];


    % Applying least square method to get coefficients and computing predicted
    % values with them
    b_estimate = Mihhail_Daniljuk_LeastSquare(sub_set,Y);
    y_hat = Mihhail_Daniljuk_predict_yHat(b_estimate, sub_set);
    coeffs = [coeffs_prev; col_num];


    % Computing different types of model validation parameters
    SSR = Mihhail_Daniljuk_SSR(y_hat, Y);
    SST = Mihhail_Daniljuk_SST(Y);
    RSS = Mihhail_Daniljuk_RSS(Y,y_hat);
    R_sq = Mihhail_Daniljuk_Determ_coeff(Y,y_hat);


    % Computing F-test to check if model is significant
    F_test = Mihhail_Daniljuk_F_Test(b_estimate,y_hat,Y);
    F_reject = finv(1-level_of_significance, size(b_estimate,1) - 1, sample_size-size(b_estimate,1));
    if F_test < F_reject
        sub_set = sub_set(:,1:end-1);
        b_estimate = b_estimate_prev;
        F_test = F_prev;
        coeffs = coeffs_prev;
        i = i + 1;
        continue;
    end


    % Computiing t_stats, and pValues 
    for o = 1:size(sub_set,2)
        [pValue(o),tstats(o)] = Daniljuk_Mihhail_pValue(sub_set(:,o),Y);
    end
    
    
    % Starting from second iteration comparing twqo models and doing check if
    % complicated model justified.
    if i >= 2
        F_stat = Mihhail_Daniljuk_F_Stat(RSS_prev, RSS, sample_size, size(b_estimate,1));
        F_reject_stat = finv(1-level_of_significance, 1, sample_size-size(b_estimate,1)-1);
        if F_stat < F_reject_stat
            sub_set = sub_set(:,1:end-1);
            b_estimate = b_estimate_prev;
            F_test = F_prev;
            coeffs = coeffs_prev;
            i = i + 1;
            continue;
        end
    end


    % Updating variables to use in the next iteration
    RSS_prev = RSS;
    b_estimate_prev = b_estimate;
    coeffs_prev = coeffs;
    F_prev = F_test;
    i = i + 1;
end


% Returning the coefficients of the model, first column is coefficient
% itself, second column is feature number(0 - intercept)
results = [coeffs, b_estimate, tstats', pValue'];


% Plotting table and saving it as png file
fh(1) = figure(1);
clf(fh(1));
col = {"x_n", "value","t_stat", "p_value"};
uit = uitable("ColumnName", col,"Data", results, "Position", [0,0,332,112]);

% saveas(uit, "table.png");