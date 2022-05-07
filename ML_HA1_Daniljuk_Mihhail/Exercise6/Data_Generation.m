clear
clc
rng(123)

n = 300;
feature_num = 8;

mean1 = repmat(5,feature_num,1);
mean2 = repmat(0, feature_num,1);

for i =1:feature_num
    for j=1:feature_num
        sigmas1(i,j) = normrnd(2,4);
        sigmas2(i,j) = normrnd(3,2);
    end
end
sigmas1 = sigmas1 * sigmas1';
sigmas2 = sigmas2 * sigmas2';

fst_set = mvnrnd(mean1',sigmas1,n);
snd_set = mvnrnd(mean2',sigmas2,n);

labels = [ones(n,1); ones(n,1)*2];
ds = [fst_set;snd_set];
ds_labeled = [ds, labels];

DS = ds_labeled(randperm(size(ds_labeled, 1)), :);

save("DS.mat", "DS");