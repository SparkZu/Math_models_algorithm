function dx= fun_ode_1(t,x)
%FUN_ODE_1 此处显示有关此函数的摘要
%   此处显示详细说明
sigma1=0.02;
sigma2=2;
r1=0.5;
r2=0.2;
N1=300;
N2=500;
dx=zeros(2,1);
dx(1)=r1*x(1)*( 1-x(1)/N1+sigma1*x(2)/N2);
dx(2)=r2*x(2)*(-1-x(2)/N2+sigma2*x(1)/N1);
end

