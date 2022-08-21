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

%% 使用pdesolver
