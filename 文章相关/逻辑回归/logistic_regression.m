clc;clear;
%%
%逻辑回归
x=xlsread('特征数据.xls');
y=xlsread('类别数据.xls');%0或1
b =glmfit(x,y,'binomial', 'link', 'logit');%逻辑回归方程; b返回逻辑回归方程的系数
p = glmval(b,x, 'logit');%p返回逻辑回归预测值（概率值0到1);
plot(x,p,'o');%根据预测值画出逻辑回归方程的散点图
%%
%测试模型
set_data1=[x,p];
%预测值中大于0.5的看为1类，小于或等于0.5的看为0类；
y1=set_data1(:,2)>0.5;%逻辑矩阵
set_data2=[x,y1];
hold on
plot(set_data2(:,1),set_data2(:,2),'or')
%模型预测准确率
cp=sum(y==y1)/19889;