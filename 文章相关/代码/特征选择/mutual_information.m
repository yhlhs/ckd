clear;
data=load('ckd.mat');
X=data.ckd(:,1:24);
y=data.ckd(:,25);
z=data.ckd;

%%%%%%%%%%%%离散型变量转换成连续型变量分布%%%%%%%%
N=400;
X_process=X;
X_process(:,[3:9,19:24])=X_process(:,[3:9,19:24])+(2*rand(N,13)-1);
%%%归一化处理
[m,n]=size(X);
for i=1:n
    X_process(:,i)=(X(:,i)-min(X_process(:,i)))/(max(X_process(:,i))-min(X_process(:,i)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i=MIcalculator(X_process,y,6);



%%%%%%%%%%%%%%%输出变量的概率分布%%%%%%%%%%%%%%%%%%
N=400;
P_y=zeros(2,1);
N_y1=0;
N_y2=0;
for i=1:400
    if y(i)==1
        N_y1=N_y1+1;
    end
    if y(i)==0
        N_y2=N_y2+1;
    end
end
p_y1=N_y1/N;
p_y2=N_y2/N;
p_y=[p_y1;p_y2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    

%%%%%%第四个离散型变量概率分布%%%%%%%%%%%%%%%%%%%%%
X4_max=max(X(:,4));
p_X4=zeros(X4_max+1,1);
N_X4=zeros(X4_max+1,1);
for i=1:N
    if X(i,4)==0
        N_X4(1)=N_X4(1)+1;
    end
    if X(i,4)==1
        N_X4(2)=N_X4(2)+1;
    end
    if X(i,4)==2
        N_X4(3)=N_X4(3)+1;
    end
    if X(i,4)==3
        N_X4(4)=N_X4(4)+1;
    end
    if X(i,4)==4
        N_X4(5)=N_X4(5)+1;
    end
    if X(i,4)==X4_max
        N_X4(6)=N_X4(6)+1;
    end
    
end
p_X4=N_X4/N;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%x4变量和输出变量y的联合概率分布%%%%%%%%%%
p_X4y=zeros(X4_max+1,2);
N_X4y=zeros(X4_max+1,2);
for i=1:N
    if X(i,4)==0
        if y(i)==0
        N_X4y(1,1)=N_X4y(1,1)+1;
        else
            N_X4y(1,2)=N_X4y(1,2)+1;
        end
    end
    if X(i,4)==1
        if y(i)==0
        N_X4y(2,1)=N_X4y(2,1)+1;
        else
            N_X4y(2,2)=N_X4y(2,2)+1;
        end
    end
    if X(i,4)==2
        if y(i)==0
        N_X4y(3,1)=N_X4y(3,1)+1;
        else
            N_X4y(3,2)=N_X4y(3,2)+1;
        end
    end
    if X(i,4)==3
        if y(i)==0
        N_X4y(4,1)=N_X4y(4,1)+1;
        else
            N_X4y(4,2)=N_X4y(4,2)+1;
        end
    end
    if X(i,4)==4
        if y(i)==0
        N_X4y(5,1)=N_X4y(5,1)+1;
        else
            N_X4y(5,2)=N_X4y(5,2)+1;
        end
    end
    if X(i,4)==X4_max
        if y(i)==0
        N_X4y(6,1)=N_X4y(6,1)+1;
        else
            N_X4y(6,2)=N_X4y(6,2)+1;
        end
    end
    
end
p_X4y=N_X4y/N;
%%%%%%%%%%%计算x4和y之间的互信息%%%%%%%%%%%%
I_x4y=0;
for i=1:X4_max+1
    for j=1:2
        I_x4y=I_x4y+p_X4y(i,j)*log((p_X4y(i,j))+0.000000000000001/(p_X4(i)*p_y(j)));
    end
end

k=6;
N=400;

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
%             d_sorted=sort(d);
%             k_th(j,i)=d_sorted(k+1,:);
        end
        d_sorted=sort(d);
        k_th(j,i)=d_sorted(k+1,:);
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
%             numx=numx-1;
%             numy=numy-1;
%             nx(j,i)=numx;
%             ny(j,i)=numy;
        end
         numx=numx-1;
         numy=numy-1;
         nx(j,i)=numx;
         ny(j,i)=numy;
    end
end

for i=1:24
    I_xy(1,i)=digamma(k)+digamma(N)-sum(digamma(nx(:,i)+1)+digamma(ny(:,i)+1))/N;
end





