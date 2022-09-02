%% 
clc
clear all;
n=200;
Se=zeros(n); 
Z=zeros(n)
Se(n/2-2:n/2+2,n/2-2:n/2+2)=1;  %初始化中心几个点为1。
Ch=imagesc(cat(3,Se,Z,Z));  % 生成图像，cat函数用来改变颜色，美化图像
axis square                % 增加边框
Sd=zeros(n+2);           % Sd代表包含虚拟邻居的网格图
while(1)
    Sd(2:n+1,2:n+1)=Se;
    % 制定相应变化规则
    sum=Sd(1:n,2:n+1)+Sd(3:n+2,2:n+1)+Sd(2:n+1,1:n)+Sd(2:n+1,3:n+2);
    Se=mod(sum,2);
    % 更新地图点
    set(Ch,'cdata',cat(3,Se,Z,Z)) 
    pause(0.05)
end
   figure

%% 手写了
clc,clear;
n=200;
Se=zeros(n);
z=zeros(n);
Se(n/2-2:n/2+1,n/2-2:n/2+2)=1;
Ch=imagesc(cat(3,Se,z,z));
axis square;
Sd=zeros(n+2)
while(1)
    Sd(2:n+1,2:n+1)=Se;
    sum=Sd(1:n,2:n+1)+Sd(2:n+1,1:n)+Sd(2:n+1,3:n+2)+Sd(3:n+2,2:n+1);
    Se=mod(sum,2);
    set(Ch,'cdata',cat(3,Se,z,z));
    pause(0.03)
end
%% 生命游戏
clc,clear;
n=200;
p=0.4;
z=zeros(n);
Se=rand(n)<p;
Sd=zeros(n+2);
Ph=image(cat(3,z,Se,z));
while(1)
    Sd(2:n+1,2:n+1)=Se;
    Sum=Sd(1:n,2:n+1)+Sd(3:n+2,2:n+1)+Sd(2:n+1,1:n)+Sd(2:n+1,3:n+2);
    for i=1:n
        for j=1:n
            if Sum(i,j)==3||(Sum(i,j)==2&&Se(i,j)==1)
                Se(i,j)=1;
            else
                Se(i,j)=0;
            end
        end
    end
    set(Ph,'cdata',cat(3,z,Se,z))
    pause(0.03)
    drawnow
end
%% 澳洲火灾

clc,clear;
n=300;
plight=1e-5;
pgrow=1e-3;
z=zeros(n);
ul=[n,1:n-1]
dr=[2:n,1];
imh=image(cat(3,z,z,z));
axis equal
%空地为0，着火为1，树为2
while(1)
    sum=(z(ul,:)==1)+(z(dr,:)==1)+(z(:,ul)==1)+(z(:,dr)==1);
    z=2*(z==2)-((z==2)&(sum>0|(rand(n)<plight))) +2*((z==0)&(rand(n)<pgrow));
    set(imh,'cdata',cat(3,z==1,z==2,zeros(n)));
    drawnow

end
%% 




















