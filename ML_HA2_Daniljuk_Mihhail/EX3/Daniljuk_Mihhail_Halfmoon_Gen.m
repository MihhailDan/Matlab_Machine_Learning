% Function was provided by Sven Nomm

clear
clc
rng(1);

stepS = 0.1;

t=-4:stepS:4;
tLength = length(t);
thicknes = 10;


DS1=[];
for i=1:tLength
    tSlice = rand(thicknes,2)*1.2;
    x(1:thicknes,1)=tSlice(:,1)+t(i)+1;
    y(1:thicknes,1)=-tSlice(:,2)+t(i)^2-13;
    DS1 = [DS1;x,y];
end

DS2=[];
for i=1:tLength
    tSlice = rand(thicknes,2)*0.9;
    x(1:thicknes,1)=tSlice(:,1)+t(i)-2.5;
    y(1:thicknes,1)=tSlice(:,2)-t(i)^2+13;
    DS2 = [DS2;x,y];
end

fh(2)=figure(2);
clf(fh(2))
scatter(DS1(:,1),DS1(:,2))
grid on
hold on
scatter(DS2(:,1),DS2(:,2))
hold on
    

DS1 = [DS1, ones(size(DS1,1),1)];
DS2 = [DS2, ones(size(DS2,1),1).*2];

DS=[DS1;DS2];

DS = DS(randperm(size(DS, 1)), :);
save("DS.mat", "DS");