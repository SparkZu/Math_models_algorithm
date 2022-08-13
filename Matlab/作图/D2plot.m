%% 展示
%复数
figure(1)
 x=rand(1,100)*1+rand(1,100)*1i;
 plot(x,'g.')
%网络图
D=repmat(x,100,1)-repmat(x.',1,100);
D=abs(D);
[Is,Js]=find(D<0.2);
plot([x(Is);x(Js)]);
%% plot与fplot

t=linspace(1,100,101);
t_1=logspace(-6,1,100);%10e-6
figure(1)
subplot(1,4,1)
plot(t,sin(t))
subplot(1,4,2)
plot(t_1,sin(t_1))
subplot(1,4,3)
plot(t,cos(t))
subplot(1,4,4)
plot(t_1,cos(t_1))

%% fplot
subplot(2,1,1)
fplot(@(x)sin(x),[1,100],'b.--');
subplot(2,1,2)
fplot(@(t)t.*sin(t),@(t)t.*cos(t),[0,2*pi],'-')
%% seimlogy
% semilogx(x1,y1,'参数',x2,y2,'参数'...)
% 
% semilogy(x1,y1,'参数,x2,y2','参数'...)
% 
% loglog(x1,y1,'参数',x2,y2,'参数'...)
% 
% 其中，semilogx函数x轴为常用对数刻度，y轴为线性刻度；semilogy函数x轴为线性刻度，y轴为常用对数刻度；loglog函数x轴和y轴均采用常用对数刻度。
subplot(1,3,1)
semilogx([1:20],exp([1:20]))
subplot(1,3,2)
semilogy([1:20],exp([1:20]))
subplot(1,3,3)
loglog([1:20],exp([1:20]))
%% 极坐标图
% polar(theta,rho,'参数')
% 
% 其中，theta为极角，rho为极径，参数内容与plot相同。
theta=linspace(0,2*pi,200);
r=4;
polar(theta,r*cos(theta),'b-')
%% 带有梯度的
clear

[x, y, z]=peaks(30);
[dx ,dy]=gradient(z,.1,.1);
hold on
contour(x,y,z)
quiver(x,y,dx,dy)
colormap autumn
grid off
hold off