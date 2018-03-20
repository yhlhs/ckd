clear;
data=load('ckd.mat');
X=data.ckd(:,1:24);
y=data.ckd(:,25);
z=data.ckd;
k=6;
N=400;
[m,n]=size(X);

%select the first variable
I_xy=zeros(1,24);
k_th=zeros(m,n);
nx=zeros(N,24);
ny=zeros(N,24);
for i=1:n
    d=zeros(m,1);
    for j=1:m
        for p=1:m
            d(p,:)=norm(z(j,[i,25])-z(p,[i,25]),inf);
            d_sorted=sort(d);
            k_th(j,i)=d_sorted(k+1,:);
        end
    end
end
for i=1:n
    for j=1:m
        numx=0;
        numy=0;
        for p=1:m
            if norm(X(p,i)-X(j,i),inf)<k_th(j,i)
                numx=numx+1;
            end
            if norm(y(p)-y(j),inf)<k_th(j,i)
                numy=numy+1;
            end
            numx=numx-1;
            numy=numy-1;
            nx(j,i)=numx;
            ny(j,i)=numy;
        end
    end
end

for i=1:24
    I_xy(1,i)=digamma(k)+digamma(N)-sum(digamma(nx(:,i)+1)+digamma(ny(:,i)+1))/N;
end





