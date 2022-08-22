%% 求解偏微分方程
g='circleg';
b='circleb1';
c=1;
a=0;
f=1;
%产生初始的三角形网格
[p,e,t]=initmesh(g);
error=[];
err=1;
while err>0.01
    [p,e,t]=refinemesh(g,p,e,t);
    u=assempde(b,p,e,t,c,a,f);
    exact=(1-p(1,:).^2-p(2,:).^2)/4;
    err=norm(u-exact',"inf");
    error=[error err];
end
subplot(2,2,1),pdemesh(p,e,t);
subplot(2,2,2),pdesurf(p,t,u);
subplot(2,2,3),pdesurf(p,t,u-exact')

%% 使用solvepde
model=createpde();
geometryFromEdges(model,@lshapeg)
%% parabolic
g='squareg'
b='squareb1'
c=2;
a=1;
f=1;
d=1;
[p,e,t]=initmesh(g);
u0=zeros(size(p,2),1);
ix=find(sqrt(p(1,:).^2+p(2,:).^2)<0.4);
u0(ix)=1;
nframe=20;
tlist=linspace(0,0.1,nframe);
u1=parabolic(u0,tlist,b,p,e,t,c,a,f,d);
for j=1:nframe
    pdesurf(p,t,u1(:,j))
end

%% 双曲线型方程
%hyperbolic
g='squareg';
b='squareb3';
c=1;
a=0;
f=0;
d=1;
[p,e,t]=initmesh(g);
x=p(1,:)';
y=p(2,:)';
u0=atan(cos(pi*x));
ut0=3*sin(pi*x).*exp(cos(pi*y));
n=31;
tlist=linspace(0,5,n);
uu=hyperbolic(u0,ut0,tlist,b,p,e,t,c,a,f,d);
for j=1:n
    pdesurf(p,t,uu(:,j));
    %mv(j)=getframe;
end
% movie(mv,20)

%% 
























