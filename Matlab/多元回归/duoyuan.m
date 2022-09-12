%% 多元线性

%[b,bint,r,rint,stats] = regress(y, X,alpha)
%数据
x=[143 145 146 147 149 150 153 154 155 156 157 158 159 160 162 164]';
X=[ones(16,1) x];
Y=[88 85 88 91 92 93 93 95 96 98 97 96 98 99 100 102]';

%2．回归分析及检验:
[b,bint,r,rint,stats]=regress(Y,X)
b,bint,stats
%% 残差分析
rcoplot(r,rint)
z=b(1)+b(2)*x
plot(x,Y,'k+',x,z,'r')

%% 一元多项式回归
% [p,S]=polyfit(x,y,m)


%% 多元二项式回归
% rstool(x,y,'model',alpha=0.05)
% model 
%  linear purequadratic interaction(交叉） quadratic(完全二次）

x1=[1000 600 1200 500 300 400 1300 1100 1300 300 ] ;
x2=[5 7 6 6 8 7 5 4 3 9];
y=[100 75 80 70 50 65 90 100 110 60 ]';
x=[x1' x2'];
rstool(x, y, 'purequadratic')

%% 
rstool()


