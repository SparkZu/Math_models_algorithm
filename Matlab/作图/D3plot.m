%% 绘制三视图
clc, clear;
t = linspace(0, 10 * pi, 1000);
xt = exp(t ./ 10) .* sin(3 .* t);
yt = exp(t ./ 10) .* cos(3 .* t);
P = plot3(xt, t, yt, '-', 'color', 'k', 'Linewidth', 1.5);

