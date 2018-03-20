clear;
data=load('ckd1.mat');
X_training=data.ckd1([1:200,251:350],1:24);
X_test=data.ckd1([201:250,351:400],1:24);
y_training=data.ckd1([1:200,251:350],25);
y_test=data.ckd1([201:250,351:400],25);


%% ============ Part 2: Compute Cost and Gradient ============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in 
%  costFunction.m

%  Setup the data matrix appropriately, and add ones for the intercept term
[m,n]=size(X_training);

% Add intercept term to x and X_test
% X_training = [ones(m, 1) X_training];

% Initialize fitting parameters
initial_w=zeros(n,1);
initial_b=0;


% Compute and display cost and gradient with non-zero theta
w=rand(n,1);
b=0;
[J, grad] = costFunction(w,b, X_training, y_training);

%gradient discent
% J=0;
dw=zeros(n,1);
db=0;
alpha=0.01;

%for—≠ª∑
% for i=1:100000
%    Z=X_training*w+b;
%    A=sigmoid(Z);
%    dZ=A-y_training;
%    dw=(X_training'*dZ)/m;
%    db=sum(dZ)/m;
%    w=w-alpha*dw;
%    b=b-alpha*db;
% end

%%while —≠ª∑
num=0;
while 1
   [J, grad] = costFunction(w,b, X_training, y_training);
   Z=X_training*w+b;
   A=sigmoid(Z);
   dZ=A-y_training;
   dw=(X_training'*dZ)/m;
   db=sum(dZ)/m;
   w=w-alpha*dw;
   b=b-alpha*db;
   [J1, grad] = costFunction(w,b, X_training, y_training);
   num=num+1;
   if(abs(J-J1)<0.00001)
       break;
   end
end

%result
N=length(y_test);
Z_test=X_test*w+b;
A_test=sigmoid(Z_test);
result=abs(A_test-y_test);
correct=0;
for i=1:N
    if result(i,:)<0.5
        correct=correct+1;
    end
end
accuracy=correct/N;
   
    








