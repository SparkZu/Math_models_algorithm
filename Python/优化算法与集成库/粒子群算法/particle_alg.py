import numpy as np
import matplotlib.pyplot as plt
import random


# 定义“粒子”类
class parti(object):

    def __init__(self, v, x):
        self.v = v  # 粒子当前速度
        self.x = x  # 粒子当前位置
        self.pbest = x  # 粒子历史最优位置


class PSO(object):

    def __init__(self,
                 interval,
                 tab='min',
                 partisNum=10,
                 iterMax=1000,
                 w=1,
                 c1=2,
                 c2=2):
        self.interval = interval  # 给定状态空间 - 即待求解空间
        self.tab = tab.strip()  # 求解最大值还是最小值的标签: 'min' - 最小值；'max' - 最大值
        self.iterMax = iterMax  # 迭代求解次数
        self.w = w  # 惯性因子
        self.c1, self.c2 = c1, c2  # 学习因子
        self.v_max = (interval[1] - interval[0]) * 0.1  # 设置最大迁移速度
        #####################################################################
        self.partis_list, self.gbest = self.initPartis(
            partisNum)  # 完成粒子群的初始化，并提取群体历史最优位置
        self.x_seeds = np.array(list(
            parti_.x for parti_ in self.partis_list))  # 提取粒子群的种子状态 ###
        self.solve()  # 完成主体的求解过程
        self.display()  # 数据可视化展示

    def initPartis(self, partisNum):
        partis_list = list()  #list结构
        for i in range(partisNum):  #初始化粒子
            v_seed = random.uniform(-self.v_max, self.v_max)
            x_seed = random.uniform(*self.interval)
            partis_list.append(parti(v_seed, x_seed))  #加入生成的粒子
        temp = 'find_' + self.tab
        if hasattr(self, temp):  # 采用反射方法提取对应的函数
            gbest = getattr(self, temp)(partis_list)
        else:
            exit('>>>tab标签传参有误："min"|"max"<<<')
        return partis_list, gbest

    def solve(self):
        for i in range(self.iterMax):
            for parti_c in self.partis_list:
                f1 = self.func(parti_c.x)
                # 更新粒子速度，并限制在最大迁移速度之内
                parti_c.v = self.w * parti_c.v + self.c1 * random.random() * (
                    parti_c.pbest - parti_c.x) + self.c2 * random.random() * (
                        self.gbest - parti_c.x)
                if parti_c.v > self.v_max: parti_c.v = self.v_max
                elif parti_c.v < -self.v_max: parti_c.v = -self.v_max
                # 更新粒子位置，并限制在待解空间之内
                if self.interval[0] <= parti_c.x + parti_c.v <= self.interval[
                        1]:
                    parti_c.x = parti_c.x + parti_c.v
                else:
                    parti_c.x = parti_c.x - parti_c.v
                f2 = self.func(parti_c.x)
                getattr(self,
                        'deal_' + self.tab)(f1, f2,
                                            parti_c)  # 更新粒子历史最优位置与群体历史最优位置

    def func(self, x):  # 状态产生函数 - 即待求解函数
        value = np.sin(x**2) * (x**2 - 5 * x)
        return value

    def find_min(self, partis_list):  # 按状态函数最小值找到粒子群初始化的历史最优位置
        parti = min(partis_list, key=lambda parti: self.func(parti.pbest))
        return parti.pbest

    def find_max(self, partis_list):
        parti = max(partis_list, key=lambda parti: self.func(parti.pbest)
                    )  # 按状态函数最大值找到粒子群初始化的历史最优位置
        return parti.pbest

    def deal_min(self, f1, f2, parti_):
        if f2 < f1:  # 更新粒子历史最优位置
            parti_.pbest = parti_.x
        if f2 < self.func(self.gbest):
            self.gbest = parti_.x  # 更新群体历史最优位置

    def deal_max(self, f1, f2, parti_):
        if f2 > f1:  # 更新粒子历史最优位置
            parti_.pbest = parti_.x
        if f2 > self.func(self.gbest):
            self.gbest = parti_.x  # 更新群体历史最优位置

    def display(self):
        print('solution: {}'.format(self.gbest))
        plt.figure(figsize=(8, 4))
        x = np.linspace(self.interval[0], self.interval[1], 300)
        y = self.func(x)
        plt.plot(x, y, 'g-', label='function')
        plt.plot(self.x_seeds, self.func(self.x_seeds), 'b.', label='seeds')
        plt.plot(self.gbest, self.func(self.gbest), 'r*', label='solution')
        plt.xlabel('x')
        plt.ylabel('f(x)')
        plt.title('solution = {}'.format(self.gbest))
        plt.legend()
        plt.savefig('PSO.png', dpi=500)
        plt.show()
        plt.close()


if __name__ == '__main__':
    PSO([-9, 5], 'min')

# class parti(object):
#     def __init__(self,interval,tab='min',partiNum=10,iterMax=1000) -> None:
#         self.interval=interval
#         self.tab=tab
#         self.iterMax=iterMax
#         self.w=w