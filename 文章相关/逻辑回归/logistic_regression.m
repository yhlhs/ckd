clc;clear;
%%
%�߼��ع�
x=xlsread('��������.xls');
y=xlsread('�������.xls');%0��1
b =glmfit(x,y,'binomial', 'link', 'logit');%�߼��ع鷽��; b�����߼��ع鷽�̵�ϵ��
p = glmval(b,x, 'logit');%p�����߼��ع�Ԥ��ֵ������ֵ0��1);
plot(x,p,'o');%����Ԥ��ֵ�����߼��ع鷽�̵�ɢ��ͼ
%%
%����ģ��
set_data1=[x,p];
%Ԥ��ֵ�д���0.5�Ŀ�Ϊ1�࣬С�ڻ����0.5�Ŀ�Ϊ0�ࣻ
y1=set_data1(:,2)>0.5;%�߼�����
set_data2=[x,y1];
hold on
plot(set_data2(:,1),set_data2(:,2),'or')
%ģ��Ԥ��׼ȷ��
cp=sum(y==y1)/19889;