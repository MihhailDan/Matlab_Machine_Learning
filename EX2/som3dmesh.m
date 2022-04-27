clc
clear all
close all
key=1; % 1-sphere 2-cone 3-cylinder
switch key
    case 1
        %==========sphere========
        n=1000;
        theta = 2*pi*rand(1,n);
        phi = asin(2*rand(1,n)-1);
        [x,y,z]=sph2cart(theta,phi,ones(1,n));
        %=======================
    case 2
        %=========cone==========
        A=rand(3,1000);
        H= 1;
        R= 1;
        h= H.*A(1,1:end);
        H= H* ones(size(h));
        R= R* ones(size(h));
        r= (R/H).*(H-h);
        P= (2*pi).*A(2,1:end);
        x= r.*cos(P);
        y= r.*sin(P);
        z=h;
        %=======================
    case 3
        %=========cylinder======
        A=rand(2,1000);
        R= 1;
        H= 1;
        P=(2*pi).*A(1,1:end);
        x= R.*cos(P);
        y= R.*sin(P);
        z= H.*A(2,1:end);
        %=======================
end
 
x1=x;
x2=y;
x3=z;
 
for j1=1:10
    for j2=1:10
        w1(j1,j2)=rand*(0.52-0.48)+0.48;
        w2(j1,j2)=rand*(0.52-0.48)+0.48;
        w3(j1,j2)=rand*(0.52-0.48)+0.48;
    end
end
vv=1;

%=====================
 
no=1;
do=5;
T=300;
t=1;
while (t<=T)
    n=no*(1-t/T);
    d=round(do*(1-t/T));
    %loop for the 1000 inputs
    for i=1:1000
        e_norm=(x1(i)-w1).^2+(x2(i)-w2).^2+(x3(i)-w3).^2;
        minj1=1;minj2=1;
        min_norm=e_norm(minj1,minj2);
        for j1=1:10
            for j2=1:10
                if  e_norm(j1,j2)<min_norm
                    min_norm=e_norm(j1,j2);
                    minj1=j1;
                    minj2=j2;
                end
            end
        end
        j1star=  minj1;
        j2star=  minj2;
        
        
        %update the winning neuron
        w1(j1star,j2star)=w1(j1star,j2star)+n*(x1(i)-w1(j1star,j2star));
        w2(j1star,j2star)=w2(j1star,j2star)+n*(x2(i)-w2(j1star,j2star));
        w3(j1star,j2star)=w3(j1star,j2star)+n*(x3(i)-w3(j1star,j2star));
        
        %update the neighbour neurons
        
        for dd=1:1:d
            
            jj1=j1star-dd;
            jj2=j2star;
            if (jj1>=1)
                w1(jj1,jj2)=w1(jj1,jj2)+n*(x1(i)-w1(jj1,jj2));
                w2(jj1,jj2)=w2(jj1,jj2)+n*(x2(i)-w2(jj1,jj2));
                w3(jj1,jj2)=w3(jj1,jj2)+n*(x3(i)-w3(jj1,jj2));
            end
            
            jj1=j1star+dd;
            jj2=j2star;
            if (jj1<=10)
                w1(jj1,jj2)=w1(jj1,jj2)+n*(x1(i)-w1(jj1,jj2));
                w2(jj1,jj2)=w2(jj1,jj2)+n*(x2(i)-w2(jj1,jj2));
                w3(jj1,jj2)=w3(jj1,jj2)+n*(x3(i)-w3(jj1,jj2));
            end
            
            jj1=j1star;
            jj2=j2star-dd;
            if (jj2>=1)
                w1(jj1,jj2)=w1(jj1,jj2)+n*(x1(i)-w1(jj1,jj2));
                w2(jj1,jj2)=w2(jj1,jj2)+n*(x2(i)-w2(jj1,jj2));
                w3(jj1,jj2)=w3(jj1,jj2)+n*(x3(i)-w3(jj1,jj2));
            end
            
            jj1=j1star;
            jj2=j2star+dd;
            if (jj2<=10)
                w1(jj1,jj2)=w1(jj1,jj2)+n*(x1(i)-w1(jj1,jj2));
                w2(jj1,jj2)=w2(jj1,jj2)+n*(x2(i)-w2(jj1,jj2));
                w3(jj1,jj2)=w3(jj1,jj2)+n*(x3(i)-w3(jj1,jj2));
            end
        end
    end
    t=t+1;
    
    
    %======drawing==========
    figure(1)
    plot3(x1,x2,x3,'.b')
    hold on
    plot3(w1,w2,w3,'or')
    surf(w1,w2,w3,'FaceColor','interp',...
        'EdgeColor','k',...
        'FaceLighting','phong','linewidth',2)
    axis square
    view(vv,35)
    vv=vv+1;
    camlight left
    hold off
    title(['t=' num2str(t)])
    drawnow
    %=====================
end
 
for zz=1:200
    %======drawing==========
    figure(1)
    plot3(x1,x2,x3,'.b')
    hold on
    plot3(w1,w2,w3,'or')
    surf(w1,w2,w3,'FaceColor','interp',...
        'EdgeColor','k',...
        'FaceLighting','phong','linewidth',2)
    axis square
    view(vv,35)
    vv=vv+1;
    camlight left
    hold off
    title(['t=' num2str(t)])
    drawnow
    %=====================
end
