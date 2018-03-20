function [ I ] = MIcalculator( x,y,k )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n]=size(x);
distance=zeros(m,1);
k_distance=zeros(m,1);
I_m=zeros(m,1);
Nx=zeros(m,1);
for i=1:250
    Nx(i)=250;
end
for i=251:400
    Nx(i)=150;
end

for i=1:250
    distance=zeros(250,1);
    for j=1:250
        distance(j)=norm(x(i,:)-x(j,:));
    end
    distance_sort=sort(distance);
    %%%%%%重合的点%%%%%%%%%%%%%
%     num1=0;
%     for l=1:250
%         if distance_sort(l)==0
%             num1=num1+1;
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    kth_distance=distance_sort(k+1);
    num=0;
    for p=1:m
        if norm(x(p,:)-x(i,:))<=kth_distance
            num=num+1;
        end
    end
    num=num-1;
    I_m(i)=digamma(m)-digamma(250)+digamma(k)-digamma(num);
    
end

for i=251:400
    distance=zeros(150,1);
    for j=1:150
        distance(j)=norm(x(i,:)-x(j+250,:));
    end
    distance_sort=sort(distance);
    %%%%%%重合的点%%%%%%%%%%%%%
%     num1=0;
%     for l=1:150
%         if distance_sort(l)==0
%             num1=num1+1;
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    kth_distance=distance_sort(k+1);
    num=0;
    for p=1:m
        if norm(x(p,:)-x(i,:))<=kth_distance
            num=num+1;
        end
    end
    num=num-1;
    I_m(i)=digamma(m)-digamma(150)+digamma(k)-digamma(num);
    
end
I=sum(I_m)/m;

end

